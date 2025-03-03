// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2PayloadPolygon} from 'aave-helpers/src/v2-config-engine/AaveV2PayloadPolygon.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';
/**
 * @title Aave V2 Deprecation Update
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51
 * - Discussion: https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918
 */
contract AaveV2Polygon_AaveV2DeprecationUpdate_20250220 is AaveV2PayloadPolygon {
  function _postExecute() internal override {
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.CRV_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.LINK_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.BAL_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.USDT_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.WETH_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.USDC_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.WBTC_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.WPOL_UNDERLYING);
    AaveV2Polygon.POOL_CONFIGURATOR.disableBorrowingOnReserve(AaveV2PolygonAssets.DAI_UNDERLYING);
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](4);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.GHST_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: 0,
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.BAL_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: 0,
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[2] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.CRV_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: 0,
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[3] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.LINK_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: 0,
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
