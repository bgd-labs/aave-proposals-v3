// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004} from './AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004.sol';

/**
 * @dev Test for AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004.t.sol -vv
 */
contract AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004_Test is ProtocolV2TestBase {
  AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 62624232);
    proposal = new AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_ReserveFactorUpdatesMidOctober_20241004',
      AaveV2Polygon.POOL,
      address(proposal)
    );
  }
}
