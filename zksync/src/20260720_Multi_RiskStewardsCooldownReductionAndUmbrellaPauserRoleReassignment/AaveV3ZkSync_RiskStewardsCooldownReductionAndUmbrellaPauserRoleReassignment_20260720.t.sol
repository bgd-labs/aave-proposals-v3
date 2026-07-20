// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {RiskStewardCooldownReductionBaseTest} from './RiskStewardCooldownReductionBaseTest.sol';
import {AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720} from './AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol';

/**
 * @dev Test for AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol -vv
 */
contract AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720_Test is
  RiskStewardCooldownReductionBaseTest
{
  AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
    internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 71234599);
    proposal = new AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }

  function test_riskStewardConfig() public {
    _testRiskStewardConfigOld(address(proposal), AaveV3ZkSync.POOL, AaveV3ZkSync.RISK_STEWARD);
  }
}
