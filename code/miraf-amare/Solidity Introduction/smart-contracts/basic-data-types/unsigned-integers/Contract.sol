// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint8 public a = 100;      // between 0 and 255
    uint16 public b = 300;     // at least 256
    uint256 public sum = a + b;
}