// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;

    function setUp() public {
        c = new Contract();
    }

    function testA() public {
        assertEq(c.a(), 200);
    }

    function testB() public {
        assertGe(c.b(), 256);
    }

    function testSum() public {
        assertEq(c.sum(), uint256(c.a()) + uint256(c.b()));
    }
}
