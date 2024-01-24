// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Reserve Factor Updates (Jan 15, 2024)
 * @author karpatkey_TokenLogic
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/14
 */
contract AaveV2Polygon_ReserveFactorUpdatesJan152024_20240108 is IProposalGenericExecutor {
  uint256 public constant DAI_RF = 66_00;
  uint256 public constant USDC_RF = 68_00;
  uint256 public constant USDT_RF = 67_00;
  uint256 public constant WBTC_RF = 99_99;
  uint256 public constant WETH_RF = 90_00;
  uint256 public constant WMATIC_RF = 86_00;
  uint256 public constant BAL_RF = 99_99;

  function execute() external {
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      DAI_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      USDC_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      USDT_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.WBTC_UNDERLYING,
      WBTC_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.WETH_UNDERLYING,
      WETH_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      WMATIC_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.BAL_UNDERLYING,
      BAL_RF
    );
  }
}
