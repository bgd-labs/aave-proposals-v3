// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_StablecoinIRUpdates_20240424} from './AaveV3Optimism_StablecoinIRUpdates_20240424.sol';

/**
 * @dev Test for AaveV3Optimism_StablecoinIRUpdates_20240424
 * command: make test-contract filter=AaveV3Optimism_StablecoinIRUpdates_20240424
 */
contract AaveV3Optimism_StablecoinIRUpdates_20240424_Test is ProtocolV3TestBase {
  AaveV3Optimism_StablecoinIRUpdates_20240424 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 119190057);
    proposal = new AaveV3Optimism_StablecoinIRUpdates_20240424();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_StablecoinIRUpdates_20240424',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
