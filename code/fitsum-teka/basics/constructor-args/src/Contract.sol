// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Functions 1: Constructor arguments
// Takes a string name and uint age at deployment
contract Contract {
    string public name;
    uint256 public age;

    constructor(string memory name_, uint256 age_) {
        name = name_;
        age = age_;
    }
}

