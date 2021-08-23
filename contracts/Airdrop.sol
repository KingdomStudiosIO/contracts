// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract Airdrop is Ownable {
    IERC20 public govToken;

    constructor(address _address) public {
        govToken = IERC20(_address);
    }

    /// @dev Sends a batch transfer of _amount to each of the given addresses.
    function sendBatch(address[] memory _recipients, uint256 _amount) onlyOwner public returns (bool) {
        for (uint i = 0; i < _recipients.length; i++) {
            govToken.transfer(_recipients[i], _amount);
        }
        return true;
    }
}
