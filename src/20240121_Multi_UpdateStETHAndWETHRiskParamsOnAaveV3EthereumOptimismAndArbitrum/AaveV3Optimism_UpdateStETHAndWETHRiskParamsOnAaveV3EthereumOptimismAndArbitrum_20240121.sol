// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3OptimismAssets, AaveV3OptimismEModes} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';

/**
 * @title Update ETH LSTs and WETH Risk Params on Aave v3 Ethereum, Optimism and Arbitrum
 * @author Aave Chan Initiative
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb8790aeb32267062c1500deb613ad15ebd5deac4d78d1786cb1690c12d0512c9
 * - Discussion: https://governance.aave.com/t/arfc-update-steth-and-weth-risk-params-on-aave-v3-ethereum-optimism-and-arbitrum/16168
 */
contract AaveV3Optimism_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121 is
  AaveV3PayloadOptimism
{
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3OptimismAssets.WETH_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: _bpsToRay(90_00),
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
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

  function eModeCategoriesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.EModeCategoryUpdate[] memory)
  {
    IAaveV3ConfigEngine.EModeCategoryUpdate[]
      memory eModeUpdates = new IAaveV3ConfigEngine.EModeCategoryUpdate[](1);

    eModeUpdates[0] = IAaveV3ConfigEngine.EModeCategoryUpdate({
      eModeCategory: AaveV3OptimismEModes.ETH_CORRELATED,
      ltv: 93_00,
      liqThreshold: 95_00,
      liqBonus: EngineFlags.KEEP_CURRENT,
      priceSource: EngineFlags.KEEP_CURRENT_ADDRESS,
      label: EngineFlags.KEEP_CURRENT_STRING
    });

    return eModeUpdates;
  }
}
