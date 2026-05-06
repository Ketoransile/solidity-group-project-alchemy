// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Reverting Transactions: revert in constructor if invalid input
contract Contract {
    uint256 public minScore;
    uint256 public maxScore;

    constructor(uint256 _min, uint256 _max) {
        require(_min < _max, "Min must be less than max");
        minScore = _min;
        maxScore = _max;
    }

    function isValidScore(uint256 _score) external view returns (bool) {
        return _score >= minScore && _score <= maxScore;
    }
}
