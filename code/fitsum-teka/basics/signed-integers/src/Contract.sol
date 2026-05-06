// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Basic Data Types 3: Signed integers
// a positive int8, b negative int8, difference = absolute difference as int16
contract Contract {
    int8 public a = 50;
    int8 public b = -30;
    int16 public difference = int16(a) - int16(b); // Calculate difference // 50 - (-30) = 80
}

