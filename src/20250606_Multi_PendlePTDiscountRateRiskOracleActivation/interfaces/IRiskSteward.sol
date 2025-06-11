// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title IRiskSteward
 * @author BGD labs
 * @notice Defines the interface for the contract to manage the risk params updates on aave v3 pool
 */
interface IRiskSteward {
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
   * @notice method to check if an asset/oracle is restricted to be used by the risk stewards
   * @param contractAddress address of the underlying asset or oracle
   * @return bool if asset is restricted or not
   */
  function isAddressRestricted(address contractAddress) external view returns (bool);

  /**
   * @notice method called by the owner to set an asset/oracle as restricted
   * @param contractAddress address of the underlying asset or oracle
   * @param isRestricted true if asset needs to be restricted, false otherwise
   */
  function setAddressRestricted(address contractAddress, bool isRestricted) external;

  /**
   * @notice method to get the risk configuration set for all the risk params
   * @return struct containing the risk configurations
   */
  function getRiskConfig() external view returns (Config memory);
}
