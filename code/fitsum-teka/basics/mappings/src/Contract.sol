// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Mappings: track token balances per address
contract Contract {
    mapping(address => uint256) public balances;

    function deposit(uint256 amount) external {
        balances[msg.sender] = balances[msg.sender] + amount;
    }

    function withdraw(uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender] - amount;
    }
}

