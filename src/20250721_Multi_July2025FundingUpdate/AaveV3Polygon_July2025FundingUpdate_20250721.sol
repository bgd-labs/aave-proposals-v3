// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

/**
 * @title July 2025 - Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555
 */
contract AaveV3Polygon_July2025FundingUpdate_20250721 is IProposalGenericExecutor {
  function execute() external {
    // USDT
    uint256 usdtBalance = IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      usdtBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDT_UNDERLYING,
      usdtBalance
    );

    // DAI
    uint256 daiBalance = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      daiBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.DAI_UNDERLYING,
      daiBalance
    );

    // USDC
    uint256 usdcBalance = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      usdcBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.USDC_UNDERLYING,
      usdcBalance
    );

    // LINK
    uint256 linkBalance = IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.LINK_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      linkBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.LINK_UNDERLYING,
      linkBalance
    );

    // wETH
    uint256 wethBalance = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING),
      MiscPolygon.AAVE_POL_ETH_BRIDGE,
      wethBalance
    );
    IAavePolEthERC20Bridge(MiscPolygon.AAVE_POL_ETH_BRIDGE).bridge(
      AaveV3PolygonAssets.WETH_UNDERLYING,
      wethBalance
    );
  }
}
