// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSyncAssets} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {EngineFlags} from 'aave-v3-origin/contracts/extensions/v3-config-engine/EngineFlags.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title Increase Borrow Slope1 to all Stablecoins across all Aave Instances
 * @author Aave Chan Initiative
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-increase-borrow-slope1-to-all-stablecoins-across-all-aave-instances/19979
 */
contract AaveV3ZkSync_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201 is
  AaveV3PayloadZkSync
{
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](2);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ZkSyncAssets.USDC_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 12_50,
        variableRateSlope2: 40_00
      })
    });
    rateStrategies[1] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ZkSyncAssets.USDT_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: EngineFlags.KEEP_CURRENT,
        baseVariableBorrowRate: EngineFlags.KEEP_CURRENT,
        variableRateSlope1: 12_50,
        variableRateSlope2: 40_00
      })
    });

    return rateStrategies;
  }
}
