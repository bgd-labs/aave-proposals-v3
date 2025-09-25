// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV2PayloadAvalanche} from 'aave-helpers/src/v2-config-engine/AaveV2PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';
import {ILendingPoolConfigurator} from 'aave-address-book/AaveV2.sol';
import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

/**
 * @title Aave v2 Deprecation - Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486
 * - Discussion: https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2
 */
contract AaveV2Avalanche_AaveV2DeprecationUpdate_20250925 is AaveV2PayloadAvalanche {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](6);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.WETHe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.DAIe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(80_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[2] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.USDTe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(45_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[3] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.USDCe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(0),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[4] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.WBTCe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: _bpsToRay(0),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[5] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.WAVAX_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }

  function _postExecute() internal override {
    ILendingPoolConfigurator poolConfigurator = ILendingPoolConfigurator(
      AaveV2Avalanche.POOL_CONFIGURATOR
    );

    // wETH: 80% -> 85%
    poolConfigurator.setReserveFactor(AaveV2AvalancheAssets.WETHe_UNDERLYING, 85_00);
    // USDC.e: 80% -> 85%
    poolConfigurator.setReserveFactor(AaveV2AvalancheAssets.USDCe_UNDERLYING, 85_00);
    // AVAX: 80% -> 85%
    poolConfigurator.setReserveFactor(AaveV2AvalancheAssets.WAVAX_UNDERLYING, 85_00);
    // USDT.e: 80% -> 85%
    poolConfigurator.setReserveFactor(AaveV2AvalancheAssets.USDTe_UNDERLYING, 85_00);
    // DAI: 80% -> 85%
    poolConfigurator.setReserveFactor(AaveV2AvalancheAssets.DAIe_UNDERLYING, 85_00);
  }
}
