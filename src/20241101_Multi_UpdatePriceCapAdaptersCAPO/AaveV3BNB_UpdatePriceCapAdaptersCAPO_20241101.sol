// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3BNB_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](3);
    address[] memory sources = new address[](3);

    assets[0] = AaveV3BNBAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.BNB_V3_USDC_FEED;

    assets[1] = AaveV3BNBAssets.USDT_UNDERLYING;
    sources[1] = PriceFeeds.BNB_V3_USDT_FEED;

    assets[2] = AaveV3BNBAssets.FDUSD_UNDERLYING;
    sources[2] = PriceFeeds.BNB_V3_FDUSD_FEED;

    AaveV3BNB.ORACLE.setAssetSources(assets, sources);
  }
}
