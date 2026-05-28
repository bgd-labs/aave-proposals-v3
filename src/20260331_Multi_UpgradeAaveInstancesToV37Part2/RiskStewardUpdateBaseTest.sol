// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'forge-std/Test.sol';
import {IRiskStewardOld} from 'src/interfaces/IRiskStewardOld.sol';
import {IRiskSteward} from 'src/interfaces/IRiskSteward.sol';

/**
 * @dev Shared assertions for the v3.7 RiskSteward update payloads.
 *      Validates that the new steward has the same risk configuration as the
 *      previously deployed one (with `debtCeiling` intentionally skipped, as it
 *      no longer exists in v3.7), and that the immutables / owner match.
 */
abstract contract RiskStewardUpdateBaseTest is Test {
  function _verifyConfigParity(address oldSteward, address newSteward) internal view {
    IRiskStewardOld.Config memory oldConfig = IRiskStewardOld(oldSteward).getRiskConfig();
    IRiskSteward.Config memory newConfig = IRiskSteward(newSteward).getRiskConfig();

    // collateral (debtCeiling intentionally skipped — removed in v3.7)
    _assertParamEq(
      oldConfig.collateralConfig.ltv,
      newConfig.collateralConfig.ltv,
      'collateral.ltv'
    );
    _assertParamEq(
      oldConfig.collateralConfig.liquidationThreshold,
      newConfig.collateralConfig.liquidationThreshold,
      'collateral.liquidationThreshold'
    );
    _assertParamEq(
      oldConfig.collateralConfig.liquidationBonus,
      newConfig.collateralConfig.liquidationBonus,
      'collateral.liquidationBonus'
    );

    // eMode
    _assertParamEq(oldConfig.eModeConfig.ltv, newConfig.eModeConfig.ltv, 'eMode.ltv');
    _assertParamEq(
      oldConfig.eModeConfig.liquidationThreshold,
      newConfig.eModeConfig.liquidationThreshold,
      'eMode.liquidationThreshold'
    );
    _assertParamEq(
      oldConfig.eModeConfig.liquidationBonus,
      newConfig.eModeConfig.liquidationBonus,
      'eMode.liquidationBonus'
    );

    // rates
    _assertParamEq(
      oldConfig.rateConfig.baseVariableBorrowRate,
      newConfig.rateConfig.baseVariableBorrowRate,
      'rate.baseVariableBorrowRate'
    );
    _assertParamEq(
      oldConfig.rateConfig.variableRateSlope1,
      newConfig.rateConfig.variableRateSlope1,
      'rate.variableRateSlope1'
    );
    _assertParamEq(
      oldConfig.rateConfig.variableRateSlope2,
      newConfig.rateConfig.variableRateSlope2,
      'rate.variableRateSlope2'
    );
    _assertParamEq(
      oldConfig.rateConfig.optimalUsageRatio,
      newConfig.rateConfig.optimalUsageRatio,
      'rate.optimalUsageRatio'
    );

    // caps
    _assertParamEq(oldConfig.capConfig.supplyCap, newConfig.capConfig.supplyCap, 'cap.supplyCap');
    _assertParamEq(oldConfig.capConfig.borrowCap, newConfig.capConfig.borrowCap, 'cap.borrowCap');

    // price caps
    _assertParamEq(
      oldConfig.priceCapConfig.priceCapLst,
      newConfig.priceCapConfig.priceCapLst,
      'priceCap.priceCapLst'
    );
    _assertParamEq(
      oldConfig.priceCapConfig.priceCapStable,
      newConfig.priceCapConfig.priceCapStable,
      'priceCap.priceCapStable'
    );
    _assertParamEq(
      oldConfig.priceCapConfig.discountRatePendle,
      newConfig.priceCapConfig.discountRatePendle,
      'priceCap.discountRatePendle'
    );
  }

  function _verifyImmutablesParity(address oldSteward, address newSteward) internal view {
    assertEq(
      address(IRiskSteward(oldSteward).POOL()),
      IRiskSteward(newSteward).POOL(),
      'POOL mismatch'
    );
    assertEq(
      IRiskSteward(oldSteward).RISK_COUNCIL(),
      IRiskSteward(newSteward).RISK_COUNCIL(),
      'RISK_COUNCIL mismatch'
    );
    assertEq(IRiskSteward(oldSteward).owner(), IRiskSteward(newSteward).owner(), 'owner mismatch');
  }

  function _assertParamEq(
    IRiskStewardOld.RiskParamConfig memory a,
    IRiskSteward.RiskParamConfig memory b,
    string memory label
  ) internal pure {
    assertEq(a.minDelay, b.minDelay, string.concat(label, '.minDelay mismatch'));
    assertEq(
      a.maxPercentChange,
      b.maxPercentChange,
      string.concat(label, '.maxPercentChange mismatch')
    );
  }
}
