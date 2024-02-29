// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';

/**
 * @title Reserve Factor Updates (February 29, 2024)
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/18
 */
contract AaveV2Polygon_ReserveFactorUpdatesFebruary292024_20240229 is IProposalGenericExecutor {
  uint256 public constant DAI_RF = 81_00;
  uint256 public constant USDC_RF = 83_00;
  uint256 public constant USDT_RF = 82_00;
  uint256 public constant WMATIC_RF = 99_99;

  function execute() external {
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.DAI_UNDERLYING, DAI_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDC_UNDERLYING, USDC_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(AaveV2PolygonAssets.USDT_UNDERLYING, USDT_RF);
    AaveV2Polygon.POOL_CONFIGURATOR.setReserveFactor(
      AaveV2PolygonAssets.WMATIC_UNDERLYING,
      WMATIC_RF
    );
  }
}
