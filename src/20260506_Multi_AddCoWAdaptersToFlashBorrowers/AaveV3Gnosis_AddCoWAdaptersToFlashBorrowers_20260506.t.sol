// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506} from './AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506.sol';

/**
 * @dev Test for AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260506_Multi_AddCoWAdaptersToFlashBorrowers/AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506.t.sol -vv
 */
contract AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506_Test is ProtocolV3TestBase {
  AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 45935000);
    proposal = new AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_AddCoWAdaptersToFlashBorrowers_20260506',
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
