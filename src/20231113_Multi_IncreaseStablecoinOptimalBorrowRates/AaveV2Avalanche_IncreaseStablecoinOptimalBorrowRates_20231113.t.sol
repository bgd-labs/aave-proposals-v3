// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113} from './AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113.sol';

/**
 * @dev Test for AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113
 * command: make test-contract filter=AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113
 */
contract AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113_Test is ProtocolV2TestBase {
  AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37723337);
    proposal = new AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_IncreaseStablecoinOptimalBorrowRates_20231113',
      AaveV2Avalanche.POOL,
      address(proposal)
    );
  }
}
