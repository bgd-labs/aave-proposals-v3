// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRiskSteward} from '../interfaces/IRiskSteward.sol';

library GetRiskConfig {
  function _getRiskConfig() internal pure returns (IRiskSteward.Config memory) {
    return
      IRiskSteward.Config({
        ltv: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 50}),
        liquidationThreshold: IRiskSteward.RiskParamConfig({
          minDelay: 3 days,
          maxPercentChange: 50
        }),
        liquidationBonus: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 50}),
        supplyCap: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 100_00}),
        borrowCap: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 100_00}),
        debtCeiling: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 20_00}),
        baseVariableBorrowRate: IRiskSteward.RiskParamConfig({
          minDelay: 3 days,
          maxPercentChange: 1_00
        }),
        variableRateSlope1: IRiskSteward.RiskParamConfig({
          minDelay: 3 days,
          maxPercentChange: 1_00
        }),
        variableRateSlope2: IRiskSteward.RiskParamConfig({
          minDelay: 3 days,
          maxPercentChange: 20_00
        }),
        optimalUsageRatio: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 3_00}),
        priceCapLst: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 5_00}),
        priceCapStable: IRiskSteward.RiskParamConfig({minDelay: 3 days, maxPercentChange: 50})
      });
  }
}
