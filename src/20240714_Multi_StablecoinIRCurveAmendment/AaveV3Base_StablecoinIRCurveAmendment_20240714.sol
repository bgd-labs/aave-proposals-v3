// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {AaveV3PayloadBase} from 'aave-helpers/v3-config-engine/AaveV3PayloadBase.sol';
import {EngineFlags} from 'aave-helpers/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-helpers/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IV3RateStrategyFactory} from 'aave-helpers/v3-config-engine/IV3RateStrategyFactory.sol';
/**
 * @title Stablecoin IR Curve Amendment
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-07-14-24/18252
 */
contract AaveV3Base_StablecoinIRCurveAmendment_20240714 is AaveV3PayloadBase {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3BaseAssets.USDC_UNDERLYING,
      params: IV3RateStrategyFactory.RateStrategyParams({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: _bpsToRay(6_50),
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
}
