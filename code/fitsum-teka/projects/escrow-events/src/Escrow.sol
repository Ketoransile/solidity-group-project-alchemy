// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Escrow {
    address public depositor;
    address public beneficiary;
    address public arbiter;

    event Approved(uint256 balance);

    constructor(address arbiter_, address beneficiary_) payable {
        depositor = msg.sender;
        arbiter = arbiter_;
        beneficiary = beneficiary_;
    }

    function approve() external {
        require(msg.sender == arbiter, "Only the arbiter can approve this transfer");

        uint256 currentBalance = address(this).balance;

        (bool success, ) = payable(beneficiary).call{value: currentBalance}("");
        require(success, "Transfer failed.");

        emit Approved(currentBalance);
    }
}
