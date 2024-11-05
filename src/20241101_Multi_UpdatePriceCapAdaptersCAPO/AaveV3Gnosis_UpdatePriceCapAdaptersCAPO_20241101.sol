// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Gnosis_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](4);
    address[] memory sources = new address[](4);

    assets[0] = AaveV3GnosisAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.GNOSIS_V3_USDC_FEED;

    assets[1] = AaveV3GnosisAssets.USDCe_UNDERLYING;
    sources[1] = PriceFeeds.GNOSIS_V3_USDC_FEED;

    assets[2] = AaveV3GnosisAssets.WXDAI_UNDERLYING;
    sources[2] = PriceFeeds.GNOSIS_V3_WXDAI_FEED;

    assets[3] = AaveV3GnosisAssets.sDAI_UNDERLYING;
    sources[3] = PriceFeeds.GNOSIS_V3_SDAI_FEED;

    AaveV3Gnosis.ORACLE.setAssetSources(assets, sources);
  }
}
