// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606} from './AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {BaseStewardUpdateTest} from './BaseStewardUpdateTest.t.sol';

/**
 * @dev Test for AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase,
  BaseStewardUpdateTest
{
  AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 40443833);
    proposal = new AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606();
  }

  function getBaseTestInput() public virtual override returns (ValidationInput memory) {
    return
      ValidationInput({
        payload: address(proposal),
        aclManager: address(AaveV3Gnosis.ACL_MANAGER),
        currentRiskSteward: AaveV3Gnosis.RISK_STEWARD,
        newRiskSteward: proposal.NEW_RISK_STEWARD(),
        freezingSteward: AaveV3Gnosis.FREEZING_STEWARD,
        capsPlusSteward: AaveV3Gnosis.CAPS_PLUS_RISK_STEWARD
      });
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
