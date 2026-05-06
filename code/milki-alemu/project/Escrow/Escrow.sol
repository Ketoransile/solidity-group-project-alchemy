// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    // 1. Declare the event
    event Approved(uint balance);

    constructor(address _arbiter, address _beneficiary) payable {
        depositor = msg.sender;
        arbiter = _arbiter;
        beneficiary = _beneficiary;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve the transfer");

        uint balance = address(this).balance;

        (bool success, ) = beneficiary.call{value: balance}("");
        require(success, "Transfer failed.");

        // 2. Emit the event after the successful transfer
        emit Approved(balance);
    }
}