// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_FluidAlignment_20241127} from './AaveV3Arbitrum_FluidAlignment_20241127.sol';

/**
 * @dev Test for AaveV3Arbitrum_FluidAlignment_20241127
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20241127_Multi_FluidAlignment/AaveV3Arbitrum_FluidAlignment_20241127.t.sol -vv
 */
contract AaveV3Arbitrum_FluidAlignment_20241127_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_FluidAlignment_20241127 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 278916313);
    proposal = new AaveV3Arbitrum_FluidAlignment_20241127();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Arbitrum_FluidAlignment_20241127', AaveV3Arbitrum.POOL, address(proposal));
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Arbitrum.ACL_MANAGER.isFlashBorrower(
      proposal.NEW_FLASH_BORROWER()
    );
    assertEq(isFlashBorrower, true);
  }
}
