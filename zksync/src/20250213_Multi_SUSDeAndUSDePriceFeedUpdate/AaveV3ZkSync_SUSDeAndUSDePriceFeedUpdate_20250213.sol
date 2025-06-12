// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSyncAssets} from 'aave-address-book/AaveV3ZkSync.sol';
import {AaveV3PayloadZkSync} from 'aave-helpers/src/v3-config-engine/AaveV3PayloadZkSync.sol';
import {IAaveV3ConfigEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
/**
 * @title sUSDe and USDe Price Feed Update
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xd09ac8571db4d8e70b57162d526e2e088295f6372d37eb0f2b68c5dfbf16d316
 * - Discussion: https://governance.aave.com/t/arfc-susde-and-usde-price-feed-update/20495
 */
contract AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213 is AaveV3PayloadZkSync {
  function priceFeedsUpdates()
    public
    pure
    override
    returns (IAaveV3ConfigEngine.PriceFeedUpdate[] memory)
  {
    IAaveV3ConfigEngine.PriceFeedUpdate[]
      memory priceFeedUpdates = new IAaveV3ConfigEngine.PriceFeedUpdate[](1);

    priceFeedUpdates[0] = IAaveV3ConfigEngine.PriceFeedUpdate({
      asset: AaveV3ZkSyncAssets.sUSDe_UNDERLYING,
      priceFeed: 0x9172A80ed668D3097D45350ffF71F4421ff572e1
    });

    return priceFeedUpdates;
  }
}
