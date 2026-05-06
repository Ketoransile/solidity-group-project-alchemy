// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;

    function setUp() public {
        c = new Contract();
    }

    function testAIsPositive() public {
        assertGt(int256(c.a()), 0);
    }

    function testBIsNegative() public {
        assertLt(int256(c.b()), 0);
    }

    function testDifference() public {
        assertEq(c.difference(), int16(c.a()) - int16(c.b()));
    }
}
