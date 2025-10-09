// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @title Full Deprecation of DPI Across Aave Deployments
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/direct-to-aip-full-deprecation-of-dpi-across-aave-deployments/23212
 */
contract AaveV2Polygon_FullDeprecationOfDPIAcrossAaveDeployments_20251008 is
  IProposalGenericExecutor
{
  address public constant FIXED_DPI_ETH_FEED = 0xD550Bce1a506F48802C9A4464c64E14A3141cE73;

  function execute() external {
    address[] memory assets = new address[](1);
    address[] memory sources = new address[](1);

    assets[0] = AaveV2PolygonAssets.DPI_UNDERLYING;
    sources[0] = FIXED_DPI_ETH_FEED;

    AaveV2Polygon.ORACLE.setAssetSources(assets, sources);
  }
}
