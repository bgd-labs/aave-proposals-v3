// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606} from './AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {BaseStewardUpdateTest} from './BaseStewardUpdateTest.t.sol';

/**
 * @dev Test for AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase,
  BaseStewardUpdateTest
{
  AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 344491817);
    proposal = new AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606();
  }

  function getBaseTestInput() public virtual override returns (ValidationInput memory) {
    return
      ValidationInput({
        payload: address(proposal),
        aclManager: address(AaveV3Arbitrum.ACL_MANAGER),
        currentRiskSteward: AaveV3Arbitrum.RISK_STEWARD,
        newRiskSteward: proposal.NEW_RISK_STEWARD(),
        freezingSteward: AaveV3Arbitrum.FREEZING_STEWARD,
        capsPlusSteward: AaveV3Arbitrum.CAPS_PLUS_RISK_STEWARD
      });
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_steward_restricted() public {
    // GHO is restricted as the risk param for GHO should be updated by GHO steward
    assertFalse(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3ArbitrumAssets.GHO_UNDERLYING
      )
    );
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3ArbitrumAssets.GHO_UNDERLYING
      )
    );
  }
}
