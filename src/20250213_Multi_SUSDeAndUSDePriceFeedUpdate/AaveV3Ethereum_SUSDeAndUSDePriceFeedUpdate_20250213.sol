// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3PayloadEthereum} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadEthereum.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title sUSDe and USDe Price Feed Update
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xd09ac8571db4d8e70b57162d526e2e088295f6372d37eb0f2b68c5dfbf16d316
 * - Discussion: https://governance.aave.com/t/arfc-susde-and-usde-price-feed-update/20495
 */
contract AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213 is AaveV3PayloadEthereum {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](2);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.USDe_UNDERLYING,
      priceFeed: 0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8
    });
    priceFeedUpdates[1] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3EthereumAssets.sUSDe_UNDERLYING,
      priceFeed: 0x42bc86f2f08419280a99d8fbEa4672e7c30a86ec
    });

    return priceFeedUpdates;
  }
}
