// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB} from 'aave-address-book/AaveV3BNB.sol';

import {Test} from 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAaveCLRobotOperator, AaveV3BNB_AaveRobotMaintenance_Part1_20250330} from './AaveV3BNB_AaveRobotMaintenance_Part1_20250330.sol';

/**
 * @dev Test for AaveV3BNB_AaveRobotMaintenance_Part1_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3BNB_AaveRobotMaintenance_Part1_20250330.t.sol -vv
 */
contract AaveV3BNB_AaveRobotMaintenance_20250330_Test is ProtocolV3TestBase {
  AaveV3BNB_AaveRobotMaintenance_Part1_20250330 internal proposal;

  address public constant OLD_STATA_ROBOT_ADDRESS = 0x020E452b463568f55BAc6Dc5aFC8F0B62Ea5f0f3;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 53201338);
    proposal = new AaveV3BNB_AaveRobotMaintenance_Part1_20250330();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3BNB_AaveRobotMaintenance_Part1_20250330', AaveV3BNB.POOL, address(proposal));
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
