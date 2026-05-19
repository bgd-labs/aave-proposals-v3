// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3MegaEth} from 'aave-address-book/AaveV3MegaEth.sol';
import {AaveV3MegaEth_RiskStewardsUpdate_20260331} from './AaveV3MegaEth_RiskStewardsUpdate_20260331.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3MegaEth_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3MegaEth_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3MegaEth_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3MegaEth_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 16407671);
    proposal = new AaveV3MegaEth_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3MegaEth_RiskStewardsUpdate_20260331', AaveV3MegaEth.POOL, address(proposal));
  }

  function test_configParity() public view {
    _verifyConfigParity(AaveV3MegaEth.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_immutablesParity() public view {
    _verifyImmutablesParity(AaveV3MegaEth.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_riskAdminRotated() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3MegaEth.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()),
      'new steward not risk admin'
    );
    assertFalse(
      AaveV3MegaEth.ACL_MANAGER.isRiskAdmin(AaveV3MegaEth.RISK_STEWARD),
      'old steward still risk admin'
    );
  }
}
