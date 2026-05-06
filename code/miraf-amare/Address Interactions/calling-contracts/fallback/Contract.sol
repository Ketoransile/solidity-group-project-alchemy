// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Sidekick {
    function makeContact(address hero) public {
        // Option 1: Send arbitrary bytes that won't match any function
        (bool success, ) = hero.call(abi.encodePacked("This is not a function"));
        
        // Option 2: Send a random 4-byte selector
        // (bool success, ) = hero.call(bytes4(0xdeadbeef));

        require(success, "Contact failed");
    }
}