// SPDX-License-Identifier: MIT
pragma solidity 0.8.20;

// 1. REMOVE: import "./BaseContracts.sol"; (This is causing the double declaration)

/**
 * @dev Base contract for ownership
 */
contract Ownable {
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Not owner");
        _;
    }
}

/**
 * @dev Base contract for transferring ownership
 */
contract Transferable is Ownable {
    function transfer(address _newOwner) external onlyOwner {
        owner = _newOwner;
    }
}

