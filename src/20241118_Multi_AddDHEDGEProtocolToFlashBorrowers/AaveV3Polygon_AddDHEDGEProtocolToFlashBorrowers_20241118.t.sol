// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Polygon} from 'aave-address-book/AaveV3Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118} from './AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118.sol';
import {FlashBorrowersDataPolygon} from './FlashBorrowersData.sol';
/**
 * @dev Test for AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118
 * command: FOUNDRY_PROFILE=polygon forge test --match-path=src/20241118_Multi_AddDHEDGEProtocolToFlashBorrowers/AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118.t.sol -vv
 */
contract AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118_Test is ProtocolV3TestBase {
  AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 64447789);
    proposal = new AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Polygon_AddDHEDGEProtocolToFlashBorrowers_20241118',
      AaveV3Polygon.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory flashBorrowers = FlashBorrowersDataPolygon.getFlashBorrowers();
    for (uint i = 0; i < flashBorrowers.length; i++) {
      bool isFlashBorrower = AaveV3Polygon.ACL_MANAGER.isFlashBorrower(flashBorrowers[i]);
      assertEq(isFlashBorrower, true);
    }
  }
}
