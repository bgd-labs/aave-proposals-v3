// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/v2-config-engine/IV2RateStrategyFactory.sol';
/**
 * @title Deprecation of Small-cap Stablecoins on V2 Ethereum
 * @author Chaos Labs
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xf6aaa50a6a76f44df9cfbbb760ca80878854dd16d88b16a3fc0f5fa6920741f0
 * - Discussion: https://governance.aave.com/t/arfc-deprecation-of-small-cap-stablecoins-on-v2-ethereum/17484/1
 */
contract AaveV2Ethereum_DeprecationOfSmallCapStablecoinsOnV2Ethereum_20240502 is
  AaveV2PayloadEthereum
{
  function _preExecute() internal override {
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.USDP_UNDERLYING,
      95_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.GUSD_UNDERLYING,
      95_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.LUSD_UNDERLYING,
      95_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      95_00
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.sUSD_UNDERLYING,
      95_00
    );

    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).disableBorrowingOnReserve(
      AaveV2EthereumAssets.USDP_UNDERLYING
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).disableBorrowingOnReserve(
      AaveV2EthereumAssets.GUSD_UNDERLYING
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).disableBorrowingOnReserve(
      AaveV2EthereumAssets.LUSD_UNDERLYING
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).disableBorrowingOnReserve(
      AaveV2EthereumAssets.FRAX_UNDERLYING
    );
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).disableBorrowingOnReserve(
      AaveV2EthereumAssets.sUSD_UNDERLYING
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
      asset: AaveV2EthereumAssets.sUSD_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(20_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(200_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.GUSD_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(20_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(200_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[2] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.USDP_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(20_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(200_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[3] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.FRAX_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(20_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(200_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[4] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.LUSD_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: _bpsToRay(20_00),
        baseVariableBorrowRate: _bpsToRay(3_00),
        variableRateSlope1: _bpsToRay(15_00),
        variableRateSlope2: _bpsToRay(200_00),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
