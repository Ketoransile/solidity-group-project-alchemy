// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract StackClub {
    address[] public members;

    // 1. Initialize the club with the deployer as the first member
    constructor() {
        members.push(msg.sender);
    }

    /**
     * @dev Adds a new member. 
     * Restricted: Only existing members can add new ones.
     */
    function addMember(address _newMember) external {
        require(isMember(msg.sender), "Must be a member to add others");
        members.push(_newMember);
    }

    /**
     * @dev Removes the most recently added member (the top of the stack).
     * Restricted: Only existing members can trigger a removal.
     */
    function removeLastMember() external {
        require(isMember(msg.sender), "Must be a member to remove others");
        
        // Ensure there is at least one member to pop to avoid underflow
        // (Though in this logic, the caller is a member, so length is at least 1)
        members.pop();
    }

    /**
     * @dev Helper function to check membership.
     */
    function isMember(address _addr) public view returns (bool) {
        for (uint i = 0; i < members.length; i++) {
            if (members[i] == _addr) {
                return true;
            }
        }
        return false;
    }
}