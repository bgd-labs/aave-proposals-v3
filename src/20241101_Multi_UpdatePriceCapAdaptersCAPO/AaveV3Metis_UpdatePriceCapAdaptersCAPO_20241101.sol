// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Metis, AaveV3MetisAssets} from 'aave-address-book/AaveV3Metis.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Metis_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](3);
    address[] memory sources = new address[](3);

    assets[0] = AaveV3MetisAssets.mUSDC_UNDERLYING;
    sources[0] = PriceFeeds.METIS_V3_USDC_FEED;

    assets[1] = AaveV3MetisAssets.mUSDT_UNDERLYING;
    sources[1] = PriceFeeds.METIS_V3_USDT_FEED;

    assets[2] = AaveV3MetisAssets.mDAI_UNDERLYING;
    sources[2] = PriceFeeds.METIS_V3_DAI_FEED;

    AaveV3Metis.ORACLE.setAssetSources(assets, sources);
  }
}
