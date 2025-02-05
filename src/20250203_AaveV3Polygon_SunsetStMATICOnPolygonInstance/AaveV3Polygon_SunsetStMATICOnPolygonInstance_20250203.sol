// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title Sunset stMATIC on Polygon instance
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0xae420f7c844f2ef26dd74a1ed1b4b197aad5b15a8b9c1795a0c205025988fd66
 * - Discussion: https://governance.aave.com/t/arfc-sunset-stmatic-on-polygon-instance/20668
 */
contract AaveV3Polygon_SunsetStMATICOnPolygonInstance_20250203 is IProposalGenericExecutor {
  function execute() external {
    AaveV3Polygon.POOL_CONFIGURATOR.setReserveFreeze(AaveV3PolygonAssets.stMATIC_UNDERLYING, true);
  }
}
