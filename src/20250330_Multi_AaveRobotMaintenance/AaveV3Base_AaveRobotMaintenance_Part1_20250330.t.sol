// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IAaveCLRobotOperator, AaveV3Base_AaveRobotMaintenance_Part1_20250330} from './AaveV3Base_AaveRobotMaintenance_Part1_20250330.sol';

/**
 * @dev Test for AaveV3Base_AaveRobotMaintenance_20250330_Part1_Test
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Base_AaveRobotMaintenance_Part1_20250330.t.sol -vv
 */
contract AaveV3Base_AaveRobotMaintenance_20250330_Part1_Test is ProtocolV3TestBase {
  AaveV3Base_AaveRobotMaintenance_Part1_20250330 internal proposal;
  address public constant OLD_STATA_ROBOT_ADDRESS = 0xad87684D27e6e58F055E6878A9F11F8c52A5b0F5;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 32411151);
    proposal = new AaveV3Base_AaveRobotMaintenance_Part1_20250330();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_AaveRobotMaintenance_Part1_20250330',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_keepersCancelled() public {
    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_STATA_ROBOT_ID(),
      OLD_STATA_ROBOT_ADDRESS
    );

    executePayload(vm, address(proposal));
  }
}
