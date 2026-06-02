// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3Base_RiskStewardsUpdate_20260331} from './AaveV3Base_RiskStewardsUpdate_20260331.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3Base_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3Base_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3Base_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3Base_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 46206252);
    proposal = new AaveV3Base_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_RiskStewardsUpdate_20260331', AaveV3Base.POOL, address(proposal));
  }

  function test_configParity() public view {
    _verifyConfigParity(AaveV3Base.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_immutablesParity() public view {
    _verifyImmutablesParity(AaveV3Base.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_riskAdminRotated() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3Base.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()),
      'new steward not risk admin'
    );
    assertFalse(
      AaveV3Base.ACL_MANAGER.isRiskAdmin(AaveV3Base.RISK_STEWARD),
      'old steward still risk admin'
    );
  }

  function test_ghoBlacklisted() public {
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3BaseAssets.GHO_UNDERLYING
      ),
      'GHO not restricted on new steward'
    );
  }
}
