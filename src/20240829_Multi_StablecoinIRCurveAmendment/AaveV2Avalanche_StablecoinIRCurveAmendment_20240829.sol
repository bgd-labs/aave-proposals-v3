// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {AaveV2PayloadAvalanche} from 'aave-helpers/src/v2-config-engine/AaveV2PayloadAvalanche.sol';
import {EngineFlags} from 'aave-v3-periphery/contracts/v3-config-engine/EngineFlags.sol';
import {IAaveV2ConfigEngine} from 'aave-helpers/src/v2-config-engine/IAaveV2ConfigEngine.sol';
import {IV2RateStrategyFactory} from 'aave-helpers/src/v2-config-engine/IV2RateStrategyFactory.sol';
/**
 * @title Stablecoin IR Curve Amendment
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-2024-08-15/18669
 */
contract AaveV2Avalanche_StablecoinIRCurveAmendment_20240829 is AaveV2PayloadAvalanche {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV2ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV2ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV2ConfigEngine.RateStrategyUpdate[](2);
    rateStrategies[0] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.DAIe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(5_50),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });
    rateStrategies[1] = IAaveV2ConfigEngine.RateStrategyUpdate({
      asset: AaveV2AvalancheAssets.USDTe_UNDERLYING,
      params: IV2RateStrategyFactory.RateStrategyParams({
        optimalUtilizationRate: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(5_50),
        variableRateSlope2: EngineFlags.KEEP_CURRENT,
        stableRateSlope1: EngineFlags.KEEP_CURRENT,
        stableRateSlope2: EngineFlags.KEEP_CURRENT
      })
    });

    return rateStrategies;
  }
}
