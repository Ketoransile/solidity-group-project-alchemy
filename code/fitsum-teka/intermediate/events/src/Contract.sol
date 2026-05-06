// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Events: a simple token transfer tracker using events
contract Contract {
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Mint(address indexed to, uint256 amount);

    function mint(address to, uint256 amount) external {
        balances[to] = balances[to] + amount;
        emit Mint(to, amount);
    }

    function transfer(address to, uint256 amount) external {
        require(balances[msg.sender] >= amount, "Insufficient balance");
        balances[msg.sender] = balances[msg.sender] - amount;
        balances[to] = balances[to] + amount;
        emit Transfer(msg.sender, to, amount);
    }
}

