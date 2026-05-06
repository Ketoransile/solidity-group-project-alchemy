// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // 1. Create a public, dynamic state variable array
    uint[] public evenNumbers;

    /**
     * @notice Filters even numbers from an input and stores them in state
     * @param numbers The input array to scan
     */
    function filterEven(uint[] calldata numbers) external {
        // 2. Loop through the input array
        for (uint i = 0; i < numbers.length; i++) {
            
            // 3. Check if the number is even using the modulo operator (%)
            // An even number has a remainder of 0 when divided by 2
            if (numbers[i] % 2 == 0) {
                
                // 4. Push the even number into our storage array
                evenNumbers.push(numbers[i]);
            }
        }
    }
}