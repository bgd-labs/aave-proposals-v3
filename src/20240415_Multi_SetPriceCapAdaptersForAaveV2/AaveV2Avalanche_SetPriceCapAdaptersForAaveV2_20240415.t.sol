// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {Payloads} from './SetPriceCapAdaptersForAaveV2_20240415.s.sol';

/**
 * @dev Test for AaveV2Avalanche_SetPriceCapAdaptersForAaveV2_20240415
 * command: make test-contract filter=AaveV2Avalanche_SetPriceCapAdaptersForAaveV2_20240415
 */
contract AaveV2Avalanche_SetPriceCapAdaptersForAaveV2_20240415_Test is ProtocolV2TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 44355072);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_SetPriceCapAdaptersForAaveV2_20240415',
      AaveV2Avalanche.POOL,
      Payloads.AVALANCHE
    );
  }
}
