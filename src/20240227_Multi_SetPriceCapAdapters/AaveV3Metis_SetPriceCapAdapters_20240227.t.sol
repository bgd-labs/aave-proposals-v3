// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {Payloads} from './SetPriceCapAdapters_20240227.s.sol';

/**
 * @dev Test for Metis payload
 * command: make test-contract filter=AaveV3Metis_SetPriceCapAdapters_20240304
 */
contract AaveV3Metis_SetPriceCapAdapters_20240304_Test is ProtocolV3TestBase {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 14600549);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Metis_SetPriceCapAdapters_20240304', AaveV3Metis.POOL, Payloads.METIS);
  }
}
