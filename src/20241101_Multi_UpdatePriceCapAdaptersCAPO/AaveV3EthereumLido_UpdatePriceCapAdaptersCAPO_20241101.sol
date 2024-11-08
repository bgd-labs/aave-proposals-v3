// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PayloadEthereumLido} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereumLido.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Discussion: TODO
 */
contract AaveV3EthereumLido_UpdatePriceCapAdaptersCAPO_20241101 is AaveV3PayloadEthereumLido {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory feedsUpdate = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    feedsUpdate[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumLidoAssets.USDC_UNDERLYING,
      priceFeed: PriceFeeds.ETHEREUM_V3_USDC_FEED
    });

    return feedsUpdate;
  }
}
