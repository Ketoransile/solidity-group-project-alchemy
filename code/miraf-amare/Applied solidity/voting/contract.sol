// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteStates { Absent, Yes, No }

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        bool executed; // Track if the proposal has been carried out
        mapping(address => VoteStates) voteStates;
    }

    mapping(address => bool) public members;
    Proposal[] public proposals;

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);
    event ProposalExecuted(uint proposalId);

    constructor(address[] memory _members) {
        members[msg.sender] = true;
        for (uint i = 0; i < _members.length; i++) {
            members[_members[i]] = true;
        }
    }

    modifier onlyMember() {
        require(members[msg.sender], "Access denied");
        _;
    }

    function newProposal(address _target, bytes calldata _data) external onlyMember {
        Proposal storage proposal = proposals.push();
        proposal.target = _target;
        proposal.data = _data;
        proposal.yesCount = 0;
        proposal.noCount = 0;
        proposal.executed = false;

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint proposalId, bool _supports) external onlyMember {
        require(proposalId < proposals.length, "Proposal does not exist");
        Proposal storage proposal = proposals[proposalId];
        
        // Ensure we don't vote on or re-execute a finished proposal
        require(!proposal.executed, "Proposal already executed");

        VoteStates previousVote = proposal.voteStates[msg.sender];
        VoteStates newVote = _supports ? VoteStates.Yes : VoteStates.No;

        if (previousVote == VoteStates.Yes) {
            proposal.yesCount--;
        } else if (previousVote == VoteStates.No) {
            proposal.noCount--;
        }

        if (newVote == VoteStates.Yes) {
            proposal.yesCount++;
        } else {
            proposal.noCount++;
        }

        proposal.voteStates[msg.sender] = newVote;
        emit VoteCast(proposalId, msg.sender);

        // Check if the 10 "Yes" vote threshold has been reached
        if (proposal.yesCount >= 10) {
            executeProposal(proposalId);
        }
    }

    /**
     * @dev Internal function to handle the low-level execution call
     */
    function executeProposal(uint proposalId) internal {
        Proposal storage proposal = proposals[proposalId];
        
        // Mark as executed BEFORE the call to prevent re-entrancy attacks
        proposal.executed = true;

        // Execute the low-level call
        (bool success, ) = proposal.target.call(proposal.data);
        require(success, "Execution failed");

        emit ProposalExecuted(proposalId);
    }
}