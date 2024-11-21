// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Polygon_SeptemberFundingUpdatePartA_20241113} from './AaveV3Polygon_SeptemberFundingUpdatePartA_20241113.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';

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
    uint256 collectorUsdtv2BalanceBefore = IScaledBalanceToken(AaveV2PolygonAssets.USDT_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorUsdtv3BalanceBefore = IScaledBalanceToken(AaveV3PolygonAssets.USDT_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorUsdtv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.USDT_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorUsdtv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.USDT_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    assertApproxEqAbs(collectorUsdtv2BalanceAfter, 1e6, 45_000e6);
    assertApproxEqAbs(
      collectorUsdtv3BalanceAfter,
      collectorUsdtv3BalanceBefore + collectorUsdtv2BalanceBefore,
      45_000e6
    );
  }

  function test_migrate_DAI() public {
    uint256 collectorDaiv2BalanceBefore = IScaledBalanceToken(AaveV2PolygonAssets.DAI_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorDaiv3BalanceBefore = IScaledBalanceToken(AaveV3PolygonAssets.DAI_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorDaiv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.DAI_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorDaiv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.DAI_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    assertApproxEqAbs(collectorDaiv2BalanceAfter, 1e18, 19_000e18);
    assertApproxEqAbs(
      collectorDaiv3BalanceAfter,
      collectorDaiv3BalanceBefore + collectorDaiv2BalanceBefore,
      26_000e18
    );
  }

  function test_migrate_WPOL() public {
    uint256 collectorWpolv2BalanceBefore = IScaledBalanceToken(AaveV2PolygonAssets.WPOL_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorWpolv3BalanceBefore = IScaledBalanceToken(AaveV3PolygonAssets.WPOL_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorWpolv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.WPOL_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorWpolv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.WPOL_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    assertApproxEqAbs(collectorWpolv2BalanceAfter, 1e18, 400e18);
    assertApproxEqAbs(
      collectorWpolv3BalanceAfter,
      collectorWpolv3BalanceBefore + collectorWpolv2BalanceBefore,
      4_000e18
    );
  }

  function test_migrate_WETH() public {
    uint256 collectorWethv2BalanceBefore = IScaledBalanceToken(AaveV2PolygonAssets.WETH_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorWethv3BalanceBefore = IScaledBalanceToken(AaveV3PolygonAssets.WETH_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorWethv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.WETH_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorWethv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.WETH_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    assertApproxEqAbs(collectorWethv2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(
      collectorWethv3BalanceAfter,
      collectorWethv3BalanceBefore + collectorWethv2BalanceBefore,
      3e18
    );
  }

  function test_migrate_WBTC() public {
    uint256 collectorWbtcv2BalanceBefore = IScaledBalanceToken(AaveV2PolygonAssets.WBTC_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorWbtcv3BalanceBefore = IScaledBalanceToken(AaveV3PolygonAssets.WBTC_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorWbtcv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.WBTC_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorWbtcv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.WBTC_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    // doesn't migrated because balance is below than unit
    assertEq(collectorWbtcv2BalanceBefore, collectorWbtcv2BalanceAfter);
    assertEq(collectorWbtcv3BalanceAfter, collectorWbtcv3BalanceBefore);
  }

  function test_migrate_LINK() public {
    uint256 collectorLinkv2BalanceBefore = IScaledBalanceToken(AaveV2PolygonAssets.LINK_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorLinkv3BalanceBefore = IScaledBalanceToken(AaveV3PolygonAssets.LINK_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    uint256 collectorLinkv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.LINK_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorLinkv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.LINK_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    assertApproxEqAbs(collectorLinkv2BalanceAfter, 1e18, 1e18);
    assertApproxEqAbs(
      collectorLinkv3BalanceAfter,
      collectorLinkv3BalanceBefore + collectorLinkv2BalanceBefore,
      44e18
    );
  }

  function test_bridge() public {
    vm.expectEmit(true, false, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 261_594_781_988); // dynamically calculated
    executePayload(vm, address(proposal));

    uint256 collectorAusdcv2BalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.USDC_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);
    uint256 collectorAusdcv3BalanceAfter = IScaledBalanceToken(AaveV3PolygonAssets.USDC_A_TOKEN)
      .scaledBalanceOf(COLLECTOR);

    assertApproxEqAbs(collectorAusdcv2BalanceAfter, 1e6, 15_000e6);
    assertApproxEqAbs(collectorAusdcv3BalanceAfter, 1e6, 10_000e6);
  }
}