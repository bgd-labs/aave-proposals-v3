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
    vm.createSelectFork(vm.rpcUrl('polygon'), 52745691);
    proposal = new AaveV3Polygon_TreasuryManagementGSMFundingRWAStrategyPreparationsPart1_20231229();
  }

  function test_execute() public {
    assertGt(
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aUSDC not greater than 0'
    );
    assertGt(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aUSDT not greater than 0'
    );
    assertGt(
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'aDAI not greater than 0'
    );

    assertGt(
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'amPolUSDC not greater than 0'
    );
    assertGt(
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      0,
      'amPolUSDT not greater than 0'
    );

    uint256 balanceADaiV3Before = IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    assertGt(balanceADaiV3Before, 0, 'amPolDAI not greater than 0');

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDC_UNDERLYING, 3057435069425); // $3,057,435.069425

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.DAI_UNDERLYING, 1097534794305085978960689); // $1,097,534.794305085978960689

    vm.expectEmit(true, true, true, true, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV3PolygonAssets.USDT_UNDERLYING, 869442691714); // $869,442.691714

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      10e6,
      20e6,
      'aUSDC token greater than 0'
    );

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      10e6,
      5e6,
      'aUSDT token greater than 0'
    );

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      10e18,
      5 ether,
      'aDAI token greater than 0'
    );

    assertEq(
      IERC20(AaveV3PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      10e6,
      'amPolUSDC token greater than 0'
    );

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      10e6,
      1,
      'amPolUSDT token greater than 0'
    );

    assertApproxEqAbs(
      IERC20(AaveV3PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceADaiV3Before - proposal.AAVE_V3_DAI_TO_WITHDRAW(),
      1,
      'amPolDAI difference greater than 1'
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
