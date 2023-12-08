// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {GovernanceV3Polygon} from 'aave-address-book/GovernanceV3Polygon.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {MiscPolygon} from 'aave-address-book/MiscPolygon.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon_AaveFundingUpdates_20231102} from './AaveV2Polygon_AaveFundingUpdates_20231102.sol';

/**
 * @dev Test for AaveV2Polygon_AaveFundingUpdates_20231102
 * command: make test-contract filter=AaveV2Polygon_AaveFundingUpdates_20231102
 */
contract AaveV2Polygon_AaveFundingUpdates_20231102_Test is ProtocolV2TestBase {
  event Bridge(address token, uint256 amount);

  AaveV2Polygon_AaveFundingUpdates_20231102 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 50216002);
    proposal = new AaveV2Polygon_AaveFundingUpdates_20231102();
  }

  function test_execute() public {
    uint256 usdcBalanceBefore = IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    uint256 usdtBalanceBefore = IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );
    uint256 daiBalanceBefore = IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(
      address(AaveV2Polygon.COLLECTOR)
    );

    vm.expectEmit(true, true, false, false, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV2PolygonAssets.USDC_UNDERLYING, proposal.USDC_TO_WITHDRAW());

    vm.expectEmit(true, true, false, false, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV2PolygonAssets.USDT_UNDERLYING, proposal.USDT_TO_WITHDRAW());

    vm.expectEmit(true, true, false, false, MiscPolygon.AAVE_POL_ETH_BRIDGE);
    emit Bridge(AaveV2PolygonAssets.DAI_UNDERLYING, proposal.DAI_TO_WITHDRAW());

    GovV3Helpers.executePayload(vm, address(proposal));

    assertApproxEqRel(
      IERC20(AaveV2PolygonAssets.USDC_A_TOKEN).balanceOf(address(AaveV2Polygon.COLLECTOR)),
      usdcBalanceBefore - proposal.USDC_TO_WITHDRAW(),
      0.001e18
    );
    assertApproxEqRel(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV2Polygon.COLLECTOR)),
      usdtBalanceBefore - proposal.USDT_TO_WITHDRAW(),
      0.001e18
    );
    assertApproxEqRel(
      IERC20(AaveV2PolygonAssets.DAI_A_TOKEN).balanceOf(address(AaveV2Polygon.COLLECTOR)),
      daiBalanceBefore - proposal.DAI_TO_WITHDRAW(),
      0.001e18
    );
  }
}
