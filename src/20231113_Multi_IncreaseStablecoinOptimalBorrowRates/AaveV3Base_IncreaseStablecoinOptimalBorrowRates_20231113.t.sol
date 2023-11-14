// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113} from './AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113.sol';

/**
 * @dev Test for AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113
 * command: make test-contract filter=AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113
 */
contract AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113_Test is ProtocolV3TestBase {
  AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 6580110);
    proposal = new AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_IncreaseStablecoinOptimalBorrowRates_20231113',
      AaveV3Base.POOL,
      address(proposal)
    );
  }
}
