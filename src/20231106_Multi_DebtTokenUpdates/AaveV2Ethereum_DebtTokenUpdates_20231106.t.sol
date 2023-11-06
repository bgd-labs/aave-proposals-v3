// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_DebtTokenUpdates_20231106} from './AaveV2Ethereum_DebtTokenUpdates_20231106.sol';

/**
 * @dev Test for AaveV2Ethereum_DebtTokenUpdates_20231106
 * command: make test-contract filter=AaveV2Ethereum_DebtTokenUpdates_20231106
 */
contract AaveV2Ethereum_DebtTokenUpdates_20231106_Test is ProtocolV2TestBase {
  address internal proposal = address(0);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18514639);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Ethereum_DebtTokenUpdates_20231106', AaveV2Ethereum.POOL, address(proposal));
  }
}
