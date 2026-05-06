// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    // 1. Declare the event
    event Approved(uint256 balance);

    constructor(address _arbiter, address _beneficiary) payable {
        arbiter = _arbiter;
        beneficiary = _beneficiary;
        depositor = msg.sender;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve");

        uint256 balance = address(this).balance;

        // 2. Emit the event before the transfer (best practice)
        emit Approved(balance);

        (bool success, ) = beneficiary.call{value: balance}("");
        require(success, "Transfer failed");
    }
}