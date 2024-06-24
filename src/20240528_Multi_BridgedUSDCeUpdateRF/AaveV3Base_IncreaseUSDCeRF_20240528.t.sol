// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_IncreaseUSDCeRF_20240528} from './AaveV3Base_IncreaseUSDCeRF_20240528.sol';

/**
 * @dev Test for AaveV3Base_IncreaseUSDCeRF_20240528
 * command: FOUNDRY_PROFILE=base make test-contract filter=AaveV3Base_IncreaseUSDCeRF_20240528
 */
contract AaveV3Base_IncreaseUSDCeRF_20240528_Test is ProtocolV3TestBase {
  AaveV3Base_IncreaseUSDCeRF_20240528 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 15714463);
    proposal = new AaveV3Base_IncreaseUSDCeRF_20240528();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_IncreaseUSDCeRF_20240528', AaveV3Base.POOL, address(proposal));
  }
}
