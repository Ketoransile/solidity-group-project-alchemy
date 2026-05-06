// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Arrays: dynamic array — push/pop and sum
contract Contract {
    uint256[] public values;

    function addValue(uint256 val) external {
        values.push(val);
    }

    function popValue() external {
        values.pop();
    }

    function total() external view returns (uint256) {
        uint256 sum = 0;
        for (uint256 i = 0; i < values.length; i++) {
            sum += values[i];
        }
        return sum;
    }
}

