// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAssets, AaveV2Ethereum, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/v2-config-engine/IV2RateStrategyFactory.sol';

/**
 * @title Chaos Labs RF and IR Updates - Aave V2 Ethereum
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xbdd7c43d6e435c6c1ed08183f9e2e78f66a24436f45d48f04b85487a2f96e387
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-rf-and-ir-updates-aave-v2-ethereum-2023-11-24/15661
 */
contract AaveV2Ethereum_ChaosLabsRFAndIRUpdatesAaveV2Ethereum_20231203 is AaveV2PayloadEthereum {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](20);

    IV2RateStrategyFactory.RateStrategyParams memory newParams = IV2RateStrategyFactory
      .RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: _bpsToRay(0),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      });

    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.YFI_UNDERLYING,
      params: newParams
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.ZRX_UNDERLYING,
      params: newParams
    });
    rateStrategies[2] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.UNI_UNDERLYING,
      params: newParams
    });
    rateStrategies[3] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.BAT_UNDERLYING,
      params: newParams
    });
    rateStrategies[4] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.ENJ_UNDERLYING,
      params: newParams
    });
    rateStrategies[5] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.KNC_UNDERLYING,
      params: newParams
    });
    rateStrategies[6] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.MANA_UNDERLYING,
      params: newParams
    });
    rateStrategies[7] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.MKR_UNDERLYING,
      params: newParams
    });
    rateStrategies[8] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.REN_UNDERLYING,
      params: newParams
    });
    rateStrategies[9] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.SNX_UNDERLYING,
      params: newParams
    });
    rateStrategies[10] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.CRV_UNDERLYING,
      params: newParams
    });
    rateStrategies[11] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.BAL_UNDERLYING,
      params: newParams
    });
    rateStrategies[12] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      params: newParams
    });
    rateStrategies[13] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.RAI_UNDERLYING,
      params: newParams
    });
    rateStrategies[14] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.AMPL_UNDERLYING,
      params: newParams
    });
    rateStrategies[15] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.DPI_UNDERLYING,
      params: newParams
    });
    rateStrategies[16] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.ENS_UNDERLYING,
      params: newParams
    });
    rateStrategies[17] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.UST_UNDERLYING,
      params: newParams
    });
    rateStrategies[18] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.CVX_UNDERLYING,
      params: newParams
    });
    rateStrategies[19] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      params: newParams
    });

    return rateStrategies;
  }

  function _postExecute() internal override {
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.YFI_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.UNI_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.BAT_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.KNC_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.MANA_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.MKR_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.REN_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.SNX_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.CRV_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.BAL_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.RAI_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.AMPL_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ENS_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.UST_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.CVX_UNDERLYING,
      99_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING,
      99_00
    );
  }
}
