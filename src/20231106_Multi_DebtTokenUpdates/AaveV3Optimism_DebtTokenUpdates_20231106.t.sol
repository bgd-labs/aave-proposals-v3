// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';

/**
 * @dev Test for AaveV3Optimism_DebtTokenUpdates_20231106
 * command: make test-contract filter=AaveV3Optimism_DebtTokenUpdates_20231106
 */
contract AaveV3Optimism_DebtTokenUpdates_20231106_Test is ProtocolV3TestBase {
  address internal proposal = address(0x4B02E9A575DFf2783568cE3DFD354736388D813d);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 111851610);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Optimism_DebtTokenUpdates_20231106', AaveV3Optimism.POOL, address(proposal));
  }
}
