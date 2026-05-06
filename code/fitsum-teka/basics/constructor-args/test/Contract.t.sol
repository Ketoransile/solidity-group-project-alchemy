// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;

    function setUp() public {
        c = new Contract("Yohanan", 21);
    }

    function testName() public {
        assertEq(c.name(), "Yohanan");
    }

    function testAge() public {
        assertEq(c.age(), 21);
    }
}
