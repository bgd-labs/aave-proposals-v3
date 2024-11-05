// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](7);
    address[] memory sources = new address[](7);

    assets[0] = AaveV3ArbitrumAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.ARBITRUM_V3_USDC_FEED;

    assets[1] = AaveV3ArbitrumAssets.USDCn_UNDERLYING;
    sources[1] = PriceFeeds.ARBITRUM_V3_USDC_FEED;

    assets[2] = AaveV3ArbitrumAssets.USDT_UNDERLYING;
    sources[2] = PriceFeeds.ARBITRUM_V3_USDT_FEED;

    assets[3] = AaveV3ArbitrumAssets.DAI_UNDERLYING;
    sources[3] = PriceFeeds.ARBITRUM_V3_DAI_FEED;

    assets[4] = AaveV3ArbitrumAssets.MAI_UNDERLYING;
    sources[4] = PriceFeeds.ARBITRUM_V3_MAI_FEED;

    assets[5] = AaveV3ArbitrumAssets.LUSD_UNDERLYING;
    sources[5] = PriceFeeds.ARBITRUM_V3_LUSD_FEED;

    assets[6] = AaveV3ArbitrumAssets.FRAX_UNDERLYING;
    sources[6] = PriceFeeds.ARBITRUM_V3_FRAX_FEED;

    AaveV3Arbitrum.ORACLE.setAssetSources(assets, sources);
  }
}
