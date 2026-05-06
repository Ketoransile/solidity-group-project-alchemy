// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Arrays: dynamic array — push/pop and sum
contract Contract {
    uint256[] public values;

    function addValue(uint256 _val) external {
        values.push(_val);
    }

    function popValue() external {
        values.pop();
    }

    function total() external view returns (uint256) {
        uint256 t = 0;
        for (uint256 i = 0; i < values.length; i++) {
            t += values[i];
        }
        return t;
    }
}
