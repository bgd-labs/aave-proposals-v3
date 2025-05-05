// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_MayFundingUpdate_20250426} from './AaveV3Polygon_MayFundingUpdate_20250426.sol';

/**
 * @dev Test for AaveV3Polygon_MayFundingUpdate_20250426
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20250426_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20250426.t.sol -vv
 */
contract AaveV3Polygon_MayFundingUpdate_20250426_Test is ProtocolV3TestBase {
  AaveV3Polygon_MayFundingUpdate_20250426 internal proposal;

  event Bridge(address token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 70871207);
    proposal = new AaveV3Polygon_MayFundingUpdate_20250426();
  }

  function test_Bridges() public {
    uint256 daiCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 usdtCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 wpolCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.WPOL_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 wbtcCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 maticxCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 wethCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertGt(daiCollectorBalanceBefore, 0);
    assertGt(usdtCollectorBalanceBefore, 0);
    assertGt(usdcCollectorBalanceBefore, 0);
    assertGt(wpolCollectorBalanceBefore, 0);
    assertGt(wbtcCollectorBalanceBefore, 0);
    assertGt(maticxCollectorBalanceBefore, 0);
    assertGt(wethCollectorBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, daiCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, usdtCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, usdcCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, proposal.PLASMA_BRIDGE());
    emit Bridge(0x0000000000000000000000000000000000001010, wpolCollectorBalanceBefore); /// native bridge
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WBTC_UNDERLYING, wbtcCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.MaticX_UNDERLYING, maticxCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, wethCollectorBalanceBefore);
    executePayload(vm, address(proposal));

    uint256 daiCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 usdtCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 usdcCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 wpolCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.WPOL_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 wbtcCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 maticxCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 wethCollectorBalanceAfter = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertEq(daiCollectorBalanceAfter, 0);
    assertEq(usdtCollectorBalanceAfter, 0);
    assertEq(usdcCollectorBalanceAfter, 0);
    assertEq(wpolCollectorBalanceAfter, 0);
    assertEq(wbtcCollectorBalanceAfter, 0);
    assertEq(maticxCollectorBalanceAfter, 0);
    assertEq(wethCollectorBalanceAfter, 0);
  }
}
