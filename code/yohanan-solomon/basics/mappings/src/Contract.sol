// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Mappings: track token balances per address
contract Contract {
    mapping(address => uint256) public balances;

    function deposit(uint256 _amount) external {
        balances[msg.sender] += _amount;
    }

    function withdraw(uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
    }
}
