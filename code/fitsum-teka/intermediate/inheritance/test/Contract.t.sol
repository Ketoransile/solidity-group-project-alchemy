// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Dog public dog;

    function setUp() public {
        dog = new Dog("Rex");
    }

    function testName() public {
        assertEq(dog.petName(), "Rex");
    }

    function testSpecies() public {
        assertEq(dog.species(), "Mammal");
    }

    function testSound() public {
        assertEq(dog.sound(), "Woof");
    }
}
