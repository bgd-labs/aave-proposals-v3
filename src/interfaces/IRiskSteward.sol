// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// MODIFIED: I removed a functions to not have to import CAPO and it's dependencies

import {IPool} from 'aave-address-book/AaveV3.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title IRiskSteward
 * @author BGD labs
 * @notice Defines the interface for the contract to manage the risk params updates on aave v3 pool
 */
interface IRiskSteward {
  /**
   * @notice Struct storing the last update by the steward of risk param
   */
  struct Debounce {
    uint40 supplyCapLastUpdated;
    uint40 borrowCapLastUpdated;
    uint40 ltvLastUpdated;
    uint40 liquidationBonusLastUpdated;
    uint40 liquidationThresholdLastUpdated;
    uint40 debtCeilingLastUpdated;
    uint40 baseVariableRateLastUpdated;
    uint40 variableRateSlope1LastUpdated;
    uint40 variableRateSlope2LastUpdated;
    uint40 optimalUsageRatioLastUpdated;
    uint40 priceCapLastUpdated;
  }

  /**
   * @notice Struct storing the last update by the steward of eMode risk param
   */
  struct EModeDebounce {
    uint40 eModeLtvLastUpdated;
    uint40 eModeLiquidationBonusLastUpdated;
    uint40 eModeLiquidationThresholdLastUpdated;
  }

  /**
   * @notice Struct storing the params used for validation of the risk param update
   * @param currentValue the current value of the risk param
   * @param newValue the new value of the risk param
   * @param lastUpdated timestamp when the risk param was last updated by the steward
   * @param riskConfig the risk configuration containing the minimum delay and the max percent change allowed for the risk param
   * @param isChangeRelative true, if risk param change is relative in value, false if risk param change is absolute in value
   */
  struct ParamUpdateValidationInput {
    uint256 currentValue;
    uint256 newValue;
    uint40 lastUpdated;
    RiskParamConfig riskConfig;
    bool isChangeRelative;
  }

  /**
   * @notice Struct storing the minimum delay and maximum percent change for a risk param
   */
  struct RiskParamConfig {
    uint40 minDelay;
    uint256 maxPercentChange;
  }

  /**
   * @notice Struct storing the risk configuration for all the risk param
   */
  struct Config {
    CollateralConfig collateralConfig;
    EmodeConfig eModeConfig;
    RateConfig rateConfig;
    CapConfig capConfig;
    PriceCapConfig priceCapConfig;
  }

  /**
   * @notice Struct storing the risk configuration for collateral side param
   */
  struct CollateralConfig {
    RiskParamConfig ltv;
    RiskParamConfig liquidationThreshold;
    RiskParamConfig liquidationBonus;
    RiskParamConfig debtCeiling;
  }

  /**
   * @notice Struct storing the risk configuration for emode category param
   */
  struct EmodeConfig {
    RiskParamConfig ltv;
    RiskParamConfig liquidationThreshold;
    RiskParamConfig liquidationBonus;
  }

  /**
   * @notice Struct storing the risk configuration for rate param
   */
  struct RateConfig {
    RiskParamConfig baseVariableBorrowRate;
    RiskParamConfig variableRateSlope1;
    RiskParamConfig variableRateSlope2;
    RiskParamConfig optimalUsageRatio;
  }

  /**
   * @notice Struct storing the risk configuration for cap param
   */
  struct CapConfig {
    RiskParamConfig supplyCap;
    RiskParamConfig borrowCap;
  }

  /**
   * @notice Struct storing the risk configuration for price cap param
   */
  struct PriceCapConfig {
    RiskParamConfig priceCapLst;
    RiskParamConfig priceCapStable;
    RiskParamConfig discountRatePendle;
  }

  /**
   * @notice Struct used to update the stable cap params
   */
  struct PriceCapStableUpdate {
    address oracle;
    uint256 priceCap;
  }

  /**
   * @notice Struct used to update the pendle cap params
   */
  struct DiscountRatePendleUpdate {
    address oracle;
    uint256 discountRate;
  }

  /**
   * @notice The config engine used to perform the cap update via delegatecall
   */
  function CONFIG_ENGINE() external view returns (IEngine);

  /**
   * @notice The aave pool of the instance steward controls
   */
  function POOL() external view returns (IPool);

  /**
   * @notice The safe controlling the steward
   */
  function RISK_COUNCIL() external view returns (address);

  /**
   * @notice Allows increasing borrow and supply caps across multiple assets
   * @dev A cap update is only possible after minDelay has passed after last update
   * @dev A cap increase / decrease is only allowed by a magnitude of maxPercentChange
   * @param capUpdates struct containing new caps to be updated
   */
  function updateCaps(IEngine.CapsUpdate[] calldata capUpdates) external;

  /**
   * @notice Allows updating interest rates params across multiple assets
   * @dev A rate update is only possible after minDelay has passed after last update
   * @dev A rate increase / decrease is only allowed by a magnitude of maxPercentChange
   * @param rateUpdates struct containing new interest rate params to be updated
   */
  function updateRates(IEngine.RateStrategyUpdate[] calldata rateUpdates) external;

  /**
   * @notice Allows updating collateral params across multiple assets
   * @dev A collateral update is only possible after minDelay has passed after last update
   * @dev A collateral increase / decrease is only allowed by a magnitude of maxPercentChange
   * @param collateralUpdates struct containing new collateral rate params to be updated
   */
  function updateCollateralSide(IEngine.CollateralUpdate[] calldata collateralUpdates) external;

  /**
   * @notice Allows updating eMode category params across multiple eMode ids
   * @dev A eMode category update is only possible after minDelay has passed after last update
   * @dev A eMode category increase / decrease is only allowed by a magnitude of maxPercentChange
   * @param eModeCategoryUpdates struct containing new eMode category params to be updated
   */
  function updateEModeCategories(
    IEngine.EModeCategoryUpdate[] calldata eModeCategoryUpdates
  ) external;

  /**
   * @notice Allows updating price cap params across multiple oracles
   * @dev A price cap update is only possible after minDelay has passed after last update
   * @dev A price cap increase / decrease is only allowed by a magnitude of maxPercentChange
   * @param priceCapUpdates struct containing new price cap params to be updated
   */
  function updateStablePriceCaps(PriceCapStableUpdate[] calldata priceCapUpdates) external;

  /**
   * @notice Allows updating pendle price cap params (i.e discount rate) across multiple oracles
   * @dev A price cap (i.e discount rate) update is only possible after minDelay has passed after last update
   * @dev A price cap (i.e discount rate) increase / decrease is only allowed by a magnitude of maxPercentChange
   * @param discountRateUpdates struct containing new price cap params (i.e discount rate) to be updated
   */
  function updatePendleDiscountRates(
    DiscountRatePendleUpdate[] calldata discountRateUpdates
  ) external;

  /**
   * @notice method to check if an asset/oracle is restricted to be used by the risk stewards
   * @param contractAddress address of the underlying asset or oracle
   * @return bool if asset is restricted or not
   */
  function isAddressRestricted(address contractAddress) external view returns (bool);

  /**
   * @notice method to check if an eMode category id is restricted to be used by the risk stewards
   * @param eModeCategoryId the id of the eMode category
   * @return bool if eModeCategoryId is restricted or not
   */
  function isEModeCategoryRestricted(uint8 eModeCategoryId) external view returns (bool);

  /**
   * @notice method called by the owner to set an asset/oracle as restricted
   * @param contractAddress address of the underlying asset or oracle
   * @param isRestricted true if asset needs to be restricted, false otherwise
   */
  function setAddressRestricted(address contractAddress, bool isRestricted) external;

  /**
   * @notice method called by the owner to set an eMode category as restricted
   * @param eModeCategoryId the id of the eMode category
   * @param isRestricted true if eModeCategoryId needs to be restricted, false otherwise
   */
  function setEModeCategoryRestricted(uint8 eModeCategoryId, bool isRestricted) external;

  /**
   * @notice Returns the timelock for a specific asset i.e the last updated timestamp
   * @param asset for which to fetch the timelock
   * @return struct containing the latest updated timestamps of all the risk params by the steward per asset
   */
  function getTimelock(address asset) external view returns (Debounce memory);

  /**
   * @notice Returns the timelock for a specific eMode category id i.e the last updated timestamp
   * @param eModeCategoryId the eMode category for which to fetch the timelock
   * @return struct containing the latest updated timestamps of eMode risk params by the steward
   */
  function getEModeTimelock(uint8 eModeCategoryId) external view returns (EModeDebounce memory);

  /**
   * @notice method to get the risk configuration set for all the risk params
   * @return struct containing the risk configurations
   */
  function getRiskConfig() external view returns (Config memory);

  /**
   * @notice method called by the owner to set the risk configuration for the risk params
   * @param riskConfig struct containing the risk configurations
   */
  function setRiskConfig(Config memory riskConfig) external;
}
