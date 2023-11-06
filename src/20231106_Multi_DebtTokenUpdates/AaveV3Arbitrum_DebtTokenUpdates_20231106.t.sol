// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

/**
 * @dev Test for AaveV3Arbitrum_DebtTokenUpdates_20231106
 * command: make test-contract filter=AaveV3Arbitrum_DebtTokenUpdates_20231106
 */
contract AaveV3Arbitrum_DebtTokenUpdates_20231106_Test is ProtocolV3TestBase {
  address internal proposal = address(0x625ac4fA12c13210D62348952D54201934194Fe2);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 147799320);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Arbitrum_DebtTokenUpdates_20231106', AaveV3Arbitrum.POOL, address(proposal));
  }
}
