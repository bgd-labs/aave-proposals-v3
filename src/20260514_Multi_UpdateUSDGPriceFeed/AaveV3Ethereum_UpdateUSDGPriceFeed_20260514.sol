// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

/**
 * @title UpdateUSDGPriceFeed
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/technical-maintenance-proposals/15274/132
 */
contract AaveV3Ethereum_UpdateUSDGPriceFeed_20260514 is AaveV3PayloadEthereum {
  address internal constant USDG_PRICE_FEED = 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4;

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](2);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.USDG_UNDERLYING,
      priceFeed: USDG_PRICE_FEED
    });

    // PT-USDG-28MAY2026 has matured and redeems 1:1 to USDG, so it prices directly off the USDG feed.
    priceFeedUpdates[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.PT_USDG_28MAY2026_UNDERLYING,
      priceFeed: USDG_PRICE_FEED
    });

    return priceFeedUpdates;
  }
}
