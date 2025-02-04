// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128} from './AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128.sol';

/**
 * @dev Test for AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250128_Multi_WstETHBorrowRateUpdate/AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128.t.sol -vv
 */
contract AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 300154330);
    proposal = new AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_WstETHBorrowRateUpdate_20250128',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }
}
