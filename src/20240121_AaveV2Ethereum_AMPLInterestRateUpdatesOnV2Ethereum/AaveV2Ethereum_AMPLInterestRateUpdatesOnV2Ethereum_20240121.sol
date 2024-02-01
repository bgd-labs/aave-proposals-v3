// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/v2-config-engine/IV2RateStrategyFactory.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title AMPL Interest Rate Updates on V2 Ethereum
 * @author Chaos Labs - Eyal Ovadya
 * - Snapshot: https://snapshot.org/\#/aave.eth/proposal/0xc5373ecc51b9ce6a568f2bb99181cf34efb3f317a4bd340719bc10c864fd1332
 * - Discussion: https://governance.aave.com/t/arfc-ampl-interest-rate-updates-on-v2-ethereum/16189
 */
contract AaveV2Ethereum_AMPLInterestRateUpdatesOnV2Ethereum_20240121 is AaveV2PayloadEthereum {
  function _preExecute() internal override {
    ILendingPoolConfigurator(AaveV2Ethereum.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2EthereumAssets.AMPL_UNDERLYING,
      99_90
    );
  }

  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2EthereumAssets.AMPL_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: EngineFlags.KEEP_CURRENT,
        variableRateSlope2: _bpsToRay(0),
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
