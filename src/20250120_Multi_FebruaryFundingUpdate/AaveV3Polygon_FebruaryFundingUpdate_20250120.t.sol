// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2Polygon, AaveV2PolygonAssets} from 'aave-address-book/AaveV2Polygon.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_FebruaryFundingUpdate_20250120} from './AaveV3Polygon_FebruaryFundingUpdate_20250120.sol';

/**
 * @dev Test for AaveV3Polygon_FebruaryFundingUpdate_20250120
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20250120_Multi_FebruaryFundingUpdate/AaveV3Polygon_FebruaryFundingUpdate_20250120.t.sol -vv
 */
contract AaveV3Polygon_FebruaryFundingUpdate_20250120_Test is ProtocolV3TestBase {
  AaveV3Polygon_FebruaryFundingUpdate_20250120 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 66938521);
    proposal = new AaveV3Polygon_FebruaryFundingUpdate_20250120();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_FebruaryFundingUpdate_20250120',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_withdraw() public {
    assertGt(
      IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether
    );
    assertGt(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1e6
    );

    executePayload(vm, address(proposal));

    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.WPOL_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1 ether,
      0.5 ether
    );
    assertApproxEqAbs(
      IERC20(AaveV2PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      1e6,
      2e6
    );
  }

  function test_deposit() public {
    uint256 balanceAAvaxWPOLBefore = IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 balanceAAvaxUSDTBefore = IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 balanceAAvaxWBTCBefore = IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );
    uint256 balanceAAvaxLINKBefore = IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(
      address(AaveV3Polygon.COLLECTOR)
    );

    executePayload(vm, address(proposal));

    assertGt(
      IERC20(AaveV3PolygonAssets.WPOL_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceAAvaxWPOLBefore
    );
    assertGt(
      IERC20(AaveV3PolygonAssets.USDT_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceAAvaxUSDTBefore
    );
    assertGt(
      IERC20(AaveV3PolygonAssets.WBTC_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceAAvaxWBTCBefore
    );
    assertGt(
      IERC20(AaveV3PolygonAssets.LINK_A_TOKEN).balanceOf(address(AaveV3Polygon.COLLECTOR)),
      balanceAAvaxLINKBefore
    );
  }
}
