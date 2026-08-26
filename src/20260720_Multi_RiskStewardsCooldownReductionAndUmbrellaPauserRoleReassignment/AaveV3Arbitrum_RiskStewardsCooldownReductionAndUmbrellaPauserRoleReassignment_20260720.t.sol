// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {RiskStewardCooldownReductionBaseTest} from './RiskStewardCooldownReductionBaseTest.sol';
import {AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720} from './AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol';

/**
 * @dev Test for AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol -vv
 */
contract AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720_Test is
  RiskStewardCooldownReductionBaseTest
{
  AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 495456603);
    proposal = new AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_riskStewardConfig() public {
    _testRiskStewardConfig(address(proposal), AaveV3Arbitrum.POOL, AaveV3Arbitrum.RISK_STEWARD);
  }
}
