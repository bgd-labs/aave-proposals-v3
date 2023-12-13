// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3PolygonAssets, AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3PayloadPolygon} from 'aave-helpers/v3-config-engine/AaveV3PayloadPolygon.sol';

/**
 * @title Disable Stable Borrows
 * @author BGD (@bgdlabs)
 */
contract AaveV3Polygon_Disable_Stable_Borrows_20231104 is AaveV3PayloadPolygon {
  function _postExecute() internal override {
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveStableRateBorrowing(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      false
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveStableRateBorrowing(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      false
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveStableRateBorrowing(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      false
    );
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveStableRateBorrowing(
      AaveV3PolygonAssets.EURS_UNDERLYING,
      false
    );

    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.DAI_UNDERLYING, false);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.USDC_UNDERLYING, false);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.USDT_UNDERLYING, false);
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.EURS_UNDERLYING, false);
  }
}
