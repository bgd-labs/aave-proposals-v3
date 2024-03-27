// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_ContangoFlashborrower_20240319} from './AaveV3Gnosis_ContangoFlashborrower_20240319.sol';

/**
 * @dev Test for AaveV3Gnosis_ContangoFlashborrower_20240319
 * command: make test-contract filter=AaveV3Gnosis_ContangoFlashborrower_20240319
 */
contract AaveV3Gnosis_ContangoFlashborrower_20240319_Test is ProtocolV3TestBase {
  AaveV3Gnosis_ContangoFlashborrower_20240319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 32999851);
    proposal = new AaveV3Gnosis_ContangoFlashborrower_20240319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_ContangoFlashborrower_20240319',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Gnosis.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
  }
}
