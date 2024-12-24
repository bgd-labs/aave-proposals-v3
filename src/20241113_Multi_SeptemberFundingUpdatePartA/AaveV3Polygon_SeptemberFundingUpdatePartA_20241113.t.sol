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
    uint256 collectorUsdtV2BalanceBefore = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdtV3BalanceBefore = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorUsdtV2BalanceAfter = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdtV3BalanceAfter = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorUsdtV2BalanceAfter, 1e6, 45_000e6);
    assertApproxEqAbs(
      collectorUsdtV3BalanceAfter,
      collectorUsdtV3BalanceBefore + collectorUsdtV2BalanceBefore,
      45_000e6
    );
  }

  function test_migrate_DAI() public {
    uint256 collectorDaiV2BalanceBefore = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorDaiV3BalanceBefore = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorDaiV2BalanceAfter = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorDaiV3BalanceAfter = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorDaiV2BalanceAfter, 1e18, 19_000e18);
    assertApproxEqAbs(
      collectorDaiV3BalanceAfter,
      collectorDaiV3BalanceBefore + collectorDaiV2BalanceBefore,
      26_000e18
    );
  }

  function test_migrate_WPOL() public {
    uint256 collectorWPolV2BalanceBefore = IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWPolV3BalanceBefore = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorWPolV2BalanceAfter = IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWPolV3BalanceAfter = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorWPolV2BalanceAfter, 1e18, 400e18);
    assertApproxEqAbs(
      collectorWPolV3BalanceAfter,
      collectorWPolV3BalanceBefore + collectorWPolV2BalanceBefore,
      5_000e18
    );
  }

  function test_migrate_WETH() public {
    uint256 collectorWEthV2BalanceBefore = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWEthV3BalanceBefore = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorWEthV2BalanceAfter = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWEthV3BalanceAfter = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorWEthV2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(
      collectorWEthV3BalanceAfter,
      collectorWEthV3BalanceBefore + collectorWEthV2BalanceBefore,
      3e18
    );
  }

  function test_migrate_WBTC() public {
    uint256 collectorWBtcV2BalanceBefore = IERC20(AaveV2PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWBtcV3BalanceBefore = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorWBtcV2BalanceAfter = IERC20(AaveV2PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWBtcV3BalanceAfter = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    // doesn't migrated because balance is below than unit
    assertEq(collectorWBtcV2BalanceBefore, collectorWBtcV2BalanceAfter);
    assertEq(collectorWBtcV3BalanceAfter, collectorWBtcV3BalanceBefore);
  }

  function test_migrate_LINK() public {
    uint256 collectorLinkV2BalanceBefore = IERC20(AaveV2PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorLinkV3BalanceBefore = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorLinkV2BalanceAfter = IERC20(AaveV2PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorLinkV3BalanceAfter = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorLinkV2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(
      collectorLinkV3BalanceAfter,
      collectorLinkV3BalanceBefore + collectorLinkV2BalanceBefore,
      45e18
    );
  }

  function test_bridge() public {
    vm.expectEmit(true, false, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 287195325014); // dynamically calculated
    executePayload(vm, address(proposal));

    uint256 collectorAUsdcV2BalanceAfter = IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorAUsdcV3BalanceAfter = IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorAUsdcV2BalanceAfter, 1e6, 15_000e6);
    assertApproxEqAbs(collectorAUsdcV3BalanceAfter, 1e6, 10_000e6);
  }
}
