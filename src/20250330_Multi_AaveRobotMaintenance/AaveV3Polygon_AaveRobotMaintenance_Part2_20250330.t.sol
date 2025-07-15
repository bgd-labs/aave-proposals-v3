// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';

import {AaveV3Polygon_AaveRobotMaintenance_Part1_20250330} from './AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.sol';
import {IERC20, AaveV3Polygon_AaveRobotMaintenance_Part2_20250330} from './AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.sol';
import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';

/**
 * @dev Test for AaveV3Polygon_AaveRobotMaintenance_Part2_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.t.sol -vv
 */
contract AaveV3Polygon_AaveRobotMaintenance_20250330_Part2_Test is ProtocolV3TestBase {
  AaveV3Polygon_AaveRobotMaintenance_Part1_20250330 internal proposalPart1;
  AaveV3Polygon_AaveRobotMaintenance_Part2_20250330 internal proposalPart2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 73692653);
    proposalPart1 = new AaveV3Polygon_AaveRobotMaintenance_Part1_20250330();
    proposalPart2 = new AaveV3Polygon_AaveRobotMaintenance_Part2_20250330();

    // execute the payload to cancel the robot and withdraw link to collector
    executePayload(vm, address(proposalPart1));

    // after robot cancel we need to wait for some blocks to withdraw so we fast-forward
    vm.roll(block.number + 50);
    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).withdrawLink(
      proposalPart1.OLD_STATA_ROBOT_ID()
    );
    IAaveCLRobotOperator(MiscPolygon.AAVE_CL_ROBOT_OPERATOR).withdrawLink(
      proposalPart1.OLD_VOTING_CHAIN_ROBOT_ID()
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AaveRobotMaintenance_Part2_20250330',
      AaveV3Polygon.POOL,
      address(proposalPart2),
      false
    );
  }

  function test_newRobotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposalPart2.STATA_ROBOT(),
      proposalPart2.STATA_ROBOT_LINK_AMOUNT()
    );

    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposalPart2.VOTING_CHAIN_ROBOT(),
      uint96(proposalPart2.VOTING_CHAIN_ROBOT_LINK_AMOUNT())
    );

    executePayload(vm, address(proposalPart2));
  }

  function test_rootsConsumerBalance() public {
    uint256 linkBalanceBefore = IERC20(proposalPart2.LINK_TOKEN()).balanceOf(
      proposalPart2.OLD_ROOTS_CONSUMER()
    );
    assertEq(linkBalanceBefore, 45.6 ether);

    executePayload(vm, address(proposalPart2));

    assertGe(
      IERC20(proposalPart2.LINK_TOKEN()).balanceOf(proposalPart2.ROOTS_CONSUMER()),
      linkBalanceBefore
    );
  }
}
