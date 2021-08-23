// SPDX-License-Identifier: MIT

pragma solidity 0.8.6;

import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

/**
 * @author DefiKingdoms
 * @title TokenVesting
 * @dev A token holder contract that can release its token balance gradually like a
 * typical vesting scheme, with a cliff and vesting period. Optionally revocable by the
 * owner.
 */
contract TokenVesting is AccessControlUpgradeable {
    IERC20Upgradeable private vestingToken;
    uint256 public tokensToVest;
    uint256 private vestingId;

    string private constant INSUFFICIENT_BALANCE = "Insufficient balance";
    string private constant INVALID_VESTING_ID = "Invalid vesting id";
    string private constant VESTING_ALREADY_RELEASED = "Vesting already released";
    string private constant INVALID_BENEFICIARY = "Invalid beneficiary address";
    string private constant NOT_VESTED = "Tokens have not vested yet";

    struct Vesting {
        uint256 releaseTime;
        uint256 amount;
        address beneficiary;
        bool released;
    }
    mapping(uint256 => Vesting) public vestings;

    event TokenVestingReleased(uint256 indexed vestingId, address indexed beneficiary, uint256 amount);
    event TokenVestingAdded(uint256 indexed vestingId, address indexed beneficiary, uint256 amount);
    event TokenVestingRemoved(uint256 indexed vestingId, address indexed beneficiary, uint256 amount);

    function initialize(address admin, IERC20Upgradeable _token) initializer public {
        __AccessControl_init();
        _setupRole(DEFAULT_ADMIN_ROLE, admin);

        require(address(_token) != address(0x0), "Token address is not valid");

        tokensToVest = 0;
        vestingId = 0;

        vestingToken = _token;
    }

    function token() public view returns (IERC20Upgradeable) {
        return vestingToken;
    }

    function beneficiary(uint256 _vestingId) public view returns (address) {
        return vestings[_vestingId].beneficiary;
    }

    function releaseTime(uint256 _vestingId) public view returns (uint256) {
        return vestings[_vestingId].releaseTime;
    }

    function vestingAmount(uint256 _vestingId) public view returns (uint256) {
        return vestings[_vestingId].amount;
    }

    function removeVesting(uint256 _vestingId) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "access denied");
        Vesting storage vesting = vestings[_vestingId];
        require(vesting.beneficiary != address(0x0), INVALID_VESTING_ID);
        require(!vesting.released , VESTING_ALREADY_RELEASED);
        vesting.released = true;
        tokensToVest = tokensToVest - vesting.amount;
        emit TokenVestingRemoved(_vestingId, vesting.beneficiary, vesting.amount);
    }

    function addVesting(address _beneficiary, uint256 _releaseTime, uint256 _amount) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "access denied");
        require(_beneficiary != address(0x0), INVALID_BENEFICIARY);
        tokensToVest = tokensToVest + _amount;
        vestingId = vestingId + 1;
        vestings[vestingId] = Vesting({
        beneficiary: _beneficiary,
        releaseTime: _releaseTime,
        amount: _amount,
        released: false
        });
        emit TokenVestingAdded(vestingId, _beneficiary, _amount);
    }

    function release(uint256 _vestingId) public {
        Vesting storage vesting = vestings[_vestingId];
        require(vesting.beneficiary != address(0x0), INVALID_VESTING_ID);
        require(!vesting.released , VESTING_ALREADY_RELEASED);
        // solhint-disable-next-line not-rely-on-time
        require(block.timestamp >= vesting.releaseTime, NOT_VESTED);

        require(vestingToken.balanceOf(address(this)) >= vesting.amount, INSUFFICIENT_BALANCE);
        vesting.released = true;
        tokensToVest = tokensToVest - vesting.amount;
        vestingToken.transfer(vesting.beneficiary, vesting.amount);
        emit TokenVestingReleased(_vestingId, vesting.beneficiary, vesting.amount);
    }

    function retrieveExcessTokens(uint256 _amount) public {
        require(hasRole(DEFAULT_ADMIN_ROLE, msg.sender), "access denied");
        require(_amount <= (vestingToken.balanceOf(address(this)) - tokensToVest), INSUFFICIENT_BALANCE);
        vestingToken.transfer(msg.sender, _amount);
    }
}
