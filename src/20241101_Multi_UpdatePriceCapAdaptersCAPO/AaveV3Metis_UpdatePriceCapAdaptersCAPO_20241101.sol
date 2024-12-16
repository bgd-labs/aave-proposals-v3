// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadMetis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadMetis.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadMetis {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](3);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3MetisAssets.mUSDC_UNDERLYING,
      priceFeed: PriceFeeds.METIS_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3MetisAssets.mUSDT_UNDERLYING,
      priceFeed: PriceFeeds.METIS_V3_USDT_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3MetisAssets.mDAI_UNDERLYING,
      priceFeed: PriceFeeds.METIS_V3_DAI_FEED
    });

    return feedsUpdate;
  }
}
