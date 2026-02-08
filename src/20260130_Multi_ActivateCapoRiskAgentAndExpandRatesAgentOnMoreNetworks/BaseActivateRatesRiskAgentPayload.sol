// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IRangeValidationModule} from '../interfaces/IRangeValidationModule.sol';
import {BaseActivateRiskAgentPayload} from './BaseActivateRiskAgentPayload.sol';

/**
 * @title Base contract for activating rates risk agents
 * @author BGD Labs (@bgdlabs)
 * @dev Extends BaseActivateRiskAgentPayload with rates-specific range validation configuration
 */
abstract contract BaseActivateRatesRiskAgentPayload is BaseActivateRiskAgentPayload {
  function _configureRangeValidation(
    address rangeValidationModule,
    address agentHub,
    uint256 agentId
  ) internal override {
    IRangeValidationModule(rangeValidationModule).setDefaultRangeConfig(
      agentHub,
      agentId,
      'VariableRateSlope2',
      IRangeValidationModule.RangeConfig({
        maxIncrease: 4_00, // 4% increase
        maxDecrease: 4_00, // 4% decrease
        isIncreaseRelative: false,
        isDecreaseRelative: false
      })
    );
  }
}
