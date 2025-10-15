// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadPolygon.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title Full Deprecation of DPI Across Aave Deployments
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/direct-to-aip-full-deprecation-of-dpi-across-aave-deployments/23212
 */
contract AaveV3Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008 is AaveV3PayloadPolygon {
  address public constant FIXED_DPI_USD_FEED = 0x105fe43207CE8331555C9Be8c13718d6DeD2fD97;

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3PolygonAssets.DPI_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: 20_00,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: 40_00
      })
    });

    return rateStrategies;
  }

  function collateralsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.CollateralUpdate[] memory)
  {
    IAaveV3ConfigEngine.CollateralUpdate[]
      memory updates = new IAaveV3ConfigEngine.CollateralUpdate[](1);

    updates[0] = IAaveV3ConfigEngine.CollateralUpdate({
      asset: AaveV3PolygonAssets.DPI_UNDERLYING,
      ltv: EngineFlags.KEEP_CURRENT,
      liqThreshold: 5,
      liqBonus: EngineFlags.KEEP_CURRENT,
      debtCeiling: EngineFlags.KEEP_CURRENT,
      liqProtocolFee: EngineFlags.KEEP_CURRENT
    });

    return updates;
  }

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3PolygonAssets.DPI_UNDERLYING,
      priceFeed: FIXED_DPI_USD_FEED
    });

    return priceFeedUpdates;
  }
}
