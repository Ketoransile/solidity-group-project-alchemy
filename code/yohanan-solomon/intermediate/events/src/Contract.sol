// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Events: a simple token transfer tracker using events
contract Contract {
    mapping(address => uint256) public balances;

    event Transfer(address indexed from, address indexed to, uint256 amount);
    event Mint(address indexed to, uint256 amount);

    function mint(address _to, uint256 _amount) external {
        balances[_to] += _amount;
        emit Mint(_to, _amount);
    }

    function transfer(address _to, uint256 _amount) external {
        require(balances[msg.sender] >= _amount, "Insufficient balance");
        balances[msg.sender] -= _amount;
        balances[_to] += _amount;
        emit Transfer(msg.sender, _to, _amount);
    }
}
