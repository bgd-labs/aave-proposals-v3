// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911} from './AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911.sol';

/**
 * @dev Test for AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20240911_Multi_AddAdapterAsFlashBorrowerAndRevokePrevious/AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911.t.sol -vv
 */
contract AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 252479788);
    proposal = new AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Arbitrum.ACL_MANAGER.isFlashBorrower(
      proposal.NEW_FLASH_BORROWER()
    );
    assertEq(isFlashBorrower, true);
  }
}
