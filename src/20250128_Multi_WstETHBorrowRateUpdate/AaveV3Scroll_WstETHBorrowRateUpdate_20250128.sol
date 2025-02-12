// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {AaveV3PayloadScroll} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadScroll.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title wstETH Borrow Rate Update
 * @author TokenLogic
 * - Snapshot: https://snapshot.org/#/s:aave.eth/proposal/0xcb271a2308f78eeab5cbf5576938b61e7437c99781320c1340c885a656c9dbdc
 * - Discussion: https://governance.aave.com/t/arfc-wsteth-borrow-rate-update/20762
 */
contract AaveV3Scroll_WstETHBorrowRateUpdate_20250128 is AaveV3PayloadScroll {
  function rateStrategiesUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.RateStrategyUpdate[] memory)
  {
    IAaveV3ConfigEngine.RateStrategyUpdate[]
      memory rateStrategies = new IAaveV3ConfigEngine.RateStrategyUpdate[](1);
    rateStrategies[0] = IAaveV3ConfigEngine.RateStrategyUpdate({
      asset: AaveV3ScrollAssets.wstETH_UNDERLYING,
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
