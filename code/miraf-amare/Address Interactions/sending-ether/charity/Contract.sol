// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Contract {
    address public owner;
    address public charity;

    constructor(address _charity) {
        owner = msg.sender;
        charity = _charity;
    }

    receive() external payable {}

    function donate() public {
        // We cast charity to 'address payable' so it can receive the funds
        // This sends all remaining balance to the charity and deletes the contract
        selfdestruct(payable(charity));
    }
}