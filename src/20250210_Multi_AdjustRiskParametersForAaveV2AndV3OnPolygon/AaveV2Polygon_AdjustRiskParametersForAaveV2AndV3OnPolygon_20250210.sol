// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
/**
 * @title Adjust Risk Parameters for Aave V2 and V3 on Polygon
 * @author Aave-chan Initiative
 * - Snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x48cb2ca277c9cfa0855e8561878836eea182e45dea0e140c03786e533519c2dc
 * - Discussion: https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211
 */
contract AaveV2Polygon_AdjustRiskParametersForAaveV2AndV3OnPolygon_20250210 is
  IProposalGenericExecutor
{
  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      0,
      8450,
      10500
    );

    AaveV2Polygon.POOL_CONFIGURATOR.configureReserveAsCollateral(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      0,
      7700,
      10500
    );
  }
}
