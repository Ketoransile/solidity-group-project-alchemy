// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;

    function setUp() public {
        c = new Contract();
    }

    function testMsg1() public {
        assertEq(c.msg1(), bytes32("Blockchain is the future"));
    }

    function testMsg2Length() public {
        bytes memory b = bytes(c.msg2());
        assertGt(b.length, 32);
    }
}
