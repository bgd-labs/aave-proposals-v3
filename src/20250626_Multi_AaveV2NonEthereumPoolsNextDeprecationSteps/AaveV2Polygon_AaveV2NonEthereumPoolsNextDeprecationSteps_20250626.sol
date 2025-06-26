// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @title Aave v2 non-Ethereum pools next deprecation steps
 * @author BGD Labs (@bgdlabs)
 * - Discussion: https://governance.aave.com/t/direct-to-aip-aave-v2-non-ethereum-pools-next-deprecation-steps/22445
 */
contract AaveV2Polygon_AaveV2NonEthereumPoolsNextDeprecationSteps_20250626 is
  IProposalGenericExecutor
{
  function execute() external {
    address[] memory reservesToFreeze = new address[](6);
    reservesToFreeze[0] = AaveV2PolygonAssets.DAI_UNDERLYING;
    reservesToFreeze[1] = AaveV2PolygonAssets.USDC_UNDERLYING;
    reservesToFreeze[2] = AaveV2PolygonAssets.USDT_UNDERLYING;
    reservesToFreeze[3] = AaveV2PolygonAssets.WBTC_UNDERLYING;
    reservesToFreeze[4] = AaveV2PolygonAssets.WPOL_UNDERLYING;
    reservesToFreeze[5] = AaveV2PolygonAssets.WETH_UNDERLYING;

    for (uint256 i = 0; i < reservesToFreeze.length; i++) {
      AaveV2Polygon.POOL_CONFIGURATOR.freezeReserve(reservesToFreeze[i]);
    }
  }
}
