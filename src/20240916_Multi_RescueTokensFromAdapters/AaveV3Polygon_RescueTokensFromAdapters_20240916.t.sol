// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_RescueTokensFromAdapters_20240916} from './AaveV3Polygon_RescueTokensFromAdapters_20240916.sol';

/**
 * @dev Test for AaveV3Polygon_RescueTokensFromAdapters_20240916
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240916_Multi_RescueTokensFromAdapters/AaveV3Polygon_RescueTokensFromAdapters_20240916.t.sol -vv
 */
contract AaveV3Polygon_RescueTokensFromAdapters_20240916_Test is ProtocolV3TestBase {
  AaveV3Polygon_RescueTokensFromAdapters_20240916 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 61736283);
    proposal = new AaveV3Polygon_RescueTokensFromAdapters_20240916();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_RescueTokensFromAdapters_20240916',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
  function test_isTokensRescuedV3Previous() external {
    uint256 BALACLAdminInitialBalance = IERC20(AaveV3PolygonAssets.BAL_UNDERLYING).balanceOf(
      AaveV3Polygon.ACL_ADMIN
    );

    uint256 BALTransferred = IERC20(AaveV3PolygonAssets.BAL_UNDERLYING).balanceOf(
      proposal.ADAPTER_0()
    );

    GovV3Helpers.executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3PolygonAssets.BAL_UNDERLYING).balanceOf(proposal.ADAPTER_0()),
      0,
      'Unexpected BAL_UNDERLYING remaining'
    );
    assertEq(
      BALACLAdminInitialBalance + BALTransferred,
      IERC20(AaveV3PolygonAssets.BAL_UNDERLYING).balanceOf(AaveV3Polygon.ACL_ADMIN),
      'Unexpected BAL_UNDERLYING final treasury balance'
    );
  }
}
