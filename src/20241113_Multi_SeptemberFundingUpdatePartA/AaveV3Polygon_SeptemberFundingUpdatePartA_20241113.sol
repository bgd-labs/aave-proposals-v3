// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';

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

  IAavePolEthERC20Bridge public constant BRIDGE =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);

  function execute() external override {
    _migrateToken(AaveV3PolygonAssets.USDT_UNDERLYING, AaveV2PolygonAssets.USDT_A_TOKEN);
    _migrateToken(AaveV3PolygonAssets.DAI_UNDERLYING, AaveV2PolygonAssets.DAI_A_TOKEN);
    _migrateToken(AaveV3PolygonAssets.WPOL_UNDERLYING, AaveV2PolygonAssets.WPOL_A_TOKEN);
    _migrateToken(AaveV3PolygonAssets.WETH_UNDERLYING, AaveV2PolygonAssets.WETH_A_TOKEN);
    _migrateToken(AaveV3PolygonAssets.WBTC_UNDERLYING, AaveV2PolygonAssets.WBTC_A_TOKEN);
    _migrateToken(AaveV3PolygonAssets.LINK_UNDERLYING, AaveV2PolygonAssets.LINK_A_TOKEN);

    _bridge();
  }

  function _migrateToken(address underlying, address atoken) internal {
    AaveV3Polygon.COLLECTOR.transfer(
      atoken,
      address(this),
      IERC20(atoken).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1
    );

    AaveV2Polygon.POOL.withdraw(underlying, type(uint256).max, address(this));

    AaveV3Polygon.COLLECTOR.transfer(
      atoken,
      address(this),
      IERC20(atoken).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1
    );

    AaveV2Polygon.POOL.withdraw(underlying, type(uint256).max, address(this));

    uint256 amount = IERC20(underlying).balanceOf(address(this));

    IERC20(underlying).forceApprove(address(AaveV3Polygon.POOL), amount);

    AaveV3Polygon.POOL.deposit(underlying, amount, address(AaveV3Polygon.COLLECTOR), 0);
  }

  function _bridge() internal {
    AaveV3Polygon.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Polygon.POOL),
        underlying: AaveV3PolygonAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV3Polygon.COLLECTOR)
        ) - 1
      }),
      address(BRIDGE)
    );

    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV2Polygon.COLLECTOR))
      }),
      address(BRIDGE)
    );

    AaveV2Polygon.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Polygon.POOL),
        underlying: AaveV2PolygonAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV2Polygon.COLLECTOR)
        ) - 1
      }),
      address(BRIDGE)
    );

    BRIDGE.bridge(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE))
    );
  }
}
