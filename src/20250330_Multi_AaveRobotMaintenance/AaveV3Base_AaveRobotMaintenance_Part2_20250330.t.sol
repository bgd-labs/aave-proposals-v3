// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAaveCLRobotOperator, AaveV3Base_AaveRobotMaintenance_Part1_20250330} from './AaveV3Base_AaveRobotMaintenance_Part1_20250330.sol';

import {AaveV3Base_AaveRobotMaintenance_Part2_20250330} from './AaveV3Base_AaveRobotMaintenance_Part2_20250330.sol';

/**
 * @dev Test for AaveV3Base_AaveRobotMaintenance_Part2_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part2_20250330.t.sol -vv
 */
contract AaveV3Base_AaveRobotMaintenance_Part2_20250330_Test is ProtocolV3TestBase {
  AaveV3Base_AaveRobotMaintenance_Part1_20250330 internal proposalPart1;
  AaveV3Base_AaveRobotMaintenance_Part2_20250330 internal proposalPart2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 32554616);
    proposalPart1 = new AaveV3Base_AaveRobotMaintenance_Part1_20250330();
    proposalPart2 = new AaveV3Base_AaveRobotMaintenance_Part2_20250330();

    // execute the payload to cancel the robot and withdraw link to collector
    executePayload(vm, address(proposalPart1));

    // after robot cancel we need to wait for some blocks to withdraw so we fast-forward
    vm.roll(block.number + 50);
    IAaveCLRobotOperator(MiscBase.AAVE_CL_ROBOT_OPERATOR).withdrawLink(
      proposalPart1.OLD_STATA_ROBOT_ID()
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_AaveRobotMaintenance_Part2_20250330',
      AaveV3Base.POOL,
      address(proposalPart2)
    );
  }

  function test_newRobotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposalPart2.STATA_ROBOT(),
      proposalPart2.STATA_ROBOT_LINK_AMOUNT()
    );

    executePayload(vm, address(proposalPart2));
  }
}
