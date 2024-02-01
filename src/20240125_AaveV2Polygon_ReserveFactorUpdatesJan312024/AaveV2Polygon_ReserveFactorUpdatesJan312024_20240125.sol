// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets, ILendingPoolConfigurator} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Reserve Factor Updates (Jan 31, 2024))
 * @author karpatkey_TokenLogic
 * - Snapshot: No snapshot for Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/14
 */
contract AaveV2Polygon_ReserveFactorUpdatesJan312024_20240125 is IProposalGenericExecutor {
  uint256 public constant DAI_RF = 71_00;
  uint256 public constant USDC_RF = 73_00;
  uint256 public constant USDT_RF = 72_00;
  uint256 public constant WETH_RF = 95_00;
  uint256 public constant WMATIC_RF = 91_00;

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
      AaveV2PolygonAssets.WETH_UNDERLYING,
      WETH_RF
    );
    ILendingPoolConfigurator(AaveV2Polygon.POOL_CONFIGURATOR).setReserveFactor(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      WMATIC_RF
    );
  }
}
