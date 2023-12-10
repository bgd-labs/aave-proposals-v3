// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2PayloadPolygon} from 'aave-helpers/v2-config-engine/AaveV2PayloadPolygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

/**
 * @title Chaos Labs V2 Ethereum and Polygon LT Reductions
 * @author Chaos Labs
 * - Snapshot: “Direct-to-AIP”
 * - Discussion: https://governance.aave.com/t/arfc-v2-ethereum-and-polygon-lt-reductions-12-04-2023/15747
 */
contract AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205 is AaveV2PayloadPolygon {
  function _postExecute() internal override {
    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.SUSHI_UNDERLYING,
      0,
      5,
      11000
    );

    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.DPI_UNDERLYING,
      0,
      5,
      11000
    );

    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.BAL_UNDERLYING,
      0,
      5,
      11000
    );

    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.CRV_UNDERLYING,
      0,
      5,
      11000
    );

    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.GHST_UNDERLYING,
      0,
      5,
      11250
    );

    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.LINK_UNDERLYING,
      0,
      5,
      10750
    );
  }
}
