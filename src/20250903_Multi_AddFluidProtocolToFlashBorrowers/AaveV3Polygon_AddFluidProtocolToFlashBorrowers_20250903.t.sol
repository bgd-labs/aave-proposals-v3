// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903} from './AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903.sol';

/**
 * @dev Test for AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250903_Multi_AddFluidProtocolToFlashBorrowers/AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903.t.sol -vv
 */
contract AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903_Test is ProtocolV3TestBase {
  AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 75989845);
    proposal = new AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    assertFalse(AaveV3Polygon.ACL_MANAGER.isFlashBorrower(proposal.FLUID_PROTOCOL()));
    GovV3Helpers.executePayload(vm, address(proposal));
    assertTrue(AaveV3Polygon.ACL_MANAGER.isFlashBorrower(proposal.FLUID_PROTOCOL()));
  }
}
