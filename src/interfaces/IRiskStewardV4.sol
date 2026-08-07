// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV4ConfigEngine as IConfigEngine, IHubConfigurator, ISpokeConfigurator} from 'aave-address-book/AaveV4.sol';

/**
 * @title IRiskStewardV4
 * @author Aave Labs
 * @notice Trimmed mirror of the Aave V4 RiskSteward, exposing the owner-set `Config` layout
 *         and the council entrypoints. Full source at aave-dao/aave-v4-risk-stewards.
 */
interface IRiskStewardV4 {
  error DebounceNotRespected();

  error UpdateNotInRange();

  struct RiskParamConfig {
    uint40 minDelay;
    uint208 maxPercentChange;
    bool isChangeRelative;
  }

  struct HubRateConfig {
    RiskParamConfig optimalUsageRatio;
    RiskParamConfig baseDrawnRate;
    RiskParamConfig rateGrowthBeforeOptimal;
    RiskParamConfig rateGrowthAfterOptimal;
  }

  struct HubCapConfig {
    RiskParamConfig addCap;
    RiskParamConfig drawCap;
  }

  struct HubConfig {
    IHubConfigurator configurator;
    HubRateConfig rate;
    HubCapConfig cap;
  }

  struct SpokeDynamicConfig {
    RiskParamConfig collateralFactor;
    RiskParamConfig maxLiquidationBonus;
  }

  struct SpokeLiquidationConfig {
    RiskParamConfig targetHealthFactor;
    RiskParamConfig healthFactorForMaxBonus;
    RiskParamConfig liquidationBonusFactor;
  }

  struct SpokeConfig {
    ISpokeConfigurator configurator;
    RiskParamConfig collateralRisk;
    SpokeDynamicConfig dynamicUpdate;
    SpokeDynamicConfig dynamicAdd;
    SpokeLiquidationConfig liquidation;
  }

  struct OracleConfig {
    RiskParamConfig priceCapLst;
    RiskParamConfig priceCapStable;
    RiskParamConfig discountRatePendle;
  }

  struct Config {
    HubConfig hub;
    SpokeConfig spoke;
    OracleConfig oracle;
  }

  function setConfig(Config calldata config) external;

  function updateHubSpokeCaps(IConfigEngine.SpokeConfigUpdate[] calldata updates) external;

  function getConfig() external view returns (Config memory);

  function RISK_COUNCIL() external view returns (address);

  function owner() external view returns (address);
}
