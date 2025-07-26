// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Polygon_July2025FundingUpdate_20250721} from './AaveV3Polygon_July2025FundingUpdate_20250721.sol';

/**
 * @dev Test for AaveV3Polygon_July2025FundingUpdate_20250721
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250721_Multi_July2025FundingUpdate/AaveV3Polygon_July2025FundingUpdate_20250721.t.sol -vv
 */
contract AaveV3Polygon_July2025FundingUpdate_20250721_Test is ProtocolV3TestBase {
  AaveV3Polygon_July2025FundingUpdate_20250721 internal proposal;

  event Bridge(address token, uint256 amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 74320500);
    proposal = new AaveV3Polygon_July2025FundingUpdate_20250721();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_July2025FundingUpdate_20250721',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_bridges() public {
    uint256 usdtCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 daiCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    uint256 usdcCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    uint256 linkCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    uint256 wethCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertGt(usdtCollectorBalanceBefore, 0);
    assertGt(daiCollectorBalanceBefore, 0);
    assertGt(usdcCollectorBalanceBefore, 0);
    assertGt(linkCollectorBalanceBefore, 0);
    assertGt(wethCollectorBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, usdtCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, daiCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, usdcCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.LINK_UNDERLYING, linkCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, wethCollectorBalanceBefore);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.LINK_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.WETH_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );
  }
}
