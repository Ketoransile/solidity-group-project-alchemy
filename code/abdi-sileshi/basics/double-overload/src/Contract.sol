// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    function double(uint256 val) public pure returns (uint256) {
        return val * 2;
    }

    function double(uint256 val1, uint256 val2) external pure returns (uint256, uint256) {
        return (double(val1), double(val2));
    }
}
