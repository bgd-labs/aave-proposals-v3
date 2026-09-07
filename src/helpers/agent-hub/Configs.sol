// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

library AgentHubConfigs {
  string constant DISCOUNT_UPDATE_TYPE = 'PendleDiscountRateUpdate';
  string constant EMODE_UPDATE_TYPE = 'EModeCategoryUpdate';

  uint256 constant DISCOUNT_MINIMUM_DELAY = 2 days;
  uint256 constant EMODE_MINIMUM_DELAY = 3 days;

  uint256 constant DISCOUNT_EXPIRATION_PERIOD = 2 days;
  uint256 constant EMODE_EXPIRATION_PERIOD = 3 days;

  uint120 constant DISCOUNT_RANGE_ABS = 1e16;
  uint120 constant EMODE_RANGE_ABS_BPS = 50;
}
