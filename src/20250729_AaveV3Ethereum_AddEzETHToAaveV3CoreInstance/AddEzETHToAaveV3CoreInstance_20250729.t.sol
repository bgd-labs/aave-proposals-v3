// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AddEzETHToAaveV3CoreInstance_20250729} from './AddEzETHToAaveV3CoreInstance_20250729.sol';

/**
 * @dev Test for AddEzETHToAaveV3CoreInstance_20250729
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250729_AaveV3Ethereum_AddEzETHToAaveV3CoreInstance/AddEzETHToAaveV3CoreInstance_20250729.t.sol -vv
 */
contract AddEzETHToAaveV3CoreInstance_20250729_Test is ProtocolV3TestBase {
  AddEzETHToAaveV3CoreInstance_20250729 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23046232);
    proposal = new AddEzETHToAaveV3CoreInstance_20250729();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AddEzETHToAaveV3CoreInstance_20250729', AaveV3Ethereum.POOL, address(proposal));
  }
}
