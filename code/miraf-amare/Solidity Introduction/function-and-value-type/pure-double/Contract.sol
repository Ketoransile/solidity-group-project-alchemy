// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // 1. The original "double" for a single value
    // Changed from "external" to "public" so it can be called from within the contract
    function double(uint x) public pure returns (uint) {
        return x * 2;
    }

    // 2. The overloaded "double" for two values
    function double(uint x, uint y) external pure returns (uint, uint) {
        // We can call the first "double" function internally
        return (double(x), double(y));
    }
}