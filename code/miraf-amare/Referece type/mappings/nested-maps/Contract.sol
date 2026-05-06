// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {

    enum ConnectionTypes {
        Unacquainted,
        Friend,
        Blocked,
        Family
    }

    mapping(address => mapping(address => ConnectionTypes)) public connections;

    // overload 1: default connection
    function connectWith(address other) external {
        connections[msg.sender][other] = ConnectionTypes.Unacquainted;
    }

    // overload 2: custom connection type
    function connectWith(address other, ConnectionTypes connectionType) external {
        connections[msg.sender][other] = connectionType;
    }
}