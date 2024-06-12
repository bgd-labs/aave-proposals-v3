// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV2PayloadPolygon} from 'aave-helpers/v2-config-engine/AaveV2PayloadPolygon.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/v2-config-engine/IV2RateStrategyFactory.sol';
/**
 * @title Optimize ETH-correlated asset parameters
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x3d79b416cfa6c70a85d03d07148d3a2025b88f294694d76fb101167af332c2fc
 * - Discussion: https://governance.aave.com/t/arfc-optimize-eth-correlated-asset-parameters/17886
 */
contract AaveV2Polygon_OptimizeETHCorrelatedAssetParameters_20240612 is AaveV2PayloadPolygon {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2PolygonAssets.WETH_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(2_70),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
