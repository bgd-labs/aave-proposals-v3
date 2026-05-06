// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506} from './AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506.sol';

/**
 * @dev Test for AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260506_Multi_AddCoWFactoriesToFlashBorrowers/AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506.t.sol -vv
 */
contract AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506_Test is ProtocolV3TestBase {
  AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 84734234);
    proposal = new AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_AddCoWFactoriesToFlashBorrowers_20260506',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Avalanche.ACL_MANAGER.isFlashBorrower(
      proposal.NEW_FLASH_BORROWER()
    );
    assertEq(isFlashBorrower, true);
  }
}
