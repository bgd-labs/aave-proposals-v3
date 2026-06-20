// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';

/**
 * @title Update USDG price feed on Aave V3 Ethereum
 * @author Aave Labs
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Ethereum_UpdateUSDGPriceFeed_20260514 is AaveV3PayloadEthereum {
  // https://etherscan.io/address/0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4
  address internal constant USDG_PRICE_FEED = 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4;

  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory updates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);
    updates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.USDG_UNDERLYING,
      priceFeed: USDG_PRICE_FEED
    });
    return updates;
  }
}
