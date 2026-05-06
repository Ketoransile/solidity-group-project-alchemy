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

    constructor(address[] memory _members) {
        isMember[msg.sender] = true;

        for (uint256 i = 0; i < _members.length; i++) {
            isMember[_members[i]] = true;
        }
    }

    function newProposal(address _target, bytes calldata _data) external {
        require(isMember[msg.sender], "Not an authorized member");

        proposals.push(
            Proposal({
                target: _target,
                data: _data,
                yesCount: 0,
                noCount: 0,
                executed: false
            })
        );

        emit ProposalCreated(proposals.length - 1);
    }

    function castVote(uint256 _proposalId, bool _supports) external {
        require(isMember[msg.sender], "Not an authorized member");
        require(_proposalId < proposals.length, "Invalid proposal ID");

        Proposal storage proposal = proposals[_proposalId];
        require(!proposal.executed, "Proposal already executed");

        VoteStates currentState = voteStates[_proposalId][msg.sender];
        VoteStates newState = _supports ? VoteStates.Yes : VoteStates.No;

        if (currentState != newState) {
            if (currentState == VoteStates.Yes) {
                proposal.yesCount--;
            } else if (currentState == VoteStates.No) {
                proposal.noCount--;
            }

            if (newState == VoteStates.Yes) {
                proposal.yesCount++;
            } else {
                proposal.noCount++;
            }

            voteStates[_proposalId][msg.sender] = newState;
        }

        emit VoteCast(_proposalId, msg.sender);

        if (proposal.yesCount >= 10) {
            executeProposal(_proposalId);
        }
    }

    function executeProposal(uint256 _proposalId) internal {
        Proposal storage proposal = proposals[_proposalId];
        proposal.executed = true;

        (bool success, ) = proposal.target.call(proposal.data);
        require(success, "Target call failed");
    }
}
