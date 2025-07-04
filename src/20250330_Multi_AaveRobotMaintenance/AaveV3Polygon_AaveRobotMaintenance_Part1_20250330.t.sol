// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IAaveCLRobotOperator, AaveV3Polygon_AaveRobotMaintenance_Part1_20250330} from './AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.sol';
import {AaveV3Polygon_AaveRobotMaintenance_Part2_20250330} from './AaveV3Polygon_AaveRobotMaintenance_Part2_20250330.sol';

/**
 * @dev Test for AaveV3Polygon_AaveRobotMaintenance_Part1_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Polygon_AaveRobotMaintenance_Part1_20250330.t.sol -vv
 */
contract AaveV3Polygon_AaveRobotMaintenance_Part1_20250330_Test is ProtocolV3TestBase {
  AaveV3Polygon_AaveRobotMaintenance_Part1_20250330 internal proposal;

  address public constant OLD_STATA_ROBOT_ADDRESS = 0x855FbD0D57fF5B1e8263e3cCDf3384545fbaF863;
  address public constant OLD_VOTING_CHAIN_ROBOT_ADDRESS =
    0xbe7998712402B6A63975515A532Ce503437998b7;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 73557608);
    proposal = new AaveV3Polygon_AaveRobotMaintenance_Part1_20250330();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AaveRobotMaintenance_Part1_20250330',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_keepersCancelled() public {
    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_STATA_ROBOT_ID(),
      OLD_STATA_ROBOT_ADDRESS
    );

    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_VOTING_CHAIN_ROBOT_ID(),
      OLD_VOTING_CHAIN_ROBOT_ADDRESS
    );

    executePayload(vm, address(proposal));
  }
}
