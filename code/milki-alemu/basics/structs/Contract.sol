// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    enum Choices { Yes, No }

    struct Vote {
        Choices choice;
        address voter;
    }

    // Storage array to keep track of all votes cast
    Vote[] public votes;

    /**
     * @dev Allows an address to cast a vote. Reverts if they have already voted.
     */
    function createVote(Choices _choice) external {
        require(!hasVoted(msg.sender), "Address has already cast a vote.");
        votes.push(Vote(_choice, msg.sender));
    }

    /**
     * @dev Allows a user to change their existing vote. Reverts if no vote exists.
     */
    function changeVote(Choices _newChoice) external {
        bool found = false;
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender) {
                votes[i].choice = _newChoice;
                found = true;
                break; 
            }
        }
        require(found, "You must cast a vote before you can change it.");
    }

    /**
     * @dev Returns the choice made by a specific address.
     * This is the function the compiler was missing!
     */
    function findChoice(address _voter) external view returns (Choices) {
        return findVote(_voter).choice;
    }

    /**
     * @dev Returns true if the address has already voted.
     */
    function hasVoted(address _voter) public view returns (bool) {
        return findVote(_voter).voter != address(0);
    }

    /**
     * @dev Internal helper to reduce code duplication (DRY).
     */
    function findVote(address _voter) internal view returns (Vote memory) {
        for (uint i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return votes[i];
            }
        }
        return Vote(Choices(0), address(0));
    }
}