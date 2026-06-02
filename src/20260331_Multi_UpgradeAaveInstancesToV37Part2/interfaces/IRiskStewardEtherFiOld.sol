// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @notice Mirror of the (older) RiskSteward layout deployed on Aave V3 EtherFi.
 *         Differs from the regular pre-v3.7 layout: `Config` is flat (no
 *         `CollateralConfig` / `EmodeConfig` / etc. sub-structs), there is no
 *         `eMode` block or `discountRatePendle`, and the steward exposes
 *         `POOL_DATA_PROVIDER` instead of `POOL`. Used to ABI-decode
 *         `getRiskConfig()` from the old EtherFi steward on-chain.
 */
interface IRiskStewardEtherFiOld {
  struct RiskParamConfig {
    uint40 minDelay;
    uint256 maxPercentChange;
  }

  struct Config {
    RiskParamConfig ltv;
    RiskParamConfig liquidationThreshold;
    RiskParamConfig liquidationBonus;
    RiskParamConfig supplyCap;
    RiskParamConfig borrowCap;
    RiskParamConfig debtCeiling;
    RiskParamConfig baseVariableBorrowRate;
    RiskParamConfig variableRateSlope1;
    RiskParamConfig variableRateSlope2;
    RiskParamConfig optimalUsageRatio;
    RiskParamConfig priceCapLst;
    RiskParamConfig priceCapStable;
  }

  function POOL_DATA_PROVIDER() external view returns (address);

  function RISK_COUNCIL() external view returns (address);

  function owner() external view returns (address);

  function getRiskConfig() external view returns (Config memory);
}
