// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title AaveV2Polygon_ReserveFactorUpdate_20240429 (April 29, 2024)
 * @author dd0sxx_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/20
 */
contract AaveV2Polygon_ReserveFactorUpdate_20240429 is IProposalGenericExecutor {
  uint256 public constant DAI_RF = 99_99;
  uint256 public constant USDC_RF = 99_99;
  uint256 public constant USDT_RF = 99_99;

  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, DAI_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, USDC_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, USDT_RF);
  }
}
