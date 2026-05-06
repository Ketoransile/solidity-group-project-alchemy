// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;

    function setUp() public {
        c = new Contract();
    }

    function testIsActive() public {
        assertEq(c.isActive(), true);
    }

    function testIsPaused() public {
        assertEq(c.isPaused(), false);
    }
}
