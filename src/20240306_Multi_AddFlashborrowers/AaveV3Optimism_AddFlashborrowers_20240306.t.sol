// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_AddFlashborrowers_20240306} from './AaveV3Optimism_AddFlashborrowers_20240306.sol';

/**
 * @dev Test for AaveV3Optimism_AddFlashborrowers_20240306
 * command: make test-contract filter=AaveV3Optimism_AddFlashborrowers_20240306
 */
contract AaveV3Optimism_AddFlashborrowers_20240306_Test is ProtocolV3TestBase {
  AaveV3Optimism_AddFlashborrowers_20240306 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 117074480);
    proposal = new AaveV3Optimism_AddFlashborrowers_20240306();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_AddFlashborrowers_20240306',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Optimism.ACL_MANAGER.isFlashBorrower(proposal.CONTANGO_PROTOCOL());
    assertEq(isFlashBorrower, true);
  }
}
