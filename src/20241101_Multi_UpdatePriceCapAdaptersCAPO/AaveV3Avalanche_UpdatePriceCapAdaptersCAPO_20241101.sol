// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {AaveV2Avalanche, AaveV2AvalancheAssets} from 'aave-address-book/AaveV2Avalanche.sol';
import {PriceFeeds} from './Constants.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Update Price Cap Adapters (CAPO)
 * @author BGD Labs (@bgdlabs)
 * - Snapshot: TODO
 * - Discussion: TODO
 */
contract AaveV3Avalanche_UpdatePriceCapAdaptersCAPO_20241101 is IProposalGenericExecutor {
  function execute() external {
    _updateV2PriceAdapters();
    _updateV3PriceAdapters();
  }

  function _updateV3PriceAdapters() internal {
    address[] memory assets = new address[](5);
    address[] memory sources = new address[](5);

    assets[0] = AaveV3AvalancheAssets.USDC_UNDERLYING;
    sources[0] = PriceFeeds.AVALANCHE_V3_USDC_FEED;

    assets[1] = AaveV3AvalancheAssets.USDt_UNDERLYING;
    sources[1] = PriceFeeds.AVALANCHE_V3_USDT_FEED;

    assets[2] = AaveV3AvalancheAssets.DAIe_UNDERLYING;
    sources[2] = PriceFeeds.AVALANCHE_V3_DAI_FEED;

    assets[3] = AaveV3AvalancheAssets.FRAX_UNDERLYING;
    sources[3] = PriceFeeds.AVALANCHE_V3_FRAX_FEED;

    assets[4] = AaveV3AvalancheAssets.MAI_UNDERLYING;
    sources[4] = PriceFeeds.AVALANCHE_V3_MAI_FEED;

    AaveV3Avalanche.ORACLE.setAssetSources(assets, sources);
  }

  function _updateV2PriceAdapters() internal {
    address[] memory assets = new address[](3);
    address[] memory sources = new address[](3);

    assets[0] = AaveV2AvalancheAssets.USDCe_UNDERLYING;
    sources[0] = PriceFeeds.AVALANCHE_V3_USDC_FEED;

    assets[1] = AaveV2AvalancheAssets.USDTe_UNDERLYING;
    sources[1] = PriceFeeds.AVALANCHE_V3_USDT_FEED;

    assets[2] = AaveV2AvalancheAssets.DAIe_UNDERLYING;
    sources[2] = PriceFeeds.AVALANCHE_V3_DAI_FEED;

    AaveV2Avalanche.ORACLE.setAssetSources(assets, sources);
  }
}
