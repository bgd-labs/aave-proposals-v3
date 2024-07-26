// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';

interface IAavePolEthERC20Bridge {
  function bridge(address token, uint256 amount) external;
}

/**
 * @title May Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768
 */
contract AaveV3Polygon_MayFundingUpdate_20240603 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IAavePolEthERC20Bridge public constant BRIDGE =
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE);

  function execute() external {
    _migrate();
    _bridge();
  }

  function _migrate() internal {
    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDT_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.DAI_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e18
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.WETH_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e18
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 usdtAmount = IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).forceApprove(
      address(AaveV3Polygon.POOL),
      usdtAmount
    );

    uint256 daiAmount = IERC20(AaveV2PolygonAssets.DAI_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2PolygonAssets.DAI_UNDERLYING).forceApprove(address(AaveV3Polygon.POOL), daiAmount);

    uint256 wethAmount = IERC20(AaveV2PolygonAssets.WETH_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2PolygonAssets.WETH_UNDERLYING).forceApprove(
      address(AaveV3Polygon.POOL),
      wethAmount
    );

    AaveV3Polygon.POOL.deposit(
      AaveV2PolygonAssets.USDT_UNDERLYING,
      usdtAmount,
      address(AaveV3Polygon.COLLECTOR),
      0
    );

    AaveV3Polygon.POOL.deposit(
      AaveV2PolygonAssets.DAI_UNDERLYING,
      daiAmount,
      address(AaveV3Polygon.COLLECTOR),
      0
    );

    AaveV3Polygon.POOL.deposit(
      AaveV2PolygonAssets.WETH_UNDERLYING,
      wethAmount,
      address(AaveV3Polygon.COLLECTOR),
      0
    );
  }

  function _bridge() internal {
    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      address(BRIDGE),
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR))
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV3PolygonAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    AaveV3Polygon.POOL.withdraw(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(BRIDGE)
    );

    AaveV3Polygon.COLLECTOR.transfer(
      AaveV2PolygonAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)) - 1e6
    );

    AaveV2Polygon.POOL.withdraw(
      AaveV2PolygonAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(BRIDGE)
    );

    uint256 usdcBalance = IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE));

    BRIDGE.bridge(AaveV2PolygonAssets.USDC_UNDERLYING, usdcBalance);
  }
}
