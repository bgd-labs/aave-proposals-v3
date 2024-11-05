// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Ethereum_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV2PriceAdapters();
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](8);
    address[] memory sources = new address[](8);

    assets[0] = AaveV3EthereumAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.ETHEREUM_V3_USDC_FEED;

    assets[1] = AaveV3EthereumAssets.USDT_UNDERLYING;
    sources[1] = PriceFeeds.ETHEREUM_V3_USDT_FEED;

    assets[2] = AaveV3EthereumAssets.DAI_UNDERLYING;
    sources[2] = PriceFeeds.ETHEREUM_V3_DAI_FEED;

    assets[3] = AaveV3EthereumAssets.LUSD_UNDERLYING;
    sources[3] = PriceFeeds.ETHEREUM_V3_LUSD_FEED;

    assets[4] = AaveV3EthereumAssets.FRAX_UNDERLYING;
    sources[4] = PriceFeeds.ETHEREUM_V3_FRAX_FEED;

    assets[5] = AaveV3EthereumAssets.crvUSD_UNDERLYING;
    sources[5] = PriceFeeds.ETHEREUM_V3_CRVUSD_FEED;

    assets[6] = AaveV3EthereumAssets.PYUSD_UNDERLYING;
    sources[6] = PriceFeeds.ETHEREUM_V3_PYUSD_FEED;

    assets[7] = AaveV3EthereumAssets.sDAI_UNDERLYING;
    sources[7] = PriceFeeds.ETHEREUM_V3_SDAI_FEED;

    AaveV3Ethereum.ORACLE.setAssetSources(assets, sources);
  }

  function _updateV2PriceAdapters() internal {
    address[] memory assets = new address[](10);
    address[] memory sources = new address[](10);

    assets[0] = AaveV2EthereumAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.ETHEREUM_V2_USDC_FEED;

    assets[1] = AaveV2EthereumAssets.USDT_UNDERLYING;
    sources[1] = PriceFeeds.ETHEREUM_V2_USDT_FEED;

    assets[2] = AaveV2EthereumAssets.DAI_UNDERLYING;
    sources[2] = PriceFeeds.ETHEREUM_V2_DAI_FEED;

    assets[3] = AaveV2EthereumAssets.FRAX_UNDERLYING;
    sources[3] = PriceFeeds.ETHEREUM_V2_FRAX_FEED;

    assets[4] = AaveV2EthereumAssets.LUSD_UNDERLYING;
    sources[4] = PriceFeeds.ETHEREUM_V2_LUSD_FEED;

    assets[5] = AaveV2EthereumAssets.USDP_UNDERLYING;
    sources[5] = PriceFeeds.ETHEREUM_V2_USDP_FEED;

    assets[6] = AaveV2EthereumAssets.sUSD_UNDERLYING;
    sources[6] = PriceFeeds.ETHEREUM_V2_SUSD_FEED;

    assets[7] = AaveV2EthereumAssets.BUSD_UNDERLYING;
    sources[7] = PriceFeeds.ETHEREUM_V2_BUSD_FEED;

    assets[8] = AaveV2EthereumAssets.TUSD_UNDERLYING;
    sources[8] = PriceFeeds.ETHEREUM_V2_TUSD_FEED;

    assets[9] = AaveV2EthereumAssets.UST_UNDERLYING;
    sources[9] = PriceFeeds.ETHEREUM_V2_UST_FEED;

    AaveV2Ethereum.ORACLE.setAssetSources(assets, sources);
  }
}
