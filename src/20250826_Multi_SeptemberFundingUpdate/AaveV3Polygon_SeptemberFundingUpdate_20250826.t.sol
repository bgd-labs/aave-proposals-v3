// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_SeptemberFundingUpdate_20250826} from './AaveV3Polygon_SeptemberFundingUpdate_20250826.sol';

/**
 * @dev Test for AaveV3Polygon_SeptemberFundingUpdate_20250826
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250826_Multi_SeptemberFundingUpdate/AaveV3Polygon_SeptemberFundingUpdate_20250826.t.sol -vv
 */
contract AaveV3Polygon_SeptemberFundingUpdate_20250826_Test is ProtocolV3TestBase {
  event Bridge(address token, uint256 amount);

  AaveV3Polygon_SeptemberFundingUpdate_20250826 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 75695832);
    proposal = new AaveV3Polygon_SeptemberFundingUpdate_20250826();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_SeptemberFundingUpdate_20250826',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_approvals() public {
    assertEq(
      IERC20(AaveV3PolygonAssets.USDCn_UNDERLYING).allowance(
        address(AaveV3Polygon.COLLECTOR),
        MiscPolygon.AFC_SAFE
      ),
      0
    );

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3PolygonAssets.USDCn_UNDERLYING).allowance(
        address(AaveV3Polygon.COLLECTOR),
        MiscPolygon.AFC_SAFE
      ),
      proposal.USDC_AMOUNT()
    );

    vm.startPrank(MiscPolygon.AFC_SAFE);
    IERC20(AaveV3PolygonAssets.USDCn_UNDERLYING).transferFrom(
      address(AaveV3Polygon.COLLECTOR),
      MiscPolygon.AFC_SAFE,
      proposal.USDC_AMOUNT()
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

    uint256 wbtcCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    uint256 maticxCollectorBalanceBefore = IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    assertGt(usdtCollectorBalanceBefore, 0);
    assertGt(daiCollectorBalanceBefore, 0);
    assertGt(usdcCollectorBalanceBefore, 0);
    assertGt(wbtcCollectorBalanceBefore, 0);
    assertGt(maticxCollectorBalanceBefore, 0);

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, usdtCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, daiCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, usdcCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.LINK_UNDERLYING, wbtcCollectorBalanceBefore);
    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, maticxCollectorBalanceBefore);

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
      IERC20(AaveV3PolygonAssets.WBTC_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.MaticX_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );
  }
}
