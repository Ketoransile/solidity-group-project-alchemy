// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {

    struct User {
        uint balance;
        bool isActive;
    }

    mapping(address => User) public users;

    function createUser() external {
        require(!users[msg.sender].isActive, "User already exists");

        users[msg.sender] = User({
            balance: 100,
            isActive: true
        });
    }

    function transfer(address recipient, uint amount) external {
        // both users must be active
        require(users[msg.sender].isActive, "Sender not active");
        require(users[recipient].isActive, "Recipient not active");

        // sender must have enough balance
        require(users[msg.sender].balance >= amount, "Insufficient balance");

        // perform transfer
        users[msg.sender].balance -= amount;
        users[recipient].balance += amount;
    }
}