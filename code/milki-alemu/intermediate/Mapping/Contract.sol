// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    // The test expects 'Unacquainted' to be a member of this enum
    enum ConnectionTypes { 
        Unacquainted, 
        Friend, 
        Family, 
        Coworker, 
        Business 
    }

    // 1. Define the nested mapping
    // Source Address => Target Address => Relationship Type
    mapping(address => mapping(address => ConnectionTypes)) public connections;

    /**
     * @dev Establishes a connection from the sender to another address.
     * @param _other The address to connect with.
     * @param _type The type of relationship (Friend, Family, etc.)
     */
    function connectWith(address _other, ConnectionTypes _type) external {
        // 2. Set the relationship in the nested mapping
        connections[msg.sender][_other] = _type;
    }
}