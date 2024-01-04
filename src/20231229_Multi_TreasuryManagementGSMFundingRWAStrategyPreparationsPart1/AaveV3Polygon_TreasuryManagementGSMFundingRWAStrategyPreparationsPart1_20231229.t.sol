// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229} from './AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229.sol';

/**
 * @dev Test for AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229
 * command: make test-contract filter=AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229
 */
contract AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229_Test is
  ProtocolV3TestBase
{
  event Bridge(address token, uint256 amount);

  AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 51933019);
    proposal = new AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229();
  }

  function test_execute() public {
    assertGt(
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    assertGt(
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );
    assertGt(
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0
    );

    vm.expectEmit(true, true, false, false, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 1);

    vm.expectEmit(true, true, false, false, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, 1);

    vm.expectEmit(true, true, false, false, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 1);

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      5e6,
      'aUSDC token greater than 0'
    );

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      5e6,
      'aUSDT token greater than 0'
    );

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      5 ether,
      'aDAI token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolUSDC token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolUSDT token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aPolDAI token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'USDC token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.USDT_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'USDT token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'DAI token greater than 0'
    );
  }
}
