// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/src/v2-config-engine/AaveV2PayloadEthereum.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';
import {ILendingPoolConfigurator, IAaveProtocolDataProvider} from 'aave-address-book/AaveV2.sol';
import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Aave v2 Deprecation - Update
 * @author @TokenLogic
 * - Snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x0c5427caf17d21b321a3b62362d085e580446b136b0eccf7f4dc377856025486
 * - Discussion: https://governance.aave.com/t/arfc-aave-v2-deprecation-update/23008/2
 */
contract AaveV2Ethereum_AaveV2DeprecationUpdate_20250925 is AaveV2PayloadEthereum {
  address public constant WBTC_IMPL = 0x5c7b3F858F8fBb4d1Fc525d51f82Cb5715c68c27;

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](5);

    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.WETH_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(5_00),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.WBTC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(25_00),
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[2] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.USDC_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(60_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(12_50),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[3] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.USDT_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(40_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(12_50),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[4] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.DAI_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(50_00),
        baseVariableBorrowRate: _bpsToRay(5_00),
        variableRateSlope1: _bpsToRay(12_50),
        variableRateSlope2: _bpsToRay(40_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }

  function _postExecute() internal override {
    address[5] memory assets = [
      AaveV2EthereumAssets.WETH_UNDERLYING,
      AaveV2EthereumAssets.WBTC_UNDERLYING,
      AaveV2EthereumAssets.USDC_UNDERLYING,
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV2EthereumAssets.DAI_UNDERLYING
    ];

    for (uint256 i = 0; i < assets.length; i++) {
      (, , , , , , , , , bool isFrozen) = IAaveProtocolDataProvider(
        AaveV2Ethereum.AAVE_PROTOCOL_DATA_PROVIDER
      ).getReserveConfigurationData(assets[i]);
      if (!isFrozen) {
        ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).freezeReserve(assets[i]);
      }
    }
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      85_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      85_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      85_00
    );

    // Upgrade WBTC impl
    AaveV2Ethereum.POOL_CONFIGURATOR.updateAToken(AaveV2EthereumAssets.WBTC_UNDERLYING, WBTC_IMPL);
  }
}
