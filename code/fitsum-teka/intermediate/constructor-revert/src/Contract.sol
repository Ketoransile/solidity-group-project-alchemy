// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Reverting Transactions: revert in constructor if invalid input
contract Contract {
    uint256 public minScore;
    uint256 public maxScore;

    constructor(uint256 min_, uint256 max_) {
        if (min_ >= max_) { revert("Min must be less than max"); }
        minScore = min_;
        maxScore = max_;
    }

    function isValidScore(uint256 score) external view returns (bool) {
        return score >= minScore && score <= maxScore;
    }
}

