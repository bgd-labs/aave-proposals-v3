// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title February Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-To-AIP
 * - Discussion: https://governance.aave.com/t/arfc-february-funding-update/20712
 */
contract AaveV3Polygon_FebruaryFundingUpdate_20250120 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  function execute() external {
    _withdraw();
    _deposit();
  }

  function _withdraw() internal {
    AaveV3Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.WPOL_UNDERLYING,
        amount: IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(
          address(AaveV3Polygon.COLLECTOR)
        ) - 1 ether
      }),
      address(AaveV3Polygon.COLLECTOR)
    );

    AaveV3Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.USDT_UNDERLYING,
        amount: IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
          address(AaveV3Polygon.COLLECTOR)
        ) - 1e6
      }),
      address(AaveV3Polygon.COLLECTOR)
    );
  }

  function _deposit() internal {
    AaveV3Polygon.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.WPOL_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Polygon.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.USDT_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Polygon.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.WBTC_UNDERLYING,
        amount: type(uint256).max
      })
    );

    AaveV3Polygon.COLLECTOR.depositToV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.LINK_UNDERLYING,
        amount: type(uint256).max
      })
    );
  }
}
