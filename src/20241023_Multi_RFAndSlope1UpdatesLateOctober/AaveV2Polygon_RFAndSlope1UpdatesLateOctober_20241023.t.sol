// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023} from './AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023.sol';

/**
 * @dev Test for AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241023_Multi_RFAndSlope1UpdatesLateOctober/AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023.t.sol -vv
 */
contract AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023_Test is ProtocolV2TestBase {
  AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 63399906);
    proposal = new AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_RFAndSlope1UpdatesLateOctober_20241023',
      AaveV2Polygon.POOL,
      address(proposal)
    );
  }
}
