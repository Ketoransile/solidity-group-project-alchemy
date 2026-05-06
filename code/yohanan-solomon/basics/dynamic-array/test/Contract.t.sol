// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;

    function setUp() public {
        c = new Contract();
    }

    function testAddAndTotal() public {
        c.addValue(5);
        c.addValue(15);
        c.addValue(30);
        assertEq(c.total(), 50);
    }

    function testPop() public {
        c.addValue(10);
        c.addValue(20);
        c.popValue();
        assertEq(c.total(), 10);
    }
}
