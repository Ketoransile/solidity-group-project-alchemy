// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StackClub {

    address[] public members;

    // Constructor: add deployer as first member
    constructor() {
        members.push(msg.sender);
    }

    // Add member (only existing members can call)
    function addMember(address newMember) external {
        require(isMember(msg.sender), "Not a member");
        members.push(newMember);
    }

    // Remove last member (only existing members can call)
    function removeLastMember() external {
        require(isMember(msg.sender), "Not a member");
        require(members.length > 0, "No members");

        members.pop();
    }

    // Check membership
    function isMember(address user) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == user) {
                return true;
            }
        }
        return false;
    }
}