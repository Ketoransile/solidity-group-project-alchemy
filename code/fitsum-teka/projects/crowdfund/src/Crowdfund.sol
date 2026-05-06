// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/// @title Crowdfund
/// @notice A simple crowdfunding contract where contributors can fund a goal.
///         If the goal is met, the creator can withdraw. If the deadline passes
///         without meeting the goal, contributors can reclaim their funds.
contract Crowdfund {
    address public creator;
    uint256 public goal;
    uint256 public deadline;
    bool public withdrawn;

    mapping(address => uint256) public contributions;
    uint256 public totalRaised;

    event Contributed(address indexed contributor, uint256 amount);
    event GoalReached(uint256 totalRaised);
    event Withdrawn(address indexed creator, uint256 amount);
    event Refunded(address indexed contributor, uint256 amount);

    constructor(uint256 goal_, uint256 durationInSec) {
        require(goal_ > 0, "Goal must be greater than zero");
        require(durationInSec > 0, "Duration must be positive");
        creator = msg.sender;
        goal = goal_;
        deadline = block.timestamp + durationInSec;
    }

    function contribute() external payable {
        require(block.timestamp < deadline, "Campaign has ended");
        require(msg.value > 0, "Must send ether");

        contributions[msg.sender] = contributions[msg.sender] + msg.value;
        totalRaised = totalRaised + msg.value;

        emit Contributed(msg.sender, msg.value);

        if (totalRaised >= goal) {
            emit GoalReached(totalRaised);
        }
    }

    function withdraw() external {
        require(msg.sender == creator, "Only creator can withdraw");
        require(totalRaised >= goal, "Goal not reached");
        require(!withdrawn, "Already withdrawn");

        withdrawn = true;
        uint256 amount = address(this).balance;
        (bool success, ) = payable(creator).call{value: amount}("");
        require(success, "Withdraw failed");

        emit Withdrawn(creator, amount);
    }

    function refund() external {
        require(block.timestamp >= deadline, "Campaign still active");
        require(totalRaised < goal, "Goal was reached, no refunds");

        uint256 contributed = contributions[msg.sender];
        require(contributed > 0, "Nothing to refund");

        contributions[msg.sender] = 0;
        (bool success, ) = payable(msg.sender).call{value: contributed}("");
        require(success, "Refund failed");

        emit Refunded(msg.sender, contributed);
    }
}

