// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {AaveV3Gnosis_RiskStewardsUpdate_20260331} from './AaveV3Gnosis_RiskStewardsUpdate_20260331.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3Gnosis_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3Gnosis_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3Gnosis_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3Gnosis_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 46256381);
    proposal = new AaveV3Gnosis_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_RiskStewardsUpdate_20260331', AaveV3Gnosis.POOL, address(proposal));
  }

  function test_configParity() public view {
    _verifyConfigParity(AaveV3Gnosis.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_immutablesParity() public view {
    _verifyImmutablesParity(AaveV3Gnosis.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_riskAdminRotated() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3Gnosis.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()),
      'new steward not risk admin'
    );
    assertFalse(
      AaveV3Gnosis.ACL_MANAGER.isRiskAdmin(AaveV3Gnosis.RISK_STEWARD),
      'old steward still risk admin'
    );
  }

  function test_ghoBlacklisted() public {
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3GnosisAssets.GHO_UNDERLYING
      ),
      'GHO not restricted on new steward'
    );
  }
}
