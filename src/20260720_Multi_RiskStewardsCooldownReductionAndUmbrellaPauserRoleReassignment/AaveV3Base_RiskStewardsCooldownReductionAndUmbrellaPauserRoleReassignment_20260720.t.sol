// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {RiskStewardCooldownReductionBaseTest} from './RiskStewardCooldownReductionBaseTest.sol';
import {AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720} from './AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.sol';

/**
 * @dev Test for AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260720_Multi_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment/AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720.t.sol -vv
 */
contract AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720_Test is
  RiskStewardCooldownReductionBaseTest
{
  AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720
    internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 50087033);
    proposal = new AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   * forge-config: default.isolate = true
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_RiskStewardsCooldownReductionAndUmbrellaPauserRoleReassignment_20260720',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  /**
   * @dev checks whether reserve configurations changed or stayed unchanged as expected
   */
  function test_riskStewardConfig() public {
    _testRiskStewardConfig(address(proposal), AaveV3Base.POOL, AaveV3Base.RISK_STEWARD);
  }
}
