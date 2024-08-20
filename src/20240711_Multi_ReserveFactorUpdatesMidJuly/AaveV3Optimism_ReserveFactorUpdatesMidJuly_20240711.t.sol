// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711} from './AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711.sol';

/**
 * @dev Test for AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20240711_Multi_ReserveFactorUpdatesMidJuly/AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711.t.sol -vv
 */
contract AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711_Test is ProtocolV3TestBase {
  AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 123717894);
    proposal = new AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_ReserveFactorUpdatesMidJuly_20240711',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
