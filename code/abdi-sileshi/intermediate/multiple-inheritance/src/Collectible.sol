// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

import "./BaseContracts.sol";

contract Collectible is Transferable {
    uint256 public price;

    function markPrice(uint256 _price) external onlyOwner {
        price = _price;
    }
}
