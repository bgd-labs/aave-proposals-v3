// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title ReserveFactorUpdates
 * @author TokenLogic
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/22
 */
contract AaveV2Polygon_ReserveFactorUpdates_20240412 is IProposalGenericExecutor {
  uint256 public constant DAI_RF = 96_00;
  uint256 public constant USDC_RF = 98_00;
  uint256 public constant USDT_RF = 97_00;

  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, DAI_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, USDC_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, USDT_RF);
  }
}
