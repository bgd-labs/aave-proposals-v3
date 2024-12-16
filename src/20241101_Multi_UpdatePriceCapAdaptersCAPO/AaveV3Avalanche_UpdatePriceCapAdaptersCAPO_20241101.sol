// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadAvalanche} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadAvalanche.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadAvalanche {
  function _postExecute() internal override {
    _updateV2PriceAdapters();
  }

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](5);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3AvalancheAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.AVALANCHE_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3AvalancheAssets.USDt_UNDERLYING,
      priceFeed: PriceFeeds.AVALANCHE_V3_USDT_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3AvalancheAssets.DAIe_UNDERLYING,
      priceFeed: PriceFeeds.AVALANCHE_V3_DAI_FEED
    });
    feedsUpdate[3] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3AvalancheAssets.FRAX_UNDERLYING,
      priceFeed: PriceFeeds.AVALANCHE_V3_FRAX_FEED
    });
    feedsUpdate[4] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3AvalancheAssets.MAI_UNDERLYING,
      priceFeed: PriceFeeds.AVALANCHE_V3_MAI_FEED
    });

    return feedsUpdate;
  }

  function _updateV2PriceAdapters() internal {
    address[] memory assets = new address[](3);
    address[] memory sources = new address[](3);

    assets[0] = AaveV2AvalancheAssets.USDCe_UNDERLYING;
    sources[0] = PriceFeeds.AVALANCHE_V3_USDC_FEED;

    assets[1] = AaveV2AvalancheAssets.USDTe_UNDERLYING;
    sources[1] = PriceFeeds.AVALANCHE_V3_USDT_FEED;

    assets[2] = AaveV2AvalancheAssets.DAIe_UNDERLYING;
    sources[2] = PriceFeeds.AVALANCHE_V3_DAI_FEED;

    AaveV2Avalanche.ORACLE.setAssetSources(assets, sources);
  }
}
