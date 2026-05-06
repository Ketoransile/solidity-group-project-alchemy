// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Contract {
    uint256 configA;
    uint256 configB;
    uint256 configC;
    address owner;

    constructor() {
        owner = msg.sender;
    }

    function setA(uint256 _configA) public onlyOwner {
        configA = _configA;
    }

    function setB(uint256 _configB) public onlyOwner {
        configB = _configB;
    }

    function setC(uint256 _configC) public onlyOwner {
        configC = _configC;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only the owner can call this function");
        _;
    }
}
