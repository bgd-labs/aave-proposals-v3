// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadOptimism} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadOptimism.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadOptimism {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](7);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.USDCn_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_USDC_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.USDT_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_USDT_FEED
    });
    feedsUpdate[3] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.DAI_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_DAI_FEED
    });
    feedsUpdate[4] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.MAI_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_MAI_FEED
    });
    feedsUpdate[5] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.LUSD_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_LUSD_FEED
    });
    feedsUpdate[6] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3OptimismAssets.sUSD_UNDERLYING,
      priceFeed: PriceFeeds.OPTIMISM_V3_SUSD_FEED
    });

    return feedsUpdate;
  }
}
