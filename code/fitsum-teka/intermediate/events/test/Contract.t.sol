// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Contract.sol";

contract ContractTest is Test {
    Contract public c;
    address alice = address(10);
    address bob = address(11);

    function setUp() public {
        c = new Contract();
        c.mint(alice, 500);
    }

    function testMintEvent() public {
        vm.recordLogs();
        c.mint(bob, 200);
        Vm.Log[] memory logs = vm.getRecordedLogs();
        assertEq(logs.length, 1);
        assertEq(logs[0].topics[0], keccak256("Mint(address,uint256)"));
    }

    function testTransferEvent() public {
        vm.prank(alice);
        vm.recordLogs();
        c.transfer(bob, 100);
        Vm.Log[] memory logs = vm.getRecordedLogs();
        assertEq(logs.length, 1);
        assertEq(logs[0].topics[0], keccak256("Transfer(address,address,uint256)"));
    }

    function testTransferInsufficientReverts() public {
        vm.prank(bob);
        vm.expectRevert();
        c.transfer(alice, 1);
    }
}
