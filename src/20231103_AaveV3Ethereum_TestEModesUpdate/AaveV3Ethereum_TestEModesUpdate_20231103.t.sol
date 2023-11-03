// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_TestEModesUpdate_20231103} from './AaveV3Ethereum_TestEModesUpdate_20231103.sol';

/**
 * @dev Test for AaveV3Ethereum_TestEModesUpdate_20231103
 * command: make test-contract filter=AaveV3Ethereum_TestEModesUpdate_20231103
 */
contract AaveV3Ethereum_TestEModesUpdate_20231103_Test is ProtocolV3TestBase {
  AaveV3Ethereum_TestEModesUpdate_20231103 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18490800);
    proposal = new AaveV3Ethereum_TestEModesUpdate_20231103();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_TestEModesUpdate_20231103', AaveV3Ethereum.POOL, address(proposal));
  }
}
