// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';
import {AaveV3PayloadSonic} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadSonic.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title wS and BTC.b Interest Rate Curve Optimization
 * @author Aave-Chan Initiative
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-ws-and-btc-b-interest-rate-curve-optimization/21962
 */
contract AaveV3Sonic_WSAndBTCBInterestRateCurveOptimization_20250722 is AaveV3PayloadSonic {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3SonicAssets.wS_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 80_00,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 4_00,
        variableRateSlope2: 80_00
      })
    });

    return rateStrategies;
  }
}
