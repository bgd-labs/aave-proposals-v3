// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_ReserveFactorUpdatesMidJuly_20240711} from './AaveV3Base_ReserveFactorUpdatesMidJuly_20240711.sol';

/**
 * @dev Test for AaveV3Base_ReserveFactorUpdatesMidJuly_20240711
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240711_Multi_ReserveFactorUpdatesMidJuly/AaveV3Base_ReserveFactorUpdatesMidJuly_20240711.t.sol -vv
 */
contract AaveV3Base_ReserveFactorUpdatesMidJuly_20240711_Test is ProtocolV3TestBase {
  AaveV3Base_ReserveFactorUpdatesMidJuly_20240711 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 18122554);
    proposal = new AaveV3Base_ReserveFactorUpdatesMidJuly_20240711();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_ReserveFactorUpdatesMidJuly_20240711',
      AaveV3Base.POOL,
      address(proposal)
    );
  }
}
