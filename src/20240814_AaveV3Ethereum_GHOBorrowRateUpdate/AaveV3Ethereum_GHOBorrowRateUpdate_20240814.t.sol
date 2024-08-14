// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_GHOBorrowRateUpdate_20240814} from './AaveV3Ethereum_GHOBorrowRateUpdate_20240814.sol';

/**
 * @dev Test for AaveV3Ethereum_GHOBorrowRateUpdate_20240814
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20240814_AaveV3Ethereum_GHOBorrowRateUpdate/AaveV3Ethereum_GHOBorrowRateUpdate_20240814.t.sol -vv
 */
contract AaveV3Ethereum_GHOBorrowRateUpdate_20240814_Test is ProtocolV3TestBase {
  AaveV3Ethereum_GHOBorrowRateUpdate_20240814 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 20526943);
    proposal = new AaveV3Ethereum_GHOBorrowRateUpdate_20240814();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_GHOBorrowRateUpdate_20240814',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
