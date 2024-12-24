// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadGnosis} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadGnosis.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadGnosis {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](4);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3GnosisAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.GNOSIS_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3GnosisAssets.USDCe_UNDERLYING,
      priceFeed: PriceFeeds.GNOSIS_V3_USDC_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3GnosisAssets.WXDAI_UNDERLYING,
      priceFeed: PriceFeeds.GNOSIS_V3_WXDAI_FEED
    });
    feedsUpdate[3] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3GnosisAssets.sDAI_UNDERLYING,
      priceFeed: PriceFeeds.GNOSIS_V3_SDAI_FEED
    });

    return feedsUpdate;
  }
}
