// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IAaveCLRobotOperator, AaveV3Optimism_AaveRobotMaintenance_20250330} from './AaveV3Optimism_AaveRobotMaintenance_20250330.sol';

/**
 * @dev Test for AaveV3Optimism_AaveRobotMaintenance_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Optimism_AaveRobotMaintenance_20250330.t.sol -vv
 */
contract AaveV3Optimism_AaveRobotMaintenance_20250330_Test is ProtocolV3TestBase {
  AaveV3Optimism_AaveRobotMaintenance_20250330 internal proposal;

  address public constant OLD_STATA_ROBOT_ADDRESS = 0x861Be72d464b6F1C99880B9bE476D40e8F9b5Bce;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 138150047);
    proposal = new AaveV3Optimism_AaveRobotMaintenance_20250330();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_AaveRobotMaintenance_20250330',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_robotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.STATA_ROBOT(),
      proposal.STATA_ROBOT_LINK_AMOUNT()
    );

    executePayload(vm, address(proposal));
  }

  function test_oldRobotsCancelled() public {
    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_STATA_ROBOT_ID(),
      OLD_STATA_ROBOT_ADDRESS
    );

    executePayload(vm, address(proposal));
  }
}
