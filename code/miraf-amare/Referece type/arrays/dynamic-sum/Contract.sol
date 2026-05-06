// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    /**
     * @notice Sums a dynamic array of unsigned integers
     * @param numbers The dynamic array of uints
     * @return The total sum
     */
    function sum(uint[] calldata numbers) external pure returns (uint) {
        uint total = 0;

        // Use the .length property to iterate through all elements
        for (uint i = 0; i < numbers.length; i++) {
            total += numbers[i];
        }

        return total;
    }
}