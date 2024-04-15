// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_StablecoinIRUpdates_20240404} from './AaveV3Ethereum_StablecoinIRUpdates_20240404.sol';

/**
 * @dev Test for AaveV3Ethereum_StablecoinIRUpdates_20240404
 * command: make test-contract filter=AaveV3Ethereum_StablecoinIRUpdates_20240404
 */
contract AaveV3Ethereum_StablecoinIRUpdates_20240404_Test is ProtocolV3TestBase {
  AaveV3Ethereum_StablecoinIRUpdates_20240404 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19490783);
    proposal = new AaveV3Ethereum_StablecoinIRUpdates_20240404();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_StablecoinIRUpdates_20240404',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }
}
