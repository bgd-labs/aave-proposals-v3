// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';

abstract contract RiskStewardCooldownReductionBase is IProposalGenericExecutor {
  uint40 public constant NEW_MIN_DELAY = 36 hours;

  function _setRiskStewardMinDelay(address riskStewardAddress) internal {
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
