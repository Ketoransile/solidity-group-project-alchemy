// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

contract Contract {
    enum Choices {
        Yes,
        No
    }

    struct Vote {
        Choices choice;
        address voter;
    }

    Vote[] public votes;

    function createVote(Choices choice) external {
        require(!hasVoted(msg.sender), "Address has already cast a vote.");
        votes.push(Vote(choice, msg.sender));
    }

    function changeVote(Choices newChoice) external {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == msg.sender) {
                votes[i].choice = newChoice;
                return;
            }
        }

        revert("No existing vote found for this address.");
    }

    function hasVoted(address _voter) public view returns (bool) {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return true;
            }
        }

        return false;
    }

    function findChoice(address _voter) external view returns (Choices) {
        for (uint256 i = 0; i < votes.length; i++) {
            if (votes[i].voter == _voter) {
                return votes[i].choice;
            }
        }

        return Choices.Yes;
    }
}
