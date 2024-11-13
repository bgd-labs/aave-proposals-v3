// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Polygon_SeptemberFundingUpdatePartA_20241113} from './AaveV3Polygon_SeptemberFundingUpdatePartA_20241113.sol';

/**
 * @dev Test for AaveV3Polygon_SeptemberFundingUpdatePartA_20241113
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241113_Multi_SeptemberFundingUpdatePartA/AaveV3Polygon_SeptemberFundingUpdatePartA_20241113.t.sol -vv
 */
contract AaveV3Polygon_SeptemberFundingUpdatePartA_20241113_Test is ProtocolV3TestBase {
  event Bridge(address token, uint256 amount);
  event Transfer(address from, address to, uint256 amount);

  AaveV3Polygon_SeptemberFundingUpdatePartA_20241113 internal proposal;

  address internal COLLECTOR = address(AaveV3Polygon.COLLECTOR);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 64236044);
    proposal = new AaveV3Polygon_SeptemberFundingUpdatePartA_20241113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_SeptemberFundingUpdatePartA_20241113',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_migrate_USDT() public {
    uint256 collectorUsdtv2BalanceBefore = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdtv3BalanceBefore = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorUsdtv2BalanceAfter = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdtv3BalanceAfter = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorUsdtv2BalanceAfter, 1);
    assertGt(
      collectorUsdtv3BalanceAfter,
      collectorUsdtv3BalanceBefore + collectorUsdtv2BalanceBefore
    );
  }

  function test_migrate_DAI() public {
    uint256 collectorDaiv2BalanceBefore = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorDaiv3BalanceBefore = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorDaiv2BalanceAfter = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorDaiv3BalanceAfter = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorDaiv2BalanceAfter, 1);
    assertGt(collectorDaiv3BalanceAfter, collectorDaiv3BalanceBefore + collectorDaiv2BalanceBefore);
  }

  function test_migrate_WPOL() public {
    uint256 collectorWpolv2BalanceBefore = IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWpolv3BalanceBefore = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorWpolv2BalanceAfter = IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWpolv3BalanceAfter = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorWpolv2BalanceAfter, 1);
    assertGt(
      collectorWpolv3BalanceAfter,
      collectorWpolv3BalanceBefore + collectorWpolv2BalanceBefore
    );
  }

  function test_migrate_WETH() public {
    uint256 collectorWethv2BalanceBefore = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWethv3BalanceBefore = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorWethv2BalanceAfter = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWethv3BalanceAfter = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorWethv2BalanceAfter, 1);
    assertGt(
      collectorWethv3BalanceAfter,
      collectorWethv3BalanceBefore + collectorWethv2BalanceBefore
    );
  }

  function test_migrate_WBTC() public {
    uint256 collectorWbtcv2BalanceBefore = IERC20(AaveV2PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWbtcv3BalanceBefore = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorWbtcv2BalanceAfter = IERC20(AaveV2PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWbtcv3BalanceAfter = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorWbtcv2BalanceAfter, 1);
    assertGt(
      collectorWbtcv3BalanceAfter,
      collectorWbtcv3BalanceBefore + collectorWbtcv2BalanceBefore
    );
  }

  function test_migrate_LINK() public {
    uint256 collectorLinkv2BalanceBefore = IERC20(AaveV2PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorLinkv3BalanceBefore = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorLinkv2BalanceAfter = IERC20(AaveV2PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorLinkv3BalanceAfter = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorLinkv2BalanceAfter, 1);
    assertGt(
      collectorLinkv3BalanceAfter,
      collectorLinkv3BalanceBefore + collectorLinkv2BalanceBefore
    );
  }

  function test_bridge() public {
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 287474631580);
    executePayload(vm, address(proposal));

    uint256 collectorAusdcv3BalanceAfter = IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertEq(collectorAusdcv3BalanceAfter, 1);
  }
}
