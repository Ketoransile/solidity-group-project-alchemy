// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    function testValidDeploy() public {
        Contract c = new Contract(0, 100);
        assertEq(c.minScore(), 0);
        assertEq(c.maxScore(), 100);
    }

    function testInvalidDeployReverts() public {
        vm.expectRevert();
        new Contract(100, 50); // min >= max should revert
    }

    function testIsValidScore() public {
        Contract c = new Contract(10, 90);
        assertEq(c.isValidScore(50), true);
        assertEq(c.isValidScore(5), false);
        assertEq(c.isValidScore(95), false);
    }
}
