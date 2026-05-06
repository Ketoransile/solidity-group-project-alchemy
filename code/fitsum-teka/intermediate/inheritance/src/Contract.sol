// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

// Multiple Inheritance: Animal → Pet → Dog
contract Animal {
    string public species;

    constructor(string memory species_) {
        species = species_;
    }

    function sound() external virtual pure returns (string memory) {
        return "...";
    }
}

contract Pet is Animal {
    string public petName;

    constructor(string memory name_) Animal("Mammal") {
        petName = name_;
    }
}

contract Dog is Pet {
    constructor(string memory name_) Pet(name_) {}

    function sound() external pure override returns (string memory) {
        return "Woof";
    }
}

