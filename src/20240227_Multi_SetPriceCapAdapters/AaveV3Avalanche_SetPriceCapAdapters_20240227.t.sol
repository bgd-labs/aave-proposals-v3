// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './SetPriceCapAdapters_20240227.s.sol';

/**
 * @dev Test for Avalanche payload
 * command: make test-contract filter=AaveV3Avalanche_SetPriceCapAdapters_20240227
 */
contract AaveV3Avalanche_SetPriceCapAdapters_20240227_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 42802464);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_SetPriceCapAdapters_20240227',
      AaveV3Avalanche.POOL,
      Payloads.AVALANCHE
    );
  }
}
