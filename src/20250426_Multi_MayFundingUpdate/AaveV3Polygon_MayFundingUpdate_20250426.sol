// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IAavePolEthERC20Bridge} from 'aave-helpers/src/bridges/polygon/IAavePolEthERC20Bridge.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Polygon_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  address public constant DAI = AaveV3PolygonAssets.DAI_UNDERLYING;
  address public constant USDT = AaveV3PolygonAssets.USDT_UNDERLYING;
  address public constant USDC = AaveV3PolygonAssets.USDC_UNDERLYING;
  address public constant WPOL = AaveV3PolygonAssets.WPOL_UNDERLYING;
  address public constant WBTC = AaveV3PolygonAssets.WBTC_UNDERLYING;
  address public constant MATICX = AaveV3PolygonAssets.MaticX_UNDERLYING;
  address public constant ETH = AaveV3PolygonAssets.WETH_UNDERLYING;
  address public constant COLLECTOR = address(AaveV3Polygon.COLLECTOR);
  address public constant BRIDGE = MiscPolygon.AAVE_POL_ETH_BRIDGE;

  function execute() external {
    /// DAI
    uint256 daiBalance = IERC20(DAI).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(DAI), BRIDGE, daiBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(DAI, daiBalance);

    /// USDT
    uint256 usdtBalance = IERC20(USDT).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(USDT), BRIDGE, usdtBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(USDT, usdtBalance);

    /// USDC
    uint256 usdcBalance = IERC20(USDC).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(USDC), BRIDGE, usdcBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(USDC, usdcBalance);

    /// WPOL
    uint256 wpolBalance = IERC20(WPOL).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(WPOL), BRIDGE, wpolBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(WPOL, wpolBalance);

    /// WBTC
    uint256 wbtcBalance = IERC20(WBTC).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(WBTC), BRIDGE, wbtcBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(WBTC, wbtcBalance);

    /// MATICX
    uint256 maticxBalance = IERC20(MATICX).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(MATICX), BRIDGE, maticxBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(MATICX, maticxBalance);

    /// ETH
    uint256 ethBalance = IERC20(ETH).balanceOf(COLLECTOR);
    AaveV3Polygon.COLLECTOR.transfer(IERC20(ETH), BRIDGE, ethBalance);
    IAavePolEthERC20Bridge(BRIDGE).bridge(ETH, ethBalance);
  }
}
