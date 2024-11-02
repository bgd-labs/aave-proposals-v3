// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101} from './AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.sol';

/**
 * @dev Test for AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20241101_Multi_UpdatePriceCapAdaptersCAPO/AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101.t.sol -vv
 */
contract AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101_Test is ProtocolV3TestBase {
  AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 127431611);
    proposal = new AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_UpdatePriceCapAdaptersCAPO_20241101',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
