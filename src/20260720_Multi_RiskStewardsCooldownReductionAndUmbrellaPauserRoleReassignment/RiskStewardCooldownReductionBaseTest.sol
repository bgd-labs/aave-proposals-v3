// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';

abstract contract RiskStewardCooldownReductionBaseTest is ProtocolV3TestBase {
  uint40 internal constant NEW_MIN_DELAY = 36 hours;

  function _testRiskStewardConfig(
    address payload,
    IPool pool,
    address riskStewardAddress
  ) internal {
    IRiskSteward riskSteward = IRiskSteward(riskStewardAddress);
    IRiskSteward.Config memory beforeConfig = riskSteward.getRiskConfig();

    assertEq(beforeConfig.rateConfig.baseVariableBorrowRate.minDelay, 72 hours);
    assertEq(beforeConfig.rateConfig.variableRateSlope1.minDelay, 72 hours);
    assertEq(beforeConfig.rateConfig.variableRateSlope2.minDelay, 72 hours);
    assertEq(beforeConfig.rateConfig.optimalUsageRatio.minDelay, 72 hours);
    assertEq(beforeConfig.capConfig.supplyCap.minDelay, 72 hours);
    assertEq(beforeConfig.capConfig.borrowCap.minDelay, 72 hours);

    executePayload(vm, payload, pool);

    IRiskSteward.Config memory afterConfig = riskSteward.getRiskConfig();

    beforeConfig.rateConfig.baseVariableBorrowRate.minDelay = NEW_MIN_DELAY;
    beforeConfig.rateConfig.variableRateSlope1.minDelay = NEW_MIN_DELAY;
    beforeConfig.rateConfig.variableRateSlope2.minDelay = NEW_MIN_DELAY;
    beforeConfig.rateConfig.optimalUsageRatio.minDelay = NEW_MIN_DELAY;
    beforeConfig.capConfig.supplyCap.minDelay = NEW_MIN_DELAY;
    beforeConfig.capConfig.borrowCap.minDelay = NEW_MIN_DELAY;

    assertEq(keccak256(abi.encode(afterConfig)), keccak256(abi.encode(beforeConfig)));
  }
}
