// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_IncreaseUSDCeRF_20240528} from './AaveV3Optimism_IncreaseUSDCeRF_20240528.sol';

/**
 * @dev Test for AaveV3Optimism_IncreaseUSDCeRF_20240528
 * command: make test-contract filter=AaveV3Optimism_IncreaseUSDCeRF_20240528
 */
contract AaveV3Optimism_IncreaseUSDCeRF_20240528_Test is ProtocolV3TestBase {
  AaveV3Optimism_IncreaseUSDCeRF_20240528 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 121307515);
    proposal = new AaveV3Optimism_IncreaseUSDCeRF_20240528();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Optimism_IncreaseUSDCeRF_20240528', AaveV3Optimism.POOL, address(proposal));
  }
}
