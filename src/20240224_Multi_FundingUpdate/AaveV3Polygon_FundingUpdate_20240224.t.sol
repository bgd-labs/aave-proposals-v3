// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

import {AaveV3Polygon_FundingUpdate_20240224} from './AaveV3Polygon_FundingUpdate_20240224.sol';

/**
 * @dev Test for AaveV3Polygon_FundingUpdate_20240224
 * command: make test-contract filter=AaveV3Polygon_FundingUpdate_20240224
 */
contract AaveV3Polygon_FundingUpdate_20240224_Test is ProtocolV3TestBase {
  event Bridge(address token, uint256 amount);

  AaveV3Polygon_FundingUpdate_20240224 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 53919052);
    proposal = new AaveV3Polygon_FundingUpdate_20240224();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    assertGt(
      IERC20(AaveV3PolygonAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolWETH not greater than 0'
    );

    assertGt(
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolDAI not greater than 0'
    );

    assertGt(
      IERC20(AaveV3PolygonAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolBAL not greater than 0'
    );

    assertGt(
      IERC20(AaveV3PolygonAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolCRV not greater than 0'
    );

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, 268586927209511561696); // ~268 units

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 559109670176764998505378); // ~559,109 units

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.BAL_UNDERLYING, 6029363813545159141241); // ~6,029 units

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.CRV_UNDERLYING, 12017495831846027272036); // ~12,017 units

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether,
      1 ether,
      'aPolWETH token remainder greater than 1 unit'
    );

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether,
      1 ether,
      'aPolDAI token remainder greater than 1 unit'
    );

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.BAL_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether,
      1 ether,
      'aPolBAL token remainder greater than 1 unit'
    );

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.CRV_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether,
      1 ether,
      'aPolCRV token remainder greater than 1 unit'
    );
  }
}
