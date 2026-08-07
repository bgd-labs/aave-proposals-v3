// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRiskSteward} from '../interfaces/IRiskSteward.sol';

library RiskStewardCooldownReduction {
  uint40 internal constant NEW_MIN_DELAY = 36 hours;

  function setRiskStewardMinDelay(address riskStewardAddress) internal {
    IRiskSteward riskSteward = IRiskSteward(riskStewardAddress);
    IRiskSteward.Config memory riskConfig = riskSteward.getRiskConfig();

    riskConfig.rateConfig.baseVariableBorrowRate.minDelay = NEW_MIN_DELAY;
    riskConfig.rateConfig.variableRateSlope1.minDelay = NEW_MIN_DELAY;
    riskConfig.rateConfig.variableRateSlope2.minDelay = NEW_MIN_DELAY;
    riskConfig.rateConfig.optimalUsageRatio.minDelay = NEW_MIN_DELAY;
    riskConfig.capConfig.supplyCap.minDelay = NEW_MIN_DELAY;
    riskConfig.capConfig.borrowCap.minDelay = NEW_MIN_DELAY;

    riskSteward.setRiskConfig(riskConfig);
  }
}
