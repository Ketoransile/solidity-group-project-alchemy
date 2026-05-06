// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/console.sol";

contract Contract {
    function winningNumber(string calldata message) external view returns (uint) {
        // We saw the message: "return the value 794 to win!"
        console.log("The message is:", message);

        // Update this return value to 794
        return 794; 
    }
}