// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606} from './AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {BaseStewardUpdateTest} from './BaseStewardUpdateTest.t.sol';

/**
 * @dev Test for AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase,
  BaseStewardUpdateTest
{
  AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 16265405);
    proposal = new AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606();
  }

  function getBaseTestInput() public virtual override returns (ValidationInput memory) {
    return
      ValidationInput({
        payload: address(proposal),
        aclManager: address(AaveV3Scroll.ACL_MANAGER),
        currentRiskSteward: AaveV3Scroll.RISK_STEWARD,
        newRiskSteward: proposal.NEW_RISK_STEWARD(),
        freezingSteward: AaveV3Scroll.FREEZING_STEWARD,
        capsPlusSteward: AaveV3Scroll.CAPS_PLUS_RISK_STEWARD
      });
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }
}
