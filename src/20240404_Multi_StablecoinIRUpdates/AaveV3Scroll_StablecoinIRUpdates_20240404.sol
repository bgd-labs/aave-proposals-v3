// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3PayloadScroll} from 'aave-helpers/v3-config-engine/AaveV3PayloadScroll.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
/**
 * @title StablecoinIRUpdates
 * @author Chaos Labs, ACI
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xe2dd228640c3cad93f5418c40c4b5743b3c6c85aa0aae9eee53cbdbca2ed5c2d
 * - Discussion: https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3/16864/5
 */
contract AaveV3Scroll_StablecoinIRUpdates_20240404 is AaveV3PayloadScroll {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ScrollAssets.USDC_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(12_00),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT,
        baseStableRateOffset: EngineFlags.KEEP_CURRENT,
        stableRateExcessOffset: EngineFlags.KEEP_CURRENT,
        optimalStableToTotalDebtRatio: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}