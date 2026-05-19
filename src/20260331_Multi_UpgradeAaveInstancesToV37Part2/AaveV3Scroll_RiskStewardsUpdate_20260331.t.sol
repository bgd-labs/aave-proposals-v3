// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3Scroll_RiskStewardsUpdate_20260331} from './AaveV3Scroll_RiskStewardsUpdate_20260331.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3Scroll_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3Scroll_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3Scroll_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3Scroll_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 33761258);
    proposal = new AaveV3Scroll_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_RiskStewardsUpdate_20260331',
      AaveV3Scroll.POOL,
      address(proposal),
      false,
      false
    );
  }

  function test_configParity() public view {
    _verifyConfigParity(AaveV3Scroll.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_immutablesParity() public view {
    _verifyImmutablesParity(AaveV3Scroll.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_riskAdminRotated() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3Scroll.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()),
      'new steward not risk admin'
    );
    assertFalse(
      AaveV3Scroll.ACL_MANAGER.isRiskAdmin(AaveV3Scroll.RISK_STEWARD),
      'old steward still risk admin'
    );
  }
}
