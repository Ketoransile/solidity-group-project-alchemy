// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function sendAlert(address hero) public {
        // The signature is the name and the parameter types (empty in this case)
        bytes4 signature = bytes4(keccak256("alert()"));

        // We use the low-level call to send the 4-byte selector as calldata
        (bool success, ) = hero.call(abi.encodePacked(signature));
        
        require(success, "Low-level call failed");
    }
}