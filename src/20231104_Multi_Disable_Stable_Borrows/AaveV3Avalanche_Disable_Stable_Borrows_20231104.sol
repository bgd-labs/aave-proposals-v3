// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3AvalancheAssets,AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV3PayloadAvalanche} from 'aave-helpers/v3-config-engine/AaveV3PayloadAvalanche.sol';

/**
 * @title Disable Stable Borrows
 * @author BGD (@bgdlabs)
 */
contract AaveV3Avalanche_Disable_Stable_Borrows_20231104 is AaveV3PayloadAvalanche {
  function _postExecute() internal override
  {
    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3AvalancheAssets.DAIe_UNDERLYING, false);
    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3AvalancheAssets.USDC_UNDERLYING, false);
    AaveV3Avalanche.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3AvalancheAssets.USDt_UNDERLYING, false);
  }
}
