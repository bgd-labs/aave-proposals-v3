// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IRiskSteward
 * @author BGD labs
 * @notice Mirror of the post-v3.7 RiskSteward.Config layout, where `CollateralConfig`
 *         no longer carries `debtCeiling`. Used to ABI-decode `getRiskConfig()`
 *         from the new stewards being granted RISK_ADMIN by this proposal.
 */
interface IRiskSteward {
  struct RiskParamConfig {
    uint40 minDelay;
    uint256 maxPercentChange;
  }

  struct CollateralConfig {
    RiskParamConfig ltv;
    RiskParamConfig liquidationThreshold;
    RiskParamConfig liquidationBonus;
  }

  struct EmodeConfig {
    RiskParamConfig ltv;
    RiskParamConfig liquidationThreshold;
    RiskParamConfig liquidationBonus;
  }

  struct RateConfig {
    RiskParamConfig baseVariableBorrowRate;
    RiskParamConfig variableRateSlope1;
    RiskParamConfig variableRateSlope2;
    RiskParamConfig optimalUsageRatio;
  }

  struct CapConfig {
    RiskParamConfig supplyCap;
    RiskParamConfig borrowCap;
  }

  struct PriceCapConfig {
    RiskParamConfig priceCapLst;
    RiskParamConfig priceCapStable;
    RiskParamConfig discountRatePendle;
  }

  struct Config {
    CollateralConfig collateralConfig;
    EmodeConfig eModeConfig;
    RateConfig rateConfig;
    CapConfig capConfig;
    PriceCapConfig priceCapConfig;
  }

  function POOL() external view returns (address);

  function RISK_COUNCIL() external view returns (address);

  function owner() external view returns (address);

  function getRiskConfig() external view returns (Config memory);

  function setAddressRestricted(address contractAddress, bool isRestricted) external;

  function isAddressRestricted(address contractAddress) external view returns (bool);
}
