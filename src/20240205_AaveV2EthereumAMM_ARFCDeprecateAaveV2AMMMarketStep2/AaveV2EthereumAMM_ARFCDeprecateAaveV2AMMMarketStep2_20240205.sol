// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAMM, AaveV2EthereumAMMAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2EthereumAMM.sol';
import {AaveV2PayloadEthereumAMM} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereumAMM.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/v2-config-engine/IV2RateStrategyFactory.sol';

/**
 * @title [ARFC] Deprecate Aave V2 AMM Market - Step 2
 * @author Gauntlet
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0x0ade316f52d5f763160ea15538a71a4682ae1b708864e8d33497d8de40ad9973
 * - Discussion: https://governance.aave.com/t/arfc-deprecate-aave-v2-amm-market-step-2/16408/1
 */
contract AaveV2EthereumAMM_ARFCDeprecateAaveV2AMMMarketStep2_20240205 is AaveV2PayloadEthereumAMM {
  function _postExecute() internal override {
    ILendingPoolConfigurator(AaveV2EthereumAMM.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAMMAssets.WETH_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2EthereumAMM.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAMMAssets.DAI_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2EthereumAMM.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAMMAssets.USDC_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2EthereumAMM.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAMMAssets.WBTC_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2EthereumAMM.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAMMAssets.USDT_UNDERLYING,
      99_00
    );
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](5);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAMMAssets.WETH_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(6_00),
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAMMAssets.DAI_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(4_00),
        variableRateSlope1: _bpsToRay(10_00),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[2] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAMMAssets.USDC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(4_00),
        variableRateSlope1: _bpsToRay(10_00),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[3] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAMMAssets.USDT_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(6_00),
        variableRateSlope1: _bpsToRay(10_00),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[4] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAMMAssets.WBTC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
