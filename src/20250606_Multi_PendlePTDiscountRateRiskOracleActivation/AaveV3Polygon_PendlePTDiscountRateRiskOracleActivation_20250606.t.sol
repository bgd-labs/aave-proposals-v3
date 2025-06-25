// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606} from './AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {BaseStewardUpdateTest} from './BaseStewardUpdateTest.t.sol';

/**
 * @dev Test for AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase,
  BaseStewardUpdateTest
{
  AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 72431826);
    proposal = new AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606();
  }

  function getBaseTestInput() public virtual override returns (ValidationInput memory) {
    return
      ValidationInput({
        payload: address(proposal),
        aclManager: address(AaveV3Polygon.ACL_MANAGER),
        currentRiskSteward: AaveV3Polygon.RISK_STEWARD,
        newRiskSteward: proposal.NEW_RISK_STEWARD(),
        freezingSteward: AaveV3Polygon.FREEZING_STEWARD,
        capsPlusSteward: AaveV3Polygon.CAPS_PLUS_RISK_STEWARD
      });
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
