// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSyncAssets} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title wstETH Borrow Rate Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0xcb271a2308f78eeab5cbf5576938b61e7437c99781320c1340c885a656c9dbdc
 * - Discussion: https://governance.aave.com/t/arfc-wsteth-borrow-rate-update/20762
 */
contract AaveV3ZkSync_WstETHBorrowRateUpdate_20250128 is AaveV3PayloadZkSync {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ZkSyncAssets.wstETH_UNDERLYING,
      params: IAaveV3ConfigEngine.InterestRateInputData({
        optimalUsageRatio: 90_00,
        baseVariableBorrowRate: 0,
        variableRateSlope1: 75,
        variableRateSlope2: 85_00
      })
    });

    return rateStrategies;
  }
}
