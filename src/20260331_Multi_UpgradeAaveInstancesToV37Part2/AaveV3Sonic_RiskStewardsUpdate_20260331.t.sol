// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Sonic} from 'aave-address-book/AaveV3Sonic.sol';
import {AaveV3Sonic_RiskStewardsUpdate_20260331} from './AaveV3Sonic_RiskStewardsUpdate_20260331.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3Sonic_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3Sonic_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3Sonic_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3Sonic_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 71036909);
    proposal = new AaveV3Sonic_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Sonic_RiskStewardsUpdate_20260331', AaveV3Sonic.POOL, address(proposal));
  }

  function test_configParity() public view {
    _verifyConfigParity(AaveV3Sonic.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_immutablesParity() public view {
    _verifyImmutablesParity(AaveV3Sonic.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_riskAdminRotated() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3Sonic.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()),
      'new steward not risk admin'
    );
    assertFalse(
      AaveV3Sonic.ACL_MANAGER.isRiskAdmin(AaveV3Sonic.RISK_STEWARD),
      'old steward still risk admin'
    );
  }
}
