// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_AddFlashBorrowers_20240906} from './AaveV3Optimism_AddFlashBorrowers_20240906.sol';

/**
 * @dev Test for AaveV3Optimism_AddFlashBorrowers_20240906
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240906_Multi_AddFlashBorrowers/AaveV3Optimism_AddFlashBorrowers_20240906.t.sol -vv
 */
contract AaveV3Optimism_AddFlashBorrowers_20240906_Test is ProtocolV3TestBase {
  AaveV3Optimism_AddFlashBorrowers_20240906 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 125018001);
    proposal = new AaveV3Optimism_AddFlashBorrowers_20240906();
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Optimism.ACL_MANAGER.isFlashBorrower(
      proposal.CIAN_FLASH_LOAN_HELPER()
    );
    assertEq(isFlashBorrower, true);
  }
}
