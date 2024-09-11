// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911} from './AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911.sol';

/**
 * @dev Test for AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20240911_Multi_AddAdapterAsFlashBorrowerAndRevokePrevious/AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911.t.sol -vv
 */
contract AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911_Test is
  ProtocolV3TestBase
{
  AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 61703461);
    proposal = new AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AddAdapterAsFlashBorrowerAndRevokePrevious_20240911',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Polygon.ACL_MANAGER.isFlashBorrower(proposal.NEW_FLASH_BORROWER());
    assertEq(isFlashBorrower, true);
    bool isFlashBorrowerPrevious = AaveV3Polygon.ACL_MANAGER.isFlashBorrower(
      AaveV3Polygon.DEBT_SWAP_ADAPTER
    );
    assertEq(isFlashBorrowerPrevious, false);
  }
}
