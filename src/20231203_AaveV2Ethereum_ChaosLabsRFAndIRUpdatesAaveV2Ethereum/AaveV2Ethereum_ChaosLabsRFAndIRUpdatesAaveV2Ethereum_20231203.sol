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

    address[20] memory assets = [
      AaveV2EthereumAssets.YFI_UNDERLYING,
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      AaveV2EthereumAssets.UNI_UNDERLYING,
      AaveV2EthereumAssets.BAT_UNDERLYING,
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      AaveV2EthereumAssets.KNC_UNDERLYING,
      AaveV2EthereumAssets.MANA_UNDERLYING,
      AaveV2EthereumAssets.MKR_UNDERLYING,
      AaveV2EthereumAssets.REN_UNDERLYING,
      AaveV2EthereumAssets.SNX_UNDERLYING,
      AaveV2EthereumAssets.CRV_UNDERLYING,
      AaveV2EthereumAssets.BAL_UNDERLYING,
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      AaveV2EthereumAssets.RAI_UNDERLYING,
      AaveV2EthereumAssets.AMPL_UNDERLYING,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV2EthereumAssets.ENS_UNDERLYING,
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.CVX_UNDERLYING,
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING
    ];

    IV2RateStrategyFactory.RateStrategyParams memory newParams = IV2RateStrategyFactory
      .RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: _bpsToRay(0),
        variableRateSlope2: _bpsToRay(300_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      });

    for (uint256 i = 0; i < assets.length; i++) {
      rateStrategies[i] = IAaveV2ConfigEngine.RateStrategyUpdate({
        asset: assets[i],
        params: newParams
      });
    }

    return rateStrategies;
  }

  function _postExecute() internal override {
    address[20] memory assets = [
      AaveV2EthereumAssets.YFI_UNDERLYING,
      AaveV2EthereumAssets.ZRX_UNDERLYING,
      AaveV2EthereumAssets.UNI_UNDERLYING,
      AaveV2EthereumAssets.BAT_UNDERLYING,
      AaveV2EthereumAssets.ENJ_UNDERLYING,
      AaveV2EthereumAssets.KNC_UNDERLYING,
      AaveV2EthereumAssets.MANA_UNDERLYING,
      AaveV2EthereumAssets.MKR_UNDERLYING,
      AaveV2EthereumAssets.REN_UNDERLYING,
      AaveV2EthereumAssets.SNX_UNDERLYING,
      AaveV2EthereumAssets.CRV_UNDERLYING,
      AaveV2EthereumAssets.BAL_UNDERLYING,
      AaveV2EthereumAssets.xSUSHI_UNDERLYING,
      AaveV2EthereumAssets.RAI_UNDERLYING,
      AaveV2EthereumAssets.AMPL_UNDERLYING,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV2EthereumAssets.ENS_UNDERLYING,
      AaveV2EthereumAssets.UST_UNDERLYING,
      AaveV2EthereumAssets.CVX_UNDERLYING,
      AaveV2EthereumAssets.ONE_INCH_UNDERLYING
    ];

    for (uint256 i = 0; i < assets.length; i++) {
      ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(assets[i], 99_00);
    }
  }
}
