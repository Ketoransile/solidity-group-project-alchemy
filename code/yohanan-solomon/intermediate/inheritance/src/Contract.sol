// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Multiple Inheritance: Animal → Pet → Dog
contract Animal {
    string public species;

    constructor(string memory _species) {
        species = _species;
    }

    function sound() external virtual pure returns (string memory) {
        return "...";
    }
}

contract Pet is Animal {
    string public petName;

    constructor(string memory _name) Animal("Mammal") {
        petName = _name;
    }
}

contract Dog is Pet {
    constructor(string memory _name) Pet(_name) {}

    function sound() external pure override returns (string memory) {
        return "Woof";
    }
}
