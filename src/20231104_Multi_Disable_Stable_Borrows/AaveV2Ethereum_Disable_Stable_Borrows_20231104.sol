// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IEngine, EngineFlags, AaveV2PayloadEthereum} from 'aave-helpers/v2-config-engine/AaveV2PayloadEthereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';

/**
 * @title Disable Stable Borrows
 * @author BGD (@bgdlabs)
 */
contract AaveV2Ethereum_Disable_Stable_Borrows_20231104 is AaveV2PayloadEthereum {
  function _postExecute() internal override {
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.USDT_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.WBTC_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.WETH_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.ZRX_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.BAT_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.ENJ_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.KNC_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.LINK_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.MANA_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.MKR_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.REN_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.USDC_UNDERLYING);
    AaveV2Ethereum.POOL_CONFIGURATOR.disableReserveStableRate(AaveV2EthereumAssets.LUSD_UNDERLYING);
  }
}
