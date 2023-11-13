// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3PayloadArbitrum} from 'aave-helpers/v3-config-engine/AaveV3PayloadArbitrum.sol';

/**
 * @title Disable Stable Borrows
 * @author BGD (@bgdlabs)
 */
contract AaveV3Arbitrum_Disable_Stable_Borrows_20231104 is AaveV3PayloadArbitrum {
  function _postExecute() internal override
  {

    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3ArbitrumAssets.DAI_UNDERLYING, false);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3ArbitrumAssets.USDC_UNDERLYING, false);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3ArbitrumAssets.USDT_UNDERLYING, false);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveStableRateBorrowing(AaveV3ArbitrumAssets.EURS_UNDERLYING, false);

    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ArbitrumAssets.DAI_UNDERLYING, false);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ArbitrumAssets.USDC_UNDERLYING, false);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ArbitrumAssets.USDT_UNDERLYING, false);
    AaveV3Arbitrum.POOL_CONFIGURATOR.setReserveFreeze(AaveV3ArbitrumAssets.EURS_UNDERLYING, false);
  }
}
