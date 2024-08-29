// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-periphery/contracts/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Stablecoin IR Curve Amendment
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-2024-08-15/18669
 */
contract AaveV3Arbitrum_StablecoinIRCurveAmendment_20240829 is AaveV3PayloadArbitrum {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](6);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ArbitrumAssets.DAI_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 5_50,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ArbitrumAssets.USDT_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 5_50,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[2] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ArbitrumAssets.EURS_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 5_50,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[3] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 5_50,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[4] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ArbitrumAssets.USDCn_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 5_50,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[5] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ArbitrumAssets.FRAX_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 5_50,
        variableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
