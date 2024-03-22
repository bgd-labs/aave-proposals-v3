// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_StablecoinIRUpdates_20240322} from './AaveV3Gnosis_StablecoinIRUpdates_20240322.sol';

/**
 * @dev Test for AaveV3Gnosis_StablecoinIRUpdates_20240322
 * command: make test-contract filter=AaveV3Gnosis_StablecoinIRUpdates_20240322
 */
contract AaveV3Gnosis_StablecoinIRUpdates_20240322_Test is ProtocolV3TestBase {
  AaveV3Gnosis_StablecoinIRUpdates_20240322 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 33059799);
    proposal = new AaveV3Gnosis_StablecoinIRUpdates_20240322();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Gnosis_StablecoinIRUpdates_20240322', AaveV3Gnosis.POOL, address(proposal));
  }
}
