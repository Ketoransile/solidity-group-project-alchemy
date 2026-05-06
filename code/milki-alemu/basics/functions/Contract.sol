// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    /**
     * @notice Original double function (1 argument)
     */
    function double(uint val) external pure returns(uint result) {
        result = val * 2;
    }

    /**
     * @notice Overloaded double function (2 arguments)
     * @dev Doubles both inputs and returns them as a tuple.
     */
    function double(uint x, uint y) external pure returns(uint, uint) {
        return (x * 2, y * 2);
    }
}