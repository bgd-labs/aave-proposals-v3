// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV2PayloadAvalanche} from 'aave-helpers/src/v2-config-engine/AaveV2PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';
/**
 * @title Aave V2 Deprecation Update
 * @author Aave-Chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xe1f53fe1748e6b31068eca832a07e5be5765ca3bf4ec1c900a13d78f29ed1d51
 * - Discussion: https://governance.aave.com/t/arfc-aave-v2-deprecation-update-disable-new-borrows-ir-curve-and-reserve-factor-adjustments/20918
 */
contract AaveV2Avalanche_AaveV2DeprecationUpdate_20250220 is AaveV2PayloadAvalanche {
  function _postExecute() internal override {
    AaveV2Avalanche.POOL_CONFIGURATOR.setReserveFactor(
      AaveV2AvalancheAssets.WBTCe_UNDERLYING,
      99_99
    );
    AaveV2Avalanche.POOL_CONFIGURATOR.disableBorrowingOnReserve(
      AaveV2AvalancheAssets.WAVAX_UNDERLYING
    );
    AaveV2Avalanche.POOL_CONFIGURATOR.disableBorrowingOnReserve(
      AaveV2AvalancheAssets.DAIe_UNDERLYING
    );
    AaveV2Avalanche.POOL_CONFIGURATOR.disableBorrowingOnReserve(
      AaveV2AvalancheAssets.USDTe_UNDERLYING
    );
    AaveV2Avalanche.POOL_CONFIGURATOR.disableBorrowingOnReserve(
      AaveV2AvalancheAssets.WETHe_UNDERLYING
    );
    AaveV2Avalanche.POOL_CONFIGURATOR.disableBorrowingOnReserve(
      AaveV2AvalancheAssets.WBTCe_UNDERLYING
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
      asset: AaveV2AvalancheAssets.WBTCe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: _bpsToRay(20_00),
        variableRateSlope1: 0,
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
