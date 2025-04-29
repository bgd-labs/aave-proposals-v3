// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {IAavePolEthPlasmaBridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthPlasmaBridge.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';

interface WPOL {
  function withdraw(uint256 wad) external;
}

/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-2025-funding-update/21906
 */
contract AaveV3Polygon_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  address public constant COLLECTOR = address(AaveV3Polygon.COLLECTOR);
  address public constant BRIDGE = MiscPolygon.AAVE_POL_ETH_BRIDGE;

  /// https://polygonscan.com/address/0xc980508cC8866f726040Da1C0C61f682e74aBc39
  address public constant PLASMA_BRIDGE = 0xc980508cC8866f726040Da1C0C61f682e74aBc39;

  function execute() external {
    /// DAI
    uint256 daiBalance = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING),
      BRIDGE,
      daiBalance
    );
    IAavePolEthERC20Bridge(BRIDGE).bridge(AaveV3PolygonAssets.DAI_UNDERLYING, daiBalance);

    /// USDT
    uint256 usdtBalance = IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING),
      BRIDGE,
      usdtBalance
    );
    IAavePolEthERC20Bridge(BRIDGE).bridge(AaveV3PolygonAssets.USDT_UNDERLYING, usdtBalance);

    /// USDC
    uint256 usdcBalance = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING),
      BRIDGE,
      usdcBalance
    );
    IAavePolEthERC20Bridge(BRIDGE).bridge(AaveV3PolygonAssets.USDC_UNDERLYING, usdcBalance);

    /// WPOL
    uint256 wpolBalance = IERC20(AaveV3PolygonAssets.WPOL_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.WPOL_UNDERLYING),
      address(this),
      wpolBalance
    );
    WPOL(AaveV3PolygonAssets.WPOL_UNDERLYING).withdraw(wpolBalance);
    (bool success, ) = payable(PLASMA_BRIDGE).call{value: wpolBalance}('');
    require(success);
    IAavePolEthPlasmaBridge(PLASMA_BRIDGE).bridge(wpolBalance);

    /// WBTC
    uint256 wbtcBalance = IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING),
      BRIDGE,
      wbtcBalance
    );
    IAavePolEthERC20Bridge(BRIDGE).bridge(AaveV3PolygonAssets.WBTC_UNDERLYING, wbtcBalance);

    /// MATICX
    uint256 maticxBalance = IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING),
      BRIDGE,
      maticxBalance
    );
    IAavePolEthERC20Bridge(BRIDGE).bridge(AaveV3PolygonAssets.MaticX_UNDERLYING, maticxBalance);

    /// WETH
    uint256 wethBalance = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING),
      BRIDGE,
      wethBalance
    );
    IAavePolEthERC20Bridge(BRIDGE).bridge(AaveV3PolygonAssets.WETH_UNDERLYING, wethBalance);
  }
}
