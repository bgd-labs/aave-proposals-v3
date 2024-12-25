// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadBNB} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadBNB.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadBNB {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](3);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3BNBAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.BNB_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3BNBAssets.USDT_UNDERLYING,
      priceFeed: PriceFeeds.BNB_V3_USDT_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3BNBAssets.FDUSD_UNDERLYING,
      priceFeed: PriceFeeds.BNB_V3_FDUSD_FEED
    });

    return feedsUpdate;
  }
}
