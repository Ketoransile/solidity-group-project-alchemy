// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteStates {
        Absent,
        Yes,
        No
    }

    struct Proposal {
        address target;
        bytes data;
        uint256 yesCount;
        uint256 noCount;
        bool executed;
    }

    Proposal[] public proposals;
    mapping(address => bool) public isMember;

    event ProposalCreated(uint256 proposalId);
    event VoteCast(uint256 proposalId, address voter);

    mapping(uint256 => mapping(address => VoteStates)) public voteStates;

    constructor(address[] memory members_) {
        isMember[msg.sender] = true;

        uint256 numMembers = members_.length;
        for (uint256 idx = 0; idx < numMembers; idx++) {
            isMember[members_[idx]] = true;
        }
    }

    function newProposal(address target_, bytes calldata data_) external {
        require(isMember[msg.sender], "Not an authorized member");

        proposals.push(
            Proposal({
                target: target_,
                data: data_,
                yesCount: 0,
                noCount: 0,
                executed: false
            })
        );

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint256 proposalId_, bool supports_) external {
        require(isMember[msg.sender], "Not an authorized member");
        require(proposalId_ < proposals.length, "Invalid proposal ID");

        Proposal storage p = proposals[proposalId_];
        require(!p.executed, "Proposal already executed");

        VoteStates current = voteStates[proposalId_][msg.sender];
        VoteStates nextState = supports_ ? VoteStates.Yes : VoteStates.No;

        if (current != nextState) {
            // Revert previous vote count
            if (current == VoteStates.Yes) {
                p.yesCount = p.yesCount - 1;
            } else if (current == VoteStates.No) {
                p.noCount = p.noCount - 1;
            }

            // Apply new vote count
            if (nextState == VoteStates.Yes) {
                p.yesCount = p.yesCount + 1;
            } else {
                p.noCount = p.noCount + 1;
            }

            voteStates[proposalId_][msg.sender] = nextState;
        }

        emit VoteCast(proposalId_, msg.sender);

        if (p.yesCount >= 10) {
            executeProposal(proposalId_);
        }
    }

    function executeProposal(uint256 proposalId_) internal {
        Proposal storage p = proposals[proposalId_];
        p.executed = true;

        (bool success, ) = p.target.call(p.data);
        require(success, "Target call failed");
    }
}
