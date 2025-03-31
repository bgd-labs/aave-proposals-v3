// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_AprilFundingUpdate_20250328} from './AaveV3Polygon_AprilFundingUpdate_20250328.sol';

/**
 * @dev Test for AaveV3Polygon_AprilFundingUpdate_20250328
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20250328_Multi_AprilFundingUpdate/AaveV3Polygon_AprilFundingUpdate_20250328.t.sol -vv
 */
contract AaveV3Polygon_AprilFundingUpdate_20250328_Test is ProtocolV3TestBase {
  event Bridge(address token, uint256 amount);

  AaveV3Polygon_AprilFundingUpdate_20250328 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 69604711);
    proposal = new AaveV3Polygon_AprilFundingUpdate_20250328();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Polygon_AprilFundingUpdate_20250328', AaveV3Polygon.POOL, address(proposal));
  }

  function test_balanceAfter() public {
    executePayload(vm, address(proposal));

    // usdc
    uint256 aPolUsdcBalanceAfter = IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amUsdcBalanceAfter = IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    uint256 usdcBalanceAfter = IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolUsdcBalanceAfter, 100e6, 0);
    assertApproxEqAbs(amUsdcBalanceAfter, 100e6, 10e6);
    assertEq(usdcBalanceAfter, 0);

    // usdt
    uint256 aPolUsdtBalanceAfter = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amUsdtBalanceAfter = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    uint256 usdtBalanceAfter = IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolUsdtBalanceAfter, 100e6, 0);
    assertApproxEqAbs(amUsdtBalanceAfter, 100e6, 2e6);
    assertEq(usdtBalanceAfter, 0);

    // DAI
    uint256 aPolDaiBalanceAfter = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amDaiBalanceAfter = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    uint256 daiBalanceAfter = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolDaiBalanceAfter, 1 ether, 0);
    assertApproxEqAbs(amDaiBalanceAfter, 1 ether, 2 ether);
    assertEq(daiBalanceAfter, 0);

    // WETH
    uint256 aPolWETHBalanceAfter = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amWETHBalanceAfter = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    uint256 wETHBalanceAfter = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolWETHBalanceAfter, 1 ether, 0);
    assertApproxEqAbs(amWETHBalanceAfter, 1 ether, 1 ether);
    assertEq(wETHBalanceAfter, 0);
  }

  function test_log() public {
    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 106687044697);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, 2213967092441);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, 6507833636279003491);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 94302912858571071084878);
    executePayload(vm, address(proposal));
  }
}
