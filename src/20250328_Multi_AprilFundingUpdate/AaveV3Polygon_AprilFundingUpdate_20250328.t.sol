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
    vm.createSelectFork(vm.rpcUrl('polygon'), 70007673);
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
    uint256 usdcBalanceAfter = IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertEq(usdcBalanceAfter, 0);

    // usdt
    uint256 usdtBalanceAfter = IERC20(AaveV2PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertEq(usdtBalanceAfter, 0);

    // DAI
    uint256 daiBalanceAfter = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertEq(daiBalanceAfter, 0);

    // WETH
    uint256 wETHBalanceAfter = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertEq(wETHBalanceAfter, 0);
  }

  function test_log() public {
    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 128255461879);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, 2230512605644);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, 9737956185483774043);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 104510078595292261372824);
    executePayload(vm, address(proposal));
  }
}
