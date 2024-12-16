// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereumEtherFi} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumEtherFi.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3EthereumEtherFiAssets} from 'aave-address-book/AaveV3EthereumEtherFi.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/55
 */
contract AaveV3EthereumEtherFi_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadEthereumEtherFi {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](3);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumEtherFiAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_USDC_FEED
    });
    feedsUpdate[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumEtherFiAssets.PYUSD_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_PYUSD_FEED
    });
    feedsUpdate[2] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumEtherFiAssets.FRAX_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_FRAX_FEED
    });

    return feedsUpdate;
  }
}
