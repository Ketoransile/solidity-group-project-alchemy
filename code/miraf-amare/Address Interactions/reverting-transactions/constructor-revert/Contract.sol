// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    address public owner;

    error Unauthorized(address caller);

    constructor() payable {
        // Store the deployer's address as the owner
        owner = msg.sender;
    }

    function withdraw() public {
        // Check if the caller is the owner
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }

        // Capture the contract's full balance
        uint256 amount = address(this).balance;

        // Send the funds to the owner
        (bool success, ) = owner.call{value: amount}("");
        require(success, "Transfer failed");
    }
}