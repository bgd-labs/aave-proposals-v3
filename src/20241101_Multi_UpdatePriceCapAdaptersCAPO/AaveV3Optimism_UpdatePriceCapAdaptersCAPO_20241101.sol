// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';
import {PriceFeeds} from './Constants.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](7);
    address[] memory sources = new address[](7);

    assets[0] = AaveV3OptimismAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.OPTIMISM_V3_USDC_FEED;

    assets[1] = AaveV3OptimismAssets.USDCn_UNDERLYING;
    sources[1] = PriceFeeds.OPTIMISM_V3_USDC_FEED;

    assets[2] = AaveV3OptimismAssets.USDT_UNDERLYING;
    sources[2] = PriceFeeds.OPTIMISM_V3_USDT_FEED;

    assets[3] = AaveV3OptimismAssets.DAI_UNDERLYING;
    sources[3] = PriceFeeds.OPTIMISM_V3_DAI_FEED;

    assets[4] = AaveV3OptimismAssets.MAI_UNDERLYING;
    sources[4] = PriceFeeds.OPTIMISM_V3_MAI_FEED;

    assets[5] = AaveV3OptimismAssets.LUSD_UNDERLYING;
    sources[5] = PriceFeeds.OPTIMISM_V3_LUSD_FEED;

    assets[6] = AaveV3OptimismAssets.sUSD_UNDERLYING;
    sources[6] = PriceFeeds.OPTIMISM_V3_SUSD_FEED;

    AaveV3Optimism.ORACLE.setAssetSources(assets, sources);
  }
}
