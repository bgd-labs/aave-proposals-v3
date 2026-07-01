// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayerAssets} from 'aave-address-book/AaveV3XLayer.sol';
import {AaveV3PayloadXLayer} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadXLayer.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title UpdateUSDGPriceFeed
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/132
 */
contract AaveV3XLayer_UpdateUSDGPriceFeed_20260514 is AaveV3PayloadXLayer {
  address internal constant USDG_PRICE_FEED = 0xe00B2732396a1f047d4A00e0165025A9cF400245;

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3XLayerAssets.USDG_UNDERLYING,
      priceFeed: USDG_PRICE_FEED
    });

    return priceFeedUpdates;
  }
}
