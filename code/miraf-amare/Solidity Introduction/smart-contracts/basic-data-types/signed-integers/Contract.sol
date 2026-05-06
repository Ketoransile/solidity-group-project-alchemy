// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    int8 public a = 50;     // positive value
    int8 public b = -20;    // negative value

    int16 public difference = a > b ? int16(a - b) : int16(b - a);
}