// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Basic Data Types 2: Unsigned integers
// a: uint8 (0-255), b: uint16 (at least 256), sum: uint256
contract Contract {
    uint8 public a = 200;
    uint16 public b = 1000;
    uint256 public sum = uint256(a) + uint256(b);
}

