// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IACLManager} from 'aave-v3-origin/contracts/interfaces/IACLManager.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IRiskSteward as IOldRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {Test} from 'forge-std/Test.sol';

abstract contract BaseStewardUpdateTest is Test {
  struct ValidationInput {
    address payload;
    address aclManager;
    address currentRiskSteward;
    address newRiskSteward;
    address freezingSteward;
    address capsPlusSteward;
  }

  function getBaseTestInput() public virtual returns (ValidationInput memory);

  function test_permissions() public {
    ValidationInput memory input = getBaseTestInput();
    IACLManager ACL_MANAGER = IACLManager(input.aclManager);

    if (input.currentRiskSteward != address(0))
      assertTrue(ACL_MANAGER.isRiskAdmin(input.currentRiskSteward));
    if (input.newRiskSteward != address(0))
      assertFalse(ACL_MANAGER.isRiskAdmin(input.newRiskSteward));
    if (input.freezingSteward != address(0))
      assertTrue(ACL_MANAGER.isRiskAdmin(input.freezingSteward));
    if (input.capsPlusSteward != address(0))
      assertTrue(ACL_MANAGER.isRiskAdmin(input.capsPlusSteward));

    GovV3Helpers.executePayload(vm, input.payload);

    if (input.currentRiskSteward != address(0))
      assertFalse(ACL_MANAGER.isRiskAdmin(input.currentRiskSteward));
    if (input.newRiskSteward != address(0))
      assertTrue(ACL_MANAGER.isRiskAdmin(input.newRiskSteward));
    if (input.freezingSteward != address(0))
      assertFalse(ACL_MANAGER.isRiskAdmin(input.freezingSteward));
    if (input.capsPlusSteward != address(0))
      assertFalse(ACL_MANAGER.isRiskAdmin(input.capsPlusSteward));
  }

  function test_risk_steward_configurations() public {
    ValidationInput memory input = getBaseTestInput();

    IOldRiskSteward currentSteward = IOldRiskSteward(input.currentRiskSteward);
    IRiskSteward newSteward = IRiskSteward(input.newRiskSteward);

    IOldRiskSteward.Config memory oldConfig = currentSteward.getRiskConfig();
    IRiskSteward.Config memory newConfig = newSteward.getRiskConfig();

    assertEq(oldConfig.ltv.minDelay, newConfig.collateralConfig.ltv.minDelay);
    assertEq(oldConfig.ltv.maxPercentChange, newConfig.collateralConfig.ltv.maxPercentChange);
    assertEq(
      oldConfig.liquidationThreshold.minDelay,
      newConfig.collateralConfig.liquidationThreshold.minDelay
    );
    assertEq(
      oldConfig.liquidationThreshold.maxPercentChange,
      newConfig.collateralConfig.liquidationThreshold.maxPercentChange
    );
    assertEq(
      oldConfig.liquidationBonus.minDelay,
      newConfig.collateralConfig.liquidationBonus.minDelay
    );
    assertEq(
      oldConfig.liquidationBonus.maxPercentChange,
      newConfig.collateralConfig.liquidationBonus.maxPercentChange
    );
    assertEq(oldConfig.debtCeiling.minDelay, newConfig.collateralConfig.debtCeiling.minDelay);
    assertEq(
      oldConfig.debtCeiling.maxPercentChange,
      newConfig.collateralConfig.debtCeiling.maxPercentChange
    );

    assertEq(
      oldConfig.baseVariableBorrowRate.minDelay,
      newConfig.rateConfig.baseVariableBorrowRate.minDelay
    );
    assertEq(
      oldConfig.baseVariableBorrowRate.maxPercentChange,
      newConfig.rateConfig.baseVariableBorrowRate.maxPercentChange
    );
    assertEq(
      oldConfig.variableRateSlope1.minDelay,
      newConfig.rateConfig.variableRateSlope1.minDelay
    );
    assertEq(
      oldConfig.variableRateSlope1.maxPercentChange,
      newConfig.rateConfig.variableRateSlope1.maxPercentChange
    );
    assertEq(
      oldConfig.variableRateSlope2.minDelay,
      newConfig.rateConfig.variableRateSlope2.minDelay
    );
    assertEq(
      oldConfig.variableRateSlope2.maxPercentChange,
      newConfig.rateConfig.variableRateSlope2.maxPercentChange
    );
    assertEq(oldConfig.optimalUsageRatio.minDelay, newConfig.rateConfig.optimalUsageRatio.minDelay);
    assertEq(
      oldConfig.optimalUsageRatio.maxPercentChange,
      newConfig.rateConfig.optimalUsageRatio.maxPercentChange
    );

    assertEq(oldConfig.supplyCap.minDelay, newConfig.capConfig.supplyCap.minDelay);
    assertEq(oldConfig.supplyCap.maxPercentChange, newConfig.capConfig.supplyCap.maxPercentChange);
    assertEq(oldConfig.borrowCap.minDelay, newConfig.capConfig.borrowCap.minDelay);
    assertEq(oldConfig.borrowCap.maxPercentChange, newConfig.capConfig.borrowCap.maxPercentChange);

    assertEq(oldConfig.priceCapLst.minDelay, newConfig.priceCapConfig.priceCapLst.minDelay);
    assertEq(
      oldConfig.priceCapLst.maxPercentChange,
      newConfig.priceCapConfig.priceCapLst.maxPercentChange
    );
    assertEq(oldConfig.priceCapStable.minDelay, newConfig.priceCapConfig.priceCapStable.minDelay);
    assertEq(
      oldConfig.priceCapStable.maxPercentChange,
      newConfig.priceCapConfig.priceCapStable.maxPercentChange
    );

    assertEq(newConfig.priceCapConfig.discountRatePendle.maxPercentChange, 0.025e18); // 2.5% absolute change
    assertEq(newConfig.priceCapConfig.discountRatePendle.minDelay, 2 days);

    assertEq(newConfig.eModeConfig.ltv.minDelay, 3 days);
    assertEq(newConfig.eModeConfig.ltv.maxPercentChange, 50);
    assertEq(newConfig.eModeConfig.liquidationThreshold.minDelay, 3 days);
    assertEq(newConfig.eModeConfig.liquidationThreshold.maxPercentChange, 10);
    assertEq(newConfig.eModeConfig.liquidationBonus.minDelay, 3 days);
    assertEq(newConfig.eModeConfig.liquidationBonus.maxPercentChange, 50);

    // validate immutables
    assertEq(address(currentSteward.CONFIG_ENGINE()), address(newSteward.CONFIG_ENGINE()));
    assertEq(address(currentSteward.RISK_COUNCIL()), address(newSteward.RISK_COUNCIL()));
    assertEq(
      currentSteward.POOL_DATA_PROVIDER().ADDRESSES_PROVIDER().getPool(),
      address(newSteward.POOL())
    );
  }
}
