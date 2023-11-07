// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3OptimismAssets,AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {AaveV3PayloadOptimism} from 'aave-helpers/v3-config-engine/AaveV3PayloadOptimism.sol';

/**
 * @title Disable Stable Borrows
 * @author BGD (@bgdlabs)
 */
contract AaveV3Optimism_Disable_Stable_Borrows_20231104 is AaveV3PayloadOptimism {
  function _postExecute() internal override
  {
    AaveV3Optimism.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3OptimismAssets.DAI_UNDERLYING, false);
    AaveV3Optimism.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3OptimismAssets.USDC_UNDERLYING, false);
    AaveV3Optimism.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3OptimismAssets.USDT_UNDERLYING, false);


    AaveV3Optimism.POOL_CONFIGURATOR.setReserveFreeze(AaveV3OptimismAssets.DAI_UNDERLYING, false);
    AaveV3Optimism.POOL_CONFIGURATOR.setReserveFreeze(AaveV3OptimismAssets.USDC_UNDERLYING, false);
    AaveV3Optimism.POOL_CONFIGURATOR.setReserveFreeze(AaveV3OptimismAssets.USDT_UNDERLYING, false);
  }
}
