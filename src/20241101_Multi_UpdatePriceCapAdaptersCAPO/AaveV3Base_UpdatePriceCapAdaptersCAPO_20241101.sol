// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Base_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](2);
    address[] memory sources = new address[](2);

    assets[0] = AaveV3BaseAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.BASE_V3_USDC_FEED;

    assets[1] = AaveV3BaseAssets.USDbC_UNDERLYING;
    sources[1] = PriceFeeds.BASE_V3_USDC_FEED;

    AaveV3Base.ORACLE.setAssetSources(assets, sources);
  }
}
