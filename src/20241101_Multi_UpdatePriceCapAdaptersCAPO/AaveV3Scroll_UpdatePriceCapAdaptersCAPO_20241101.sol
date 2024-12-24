// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadScroll} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadScroll.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadScroll {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ScrollAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.SCROLL_V3_USDC_FEED
    });

    return feedsUpdate;
  }
}
