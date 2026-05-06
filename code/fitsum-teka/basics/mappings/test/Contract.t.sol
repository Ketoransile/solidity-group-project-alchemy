// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;
    address user = address(10);

    function setUp() public {
        c = new Contract();
    }

    function testDeposit() public {
        vm.prank(user);
        c.deposit(100);
        assertEq(c.balances(user), 100);
    }

    function testWithdraw() public {
        vm.startPrank(user);
        c.deposit(100);
        c.withdraw(40);
        assertEq(c.balances(user), 60);
    }

    function testWithdrawInsufficientReverts() public {
        vm.prank(user);
        vm.expectRevert();
        c.withdraw(1);
    }
}
