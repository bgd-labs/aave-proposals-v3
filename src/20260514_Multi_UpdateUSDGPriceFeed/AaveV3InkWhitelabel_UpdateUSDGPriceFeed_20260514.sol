// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabelAssets} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {AaveV3PayloadInkWhitelabel} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadInkWhitelabel.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title UpdateUSDGPriceFeed
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/132
 */
contract AaveV3InkWhitelabel_UpdateUSDGPriceFeed_20260514 is AaveV3PayloadInkWhitelabel {
  address internal constant USDG_PRICE_FEED = 0x32b1f1A1D3423dE69cf1f75092eCfDc5090d6624;

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3InkWhitelabelAssets.USDG_UNDERLYING,
      priceFeed: USDG_PRICE_FEED
    });

    return priceFeedUpdates;
  }
}
