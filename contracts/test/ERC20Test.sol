// SPDX-License-Identifier: MIT
pragma solidity =0.6.12;

import '../uniswapv2/UniswapV2ERC20.sol';

contract ERC20Test is UniswapV2ERC20 {
    constructor(uint _totalSupply) public {
        _mint(msg.sender, _totalSupply);
    }
}
