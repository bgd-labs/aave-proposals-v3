// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3XLayer, AaveV3XLayerAssets} from 'aave-address-book/AaveV3XLayer.sol';
import {AaveV3XLayer_RiskStewardsUpdate_20260331} from './AaveV3XLayer_RiskStewardsUpdate_20260331.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';
import {RiskStewardUpdateBaseTest} from './RiskStewardUpdateBaseTest.sol';

/**
 * @dev Test for AaveV3XLayer_RiskStewardsUpdate_20260331
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260331_Multi_UpgradeAaveInstancesToV37Part2/AaveV3XLayer_RiskStewardsUpdate_20260331.t.sol -vv
 */
contract AaveV3XLayer_RiskStewardsUpdate_20260331_Test is
  ProtocolV3TestBase,
  RiskStewardUpdateBaseTest
{
  AaveV3XLayer_RiskStewardsUpdate_20260331 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('xlayer'), 60436326);
    proposal = new AaveV3XLayer_RiskStewardsUpdate_20260331();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3XLayer_RiskStewardsUpdate_20260331', AaveV3XLayer.POOL, address(proposal));
  }

  function test_configParity() public view {
    _verifyConfigParity(AaveV3XLayer.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_immutablesParity() public view {
    _verifyImmutablesParity(AaveV3XLayer.RISK_STEWARD, proposal.NEW_RISK_STEWARD());
  }

  function test_riskAdminRotated() public {
    executePayload(vm, address(proposal));
    assertTrue(
      AaveV3XLayer.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()),
      'new steward not risk admin'
    );
    assertFalse(
      AaveV3XLayer.ACL_MANAGER.isRiskAdmin(AaveV3XLayer.RISK_STEWARD),
      'old steward still risk admin'
    );
  }

  function test_ghoBlacklisted() public {
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3XLayerAssets.GHO_UNDERLYING
      ),
      'GHO not restricted on new steward'
    );
  }
}
