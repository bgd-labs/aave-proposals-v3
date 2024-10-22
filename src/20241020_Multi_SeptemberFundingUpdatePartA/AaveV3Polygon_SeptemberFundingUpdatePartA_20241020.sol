// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title September Funding Update Part A
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Polygon_SeptemberFundingUpdatePartA_20241020 is IProposalGenericExecutor {
  struct Migration {
    address underlying;
    address aToken;
    uint256 leaveBehind;
  }

  uint256 public constant BALANCE_LEFT_USDT = 1e6;
  uint256 public constant BALANCE_LEFT_DAI = 1 ether;
  uint256 public constant BALANCE_LEFT_WPOL = 1 ether;
  uint256 public constant BALANCE_LEFT_WETH = 1 ether;
  uint256 public constant BALANCE_LEFT_WBTC = 100000;
  uint256 public constant BALANCE_LEFT_LINK = 1 ether;

  function execute() external {
    Migration[] memory migrations = new Migration[](6);
    migrations[0] = Migration({
      underlying: AaveV2PolygonAssets.USDT_UNDERLYING,
      aToken: AaveV2PolygonAssets.USDT_A_TOKEN,
      leaveBehind: BALANCE_LEFT_USDT
    });
    migrations[1] = Migration({
      underlying: AaveV2PolygonAssets.DAI_UNDERLYING,
      aToken: AaveV2PolygonAssets.DAI_A_TOKEN,
      leaveBehind: BALANCE_LEFT_DAI
    });
    migrations[2] = Migration({
      underlying: AaveV2PolygonAssets.WPOL_UNDERLYING,
      aToken: AaveV2PolygonAssets.WPOL_A_TOKEN,
      leaveBehind: BALANCE_LEFT_WPOL
    });
    migrations[3] = Migration({
      underlying: AaveV2PolygonAssets.WETH_UNDERLYING,
      aToken: AaveV2PolygonAssets.WETH_A_TOKEN,
      leaveBehind: BALANCE_LEFT_WETH
    });
    migrations[4] = Migration({
      underlying: AaveV2PolygonAssets.WBTC_UNDERLYING,
      aToken: AaveV2PolygonAssets.WBTC_A_TOKEN,
      leaveBehind: BALANCE_LEFT_WBTC
    });
    migrations[5] = Migration({
      underlying: AaveV2PolygonAssets.LINK_UNDERLYING,
      aToken: AaveV2PolygonAssets.LINK_A_TOKEN,
      leaveBehind: BALANCE_LEFT_LINK
    });

    for (uint i = 0; i < migrations.length; i++) {
      uint256 withdrawAmount = IERC20(migrations[i].aToken).balanceOf(
        address(AaveV3Polygon.COLLECTOR)
      ) - migrations[i].leaveBehind;
      CollectorUtils.IOInput memory input = CollectorUtils.IOInput(
        address(AaveV2Polygon.POOL),
        migrations[i].underlying,
        withdrawAmount
      );
      CollectorUtils.withdrawFromV2(
        AaveV3Polygon.COLLECTOR,
        input,
        address(AaveV3Polygon.COLLECTOR)
      );

      uint256 balance = IERC20(migrations[i].underlying).balanceOf(
        address(AaveV3Polygon.COLLECTOR)
      );
      input = CollectorUtils.IOInput(
        address(AaveV3Polygon.POOL),
        migrations[i].underlying,
        balance
      );
      CollectorUtils.depositToV3(AaveV3Polygon.COLLECTOR, input);
    }
  }
}
