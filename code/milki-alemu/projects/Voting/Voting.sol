// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Voting {
    enum VoteStates { None, Yes, No }

    struct Proposal {
        address target;
        bytes data;
        uint yesCount;
        uint noCount;
        // 1. Add flag to track if proposal was already executed
        bool executed;
    }

    event ProposalCreated(uint proposalId);
    event VoteCast(uint proposalId, address voter);

    Proposal[] public proposals;
    mapping(uint => mapping(address => VoteStates)) public voteStates;
    mapping(address => bool) public members;

    constructor(address[] memory _initialMembers) {
        members[msg.sender] = true;
        for (uint i = 0; i < _initialMembers.length; i++) {
            members[_initialMembers[i]] = true;
        }
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(members[msg.sender], "Not a member");
        
        proposals.push(Proposal({
            target: _target,
            data: _data,
            yesCount: 0,
            noCount: 0,
            executed: false // Initialize as not executed
        }));

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint _proposalId, bool _supports) external {
        require(members[msg.sender], "Not a member");
        require(_proposalId < proposals.length, "Invalid ID");

        Proposal storage proposal = proposals[_proposalId];
        
        // 2. Security: Ensure the proposal isn't already closed/executed
        require(!proposal.executed, "Proposal already executed");

        VoteStates prevState = voteStates[_proposalId][msg.sender];
        VoteStates newState = _supports ? VoteStates.Yes : VoteStates.No;

        if (prevState != newState) {
            if (prevState == VoteStates.Yes) proposal.yesCount--;
            if (prevState == VoteStates.No) proposal.noCount--;

            if (newState == VoteStates.Yes) proposal.yesCount++;
            else proposal.noCount++;

            voteStates[_proposalId][msg.sender] = newState;
        }

        emit VoteCast(_proposalId, msg.sender);

        // 3. Execution Logic: Trigger if threshold is met
        if (proposal.yesCount >= 10 && !proposal.executed) {
            proposal.executed = true; // Mark as executed BEFORE the call (Reentrancy protection)
            
            // Execute the proposal by calling the target with the data
            (bool success, ) = proposal.target.call(proposal.data);
            require(success, "Target call failed");
        }
    }
}