// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_AddFlashborrowers_20240306} from './AaveV3Ethereum_AddFlashborrowers_20240306.sol';

/**
 * @dev Test for AaveV3Ethereum_AddFlashborrowers_20240306
 * command: make test-contract filter=AaveV3Ethereum_AddFlashborrowers_20240306
 */
contract AaveV3Ethereum_AddFlashborrowers_20240306_Test is ProtocolV3TestBase {
  AaveV3Ethereum_AddFlashborrowers_20240306 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19377753);
    proposal = new AaveV3Ethereum_AddFlashborrowers_20240306();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_AddFlashborrowers_20240306',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_isFlashBorrower() external {
    GovV3Helpers.executePayload(vm, address(proposal));
    bool isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.CONTANGO_PROTOCOL());
    assertEq(isFlashBorrower, true);
    isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(
      proposal.INDEXCOOP_FLASHBORROWER()
    );
    assertEq(isFlashBorrower, true);
    isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.INDEXCOOP_ETHX2());
    assertEq(isFlashBorrower, true);
    isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.INDEXCOOP_BTCX2());
    assertEq(isFlashBorrower, true);
    isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.CIAN_PROTOCOL());
    assertEq(isFlashBorrower, true);
    isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.ALIGNED_PROTOCOL_1());
    assertEq(isFlashBorrower, true);
    isFlashBorrower = AaveV3Ethereum.ACL_MANAGER.isFlashBorrower(proposal.ALIGNED_PROTOCOL_2());
    assertEq(isFlashBorrower, true);
  }
}
