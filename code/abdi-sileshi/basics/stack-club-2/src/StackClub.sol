// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract StackClub {
    address[] public members;

    constructor() {
        members.push(msg.sender);
    }

    function addMember(address _newMember) external {
        require(isMember(msg.sender), "Only members can add new members");
        members.push(_newMember);
    }

    function removeLastMember() external {
        require(isMember(msg.sender), "Only members can remove members");
        members.pop();
    }

    function isMember(address _addr) public view returns (bool) {
        for (uint256 i = 0; i < members.length; i++) {
            if (members[i] == _addr) {
                return true;
            }
        }

        return false;
    }
}
