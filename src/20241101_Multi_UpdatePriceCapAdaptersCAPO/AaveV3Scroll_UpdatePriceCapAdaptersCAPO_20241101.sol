// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Scroll_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](1);
    address[] memory sources = new address[](1);

    assets[0] = AaveV3ScrollAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.SCROLL_V3_USDC_FEED;

    AaveV3Scroll.ORACLE.setAssetSources(assets, sources);
  }
}
