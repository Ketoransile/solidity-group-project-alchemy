// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint configA;
    uint configB;
    uint configC;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function setA(uint _configA) public onlyOwner {
        configA = _configA;
    }

    function setB(uint _configB) public onlyOwner {
        configB = _configB;
    }

    function setC(uint _configC) public onlyOwner {
        configC = _configC;
    }

    modifier onlyOwner {
        // 1. Require only the owner access
        require(msg.sender == owner, "Caller is not the owner");

        // 2. Run the rest of the function body
        _;
    }
}