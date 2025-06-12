// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3ZkSync} from 'aave-address-book/AaveV3ZkSync.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/zksync/src/ProtocolV3TestBase.sol';
import {AaveV3ZkSync_WstETHBorrowRateUpdate_20250128} from './AaveV3ZkSync_WstETHBorrowRateUpdate_20250128.sol';

/**
 * @dev Test for AaveV3ZkSync_WstETHBorrowRateUpdate_20250128
 * command: FOUNDRY_PROFILE=zksync forge test --zksync --match-path=zksync/src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3ZkSync_WstETHBorrowRateUpdate_20250128.t.sol -vv
 */
contract AaveV3ZkSync_WstETHBorrowRateUpdate_20250128_Test is ProtocolV3TestBase {
  AaveV3ZkSync_WstETHBorrowRateUpdate_20250128 internal proposal;

  function setUp() public override {
    vm.createSelectFork(vm.rpcUrl('zksync'), 54743911);
    proposal = new AaveV3ZkSync_WstETHBorrowRateUpdate_20250128();

    super.setUp();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3ZkSync_WstETHBorrowRateUpdate_20250128',
      AaveV3ZkSync.POOL,
      address(proposal)
    );
  }
}
