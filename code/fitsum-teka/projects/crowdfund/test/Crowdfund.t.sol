// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "forge-std/Test.sol";
import "../src/Crowdfund.sol";

contract CrowdfundTest is Test {
    Crowdfund public campaign;
    address creator = address(1);
    address alice = address(2);
    address bob = address(3);

    uint256 constant GOAL = 5 ether;
    uint256 constant DURATION = 7 days;

    function setUp() public {
        vm.prank(creator);
        campaign = new Crowdfund(GOAL, DURATION);
        vm.deal(alice, 10 ether);
        vm.deal(bob, 10 ether);
    }

    // --- Contribute ---

    function testContribute() public {
        vm.prank(alice);
        campaign.contribute{value: 1 ether}();
        assertEq(campaign.contributions(alice), 1 ether);
        assertEq(campaign.totalRaised(), 1 ether);
    }

    function testContributeEmitsEvent() public {
        vm.prank(alice);
        vm.recordLogs();
        campaign.contribute{value: 2 ether}();
        Vm.Log[] memory logs = vm.getRecordedLogs();
        assertEq(logs[0].topics[0], keccak256("Contributed(address,uint256)"));
    }

    function testContributeAfterDeadlineReverts() public {
        vm.warp(block.timestamp + DURATION + 1);
        vm.prank(alice);
        vm.expectRevert();
        campaign.contribute{value: 1 ether}();
    }

    function testContributeZeroReverts() public {
        vm.prank(alice);
        vm.expectRevert();
        campaign.contribute{value: 0}();
    }

    // --- Withdraw ---

    function testCreatorWithdrawAfterGoalMet() public {
        vm.prank(alice);
        campaign.contribute{value: 3 ether}();
        vm.prank(bob);
        campaign.contribute{value: 2 ether}();

        uint256 before = creator.balance;
        vm.prank(creator);
        campaign.withdraw();
        assertGt(creator.balance, before);
    }

    function testWithdrawBeforeGoalReverts() public {
        vm.prank(alice);
        campaign.contribute{value: 1 ether}();
        vm.prank(creator);
        vm.expectRevert();
        campaign.withdraw();
    }

    function testWithdrawTwiceReverts() public {
        vm.prank(alice);
        campaign.contribute{value: 5 ether}();
        vm.prank(creator);
        campaign.withdraw();
        vm.prank(creator);
        vm.expectRevert();
        campaign.withdraw();
    }

    function testNonCreatorWithdrawReverts() public {
        vm.prank(alice);
        campaign.contribute{value: 5 ether}();
        vm.prank(alice);
        vm.expectRevert();
        campaign.withdraw();
    }

    // --- Refund ---

    function testRefundAfterDeadlineMissed() public {
        vm.prank(alice);
        campaign.contribute{value: 1 ether}();

        vm.warp(block.timestamp + DURATION + 1);

        uint256 before = alice.balance;
        vm.prank(alice);
        campaign.refund();
        assertEq(alice.balance, before + 1 ether);
        assertEq(campaign.contributions(alice), 0);
    }

    function testRefundBeforeDeadlineReverts() public {
        vm.prank(alice);
        campaign.contribute{value: 1 ether}();
        vm.prank(alice);
        vm.expectRevert();
        campaign.refund();
    }

    function testRefundWhenGoalMetReverts() public {
        vm.prank(alice);
        campaign.contribute{value: 5 ether}();
        vm.warp(block.timestamp + DURATION + 1);
        vm.prank(alice);
        vm.expectRevert();
        campaign.refund();
    }

    function testRefundNothingToRefundReverts() public {
        vm.warp(block.timestamp + DURATION + 1);
        vm.prank(bob);
        vm.expectRevert();
        campaign.refund();
    }
}
