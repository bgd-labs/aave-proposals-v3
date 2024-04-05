// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_StablecoinIRUpdates_20240404} from './AaveV2Avalanche_StablecoinIRUpdates_20240404.sol';

/**
 * @dev Test for AaveV2Avalanche_StablecoinIRUpdates_20240404
 * command: make test-contract filter=AaveV2Avalanche_StablecoinIRUpdates_20240404
 */
contract AaveV2Avalanche_StablecoinIRUpdates_20240404_Test is ProtocolV2TestBase {
  AaveV2Avalanche_StablecoinIRUpdates_20240404 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 43233162);
    proposal = new AaveV2Avalanche_StablecoinIRUpdates_20240404();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_StablecoinIRUpdates_20240404',
      AaveV2Avalanche.POOL,
      address(proposal)
    );
  }
}
