// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IHero {
    function alert() external;
}

contract Sidekick {
    function sendAlert(address hero) public {
        // 1. Cast the address to the IHero interface
        // 2. Call the alert() function on that instance
        IHero(hero).alert();
    }
}