// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_FebruaryFundingUpdatePartB_20250207} from './AaveV3Polygon_FebruaryFundingUpdatePartB_20250207.sol';

/**
 * @dev Test for AaveV3Polygon_FebruaryFundingUpdatePartB_20250207
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20250207_Multi_FebruaryFundingUpdatePartB/AaveV3Polygon_FebruaryFundingUpdatePartB_20250207.t.sol -vv
 */
contract AaveV3Polygon_FebruaryFundingUpdatePartB_20250207_Test is ProtocolV3TestBase {
  event Bridge(address token, uint256 amount);

  AaveV3Polygon_FebruaryFundingUpdatePartB_20250207 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 68081740);
    proposal = new AaveV3Polygon_FebruaryFundingUpdatePartB_20250207();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_FebruaryFundingUpdatePartB_20250207',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_balanceAfter() public {
    executePayload(vm, address(proposal));

    uint256 aPolUsdcBalanceAfter = IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amUsdcBalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.USDC_A_TOKEN)
      .scaledBalanceOf(address(AaveV2Polygon.COLLECTOR));
    uint256 usdcBalanceAfter = IERC20(AaveV2PolygonAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolUsdcBalanceAfter, 1e6, 100);
    assertApproxEqAbs(amUsdcBalanceAfter, 1e6, 200_000e6);
    assertEq(usdcBalanceAfter, 0);

    uint256 aPolBalBalanceAfter = IERC20(AaveV3PolygonAssets.BAL_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amBalBalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.BAL_A_TOKEN)
      .scaledBalanceOf(address(AaveV2Polygon.COLLECTOR));
    uint256 balBalanceAfter = IERC20(AaveV2PolygonAssets.BAL_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolBalBalanceAfter, 1 ether, 100);
    assertApproxEqAbs(amBalBalanceAfter, 1 ether, 100 ether);
    assertEq(balBalanceAfter, 0);

    uint256 aPolDaiBalanceAfter = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 amDaiBalanceAfter = IScaledBalanceToken(AaveV2PolygonAssets.DAI_A_TOKEN)
      .scaledBalanceOf(address(AaveV2Polygon.COLLECTOR));

    assertApproxEqAbs(aPolDaiBalanceAfter, 1 ether, 100);
    assertApproxEqAbs(amDaiBalanceAfter, 1 ether, 50_000 ether);

    uint256 aPolAaveBalanceAfter = IERC20(AaveV3PolygonAssets.AAVE_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 aaveBalanceAfter = IERC20(AaveV2PolygonAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    assertApproxEqAbs(aPolAaveBalanceAfter, 1 ether, 100);
    assertEq(aaveBalanceAfter, 0);

    uint256 aPolStMaticBalanceAfter = IERC20(AaveV3PolygonAssets.stMATIC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    assertApproxEqAbs(aPolStMaticBalanceAfter, 1 ether, 100);

    uint256 aPolDpiBalanceAfter = IERC20(AaveV3PolygonAssets.DPI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    assertApproxEqAbs(aPolDpiBalanceAfter, 1 ether, 100);

    uint256 aPolWstETHBalanceAfter = IERC20(AaveV3PolygonAssets.wstETH_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    assertApproxEqAbs(aPolWstETHBalanceAfter, 1 ether, 100);

    uint256 aPolCrvBalanceAfter = IERC20(AaveV3PolygonAssets.CRV_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 crvBalanceAfter = IERC20(AaveV2PolygonAssets.CRV_UNDERLYING).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    assertApproxEqAbs(aPolCrvBalanceAfter, 1 ether, 100);
    assertEq(crvBalanceAfter, 0);
  }

  function test_log() public {
    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 648521253002);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.BAL_UNDERLYING, 683004799480808939933);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.AAVE_UNDERLYING, 101681227989869315229);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.WETH_UNDERLYING, 104830293598652079048);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 1446713161783289887843910);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.CRV_UNDERLYING, 1480581377828400009883);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.stMATIC_UNDERLYING, 23770791828439896523298);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DPI_UNDERLYING, 36489599271785166247);

    vm.expectEmit(true, true, false, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.wstETH_UNDERLYING, 161373742235692428);
    executePayload(vm, address(proposal));
  }
}
