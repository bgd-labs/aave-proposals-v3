// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228} from './AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228.sol';

/**
 * @dev Test for AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20250228_AaveV3Polygon_AdjustAavePolygonV3RiskParameters/AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228.t.sol -vv
 */
contract AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228_Test is ProtocolV3TestBase {
  AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 68490896);
    proposal = new AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }
}
