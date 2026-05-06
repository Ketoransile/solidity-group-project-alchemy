// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    /**
     * @notice Sums a fixed-size array of 5 integers
     * @param numbers The fixed array of 5 uints
     * @return The total sum
     */
    function sum(uint[5] calldata numbers) external pure returns (uint) {
        uint total = 0;

        for (uint i = 0; i < 5; i++) {
            total += numbers[i];
        }

        return total;
    }
}