// SPDX-License-Identifier: MIT
pragma solidity 0.6.12;

contract RandomCapable {
    function extractNumber(uint256 randomNumber, uint256 digits, uint256 offset) public pure returns (uint256 result) {
        return ((randomNumber % 10**(digits + offset)) / 10**offset );
    }

    function vrf() public view returns (bytes32 result) {
        bytes32 input;
        assembly {
            let memPtr := mload(0x40)
            if iszero(staticcall(not(0), 0xff, input, 32, memPtr, 32)) {
                invalid()
            }
            result := mload(memPtr)
        }
    }
}
