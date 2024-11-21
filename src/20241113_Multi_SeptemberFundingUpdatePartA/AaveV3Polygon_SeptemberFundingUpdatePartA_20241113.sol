// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';

interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

/**
 * @title September Funding Update - Part A
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Polygon_SeptemberFundingUpdatePartA_20241113 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  struct Migration {
    address underlying;
    address aToken;
    uint256 leaveBehind;
  }

  IAavePolEthERC20Bridge public constant BRIDGE =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);

  function execute() external override {
    _migrateToken();
    _bridge();
  }

  function _migrateToken() internal {
    Migration[] memory migrations = new Migration[](6);

    migrations[0] = Migration({
      underlying: AaveV3PolygonAssets.USDT_UNDERLYING,
      aToken: AaveV2PolygonAssets.USDT_A_TOKEN,
      leaveBehind: 10 ** AaveV3PolygonAssets.USDT_DECIMALS
    });
    migrations[1] = Migration({
      underlying: AaveV3PolygonAssets.DAI_UNDERLYING,
      aToken: AaveV2PolygonAssets.DAI_A_TOKEN,
      leaveBehind: 10 ** AaveV3PolygonAssets.DAI_DECIMALS
    });
    migrations[2] = Migration({
      underlying: AaveV3PolygonAssets.WPOL_UNDERLYING,
      aToken: AaveV2PolygonAssets.WPOL_A_TOKEN,
      leaveBehind: 10 ** AaveV3PolygonAssets.WPOL_DECIMALS
    });
    migrations[3] = Migration({
      underlying: AaveV3PolygonAssets.WETH_UNDERLYING,
      aToken: AaveV2PolygonAssets.WETH_A_TOKEN,
      leaveBehind: 10 ** AaveV3PolygonAssets.WETH_DECIMALS
    });
    migrations[4] = Migration({
      underlying: AaveV3PolygonAssets.WBTC_UNDERLYING,
      aToken: AaveV2PolygonAssets.WBTC_A_TOKEN,
      leaveBehind: 10 ** AaveV3PolygonAssets.WBTC_DECIMALS
    });
    migrations[5] = Migration({
      underlying: AaveV3PolygonAssets.LINK_UNDERLYING,
      aToken: AaveV2PolygonAssets.LINK_A_TOKEN,
      leaveBehind: 10 ** AaveV3PolygonAssets.LINK_DECIMALS
    });

    for (uint256 i = 0; i < 6; ) {
      uint256 aTokenBalance = IScaledBalanceToken(migrations[i].aToken).scaledBalanceOf(
        address(AaveV3Polygon.COLLECTOR)
      );

      if (aTokenBalance > migrations[i].leaveBehind) {
        AaveV3Polygon.COLLECTOR.withdrawFromV2(
          CollectorUtils.IOInput({
            pool: address(AaveV2Polygon.POOL),
            underlying: migrations[i].underlying,
            amount: aTokenBalance - migrations[i].leaveBehind
          }),
          address(AaveV3Polygon.COLLECTOR)
        );

        /// deposit
        AaveV3Polygon.COLLECTOR.depositToV3(
          CollectorUtils.IOInput({
            pool: address(AaveV3Polygon.POOL),
            underlying: migrations[i].underlying,
            amount: type(uint256).max
          })
        );
      }

      unchecked {
        ++i;
      }
    }
  }

  function _bridge() internal {
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.USDC_UNDERLYING,
        amount: IScaledBalanceToken(AaveV3PolygonAssets.USDC_A_TOKEN).scaledBalanceOf(
          address(AaveV3Polygon.COLLECTOR)
        ) - 1e6
      }),
      address(BRIDGE)
    );

    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.USDC_UNDERLYING,
        amount: IScaledBalanceToken(AaveV2PolygonAssets.USDC_A_TOKEN).scaledBalanceOf(
          address(AaveV2Polygon.COLLECTOR)
        ) - 1e6
      }),
      address(BRIDGE)
    );

    BRIDGE.bridge(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE))
    );
  }
}
