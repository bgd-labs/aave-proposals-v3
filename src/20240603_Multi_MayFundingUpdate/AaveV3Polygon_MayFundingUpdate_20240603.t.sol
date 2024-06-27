// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {AaveV3Polygon_MayFundingUpdate_20240603} from './AaveV3Polygon_MayFundingUpdate_20240603.sol';

/**
 * @dev Test for AaveV3Polygon_MayFundingUpdate_20240603
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240603_Multi_MayFundingUpdate/AaveV3Polygon_MayFundingUpdate_20240603.t.sol -vv
 */
contract AaveV3Polygon_MayFundingUpdate_20240603_Test is ProtocolV3TestBase {
  AaveV3Polygon_MayFundingUpdate_20240603 internal proposal;

  address internal COLLECTOR = address(AaveV3Polygon.COLLECTOR);

  event Bridge(address token, uint256 amount);
  event Transfer(address from, address to, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 57725360);
    proposal = new AaveV3Polygon_MayFundingUpdate_20240603();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Polygon_MayFundingUpdate_20240603', AaveV3Polygon.POOL, address(proposal));
  }

  function test_migrate() public {
    uint256 collectorUsdtv2BalanceBefore = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdtv3BalanceBefore = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorDaiv2BalanceBefore = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorDaiv3BalanceBefore = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorWethv2BalanceBefore = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWethv3BalanceBefore = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    executePayload(vm, address(proposal));

    uint256 collectorUsdtv2BalanceAfter = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdtv3BalanceAfter = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorDaiv2BalanceAfter = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorDaiv3BalanceAfter = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      COLLECTOR
    );

    uint256 collectorWethv2BalanceAfter = IERC20(AaveV2PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorWethv3BalanceAfter = IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorUsdtv2BalanceAfter, 1e6, 10e6);
    assertApproxEqAbs(collectorDaiv2BalanceAfter, 1e18, 10e18);
    assertApproxEqAbs(collectorWethv2BalanceAfter, 1e18, 1e18);

    assertApproxEqAbs(
      collectorUsdtv3BalanceAfter,
      collectorUsdtv3BalanceBefore + collectorUsdtv2BalanceBefore,
      10e6
    );

    assertApproxEqAbs(
      collectorDaiv3BalanceAfter,
      collectorDaiv3BalanceBefore + collectorDaiv2BalanceBefore,
      10e18
    );

    assertApproxEqAbs(
      collectorWethv3BalanceAfter,
      collectorWethv3BalanceBefore + collectorWethv2BalanceBefore,
      1e18
    );
  }

  function test_bridge() public {
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 146173577275);

    executePayload(vm, address(proposal));

    uint256 collectorAusdcv2BalanceAfter = IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorAusdcv3BalanceAfter = IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(
      COLLECTOR
    );
    uint256 collectorUsdcBalanceAfter = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(
      COLLECTOR
    );

    assertApproxEqAbs(collectorAusdcv2BalanceAfter, 1e6, 10e6);
    assertApproxEqAbs(collectorAusdcv3BalanceAfter, 1e6, 10e6);
    assertApproxEqAbs(collectorUsdcBalanceAfter, 1e6, 10e6);
  }
}
