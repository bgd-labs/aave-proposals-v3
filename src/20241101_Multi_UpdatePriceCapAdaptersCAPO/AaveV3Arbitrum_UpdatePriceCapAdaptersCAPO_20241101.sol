// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadArbitrum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadArbitrum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3Arbitrum_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadArbitrum {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](7);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.USDCn_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_USDC_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.USDT_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_USDT_FEED
    });
    feedsUpdate[3] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.DAI_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_DAI_FEED
    });
    feedsUpdate[4] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.MAI_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_MAI_FEED
    });
    feedsUpdate[5] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_LUSD_FEED
    });
    feedsUpdate[6] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ArbitrumAssets.FRAX_UNDERLYING,
      priceFeed: PriceFeeds.ARBITRUM_V3_FRAX_FEED
    });

    return feedsUpdate;
  }
}
