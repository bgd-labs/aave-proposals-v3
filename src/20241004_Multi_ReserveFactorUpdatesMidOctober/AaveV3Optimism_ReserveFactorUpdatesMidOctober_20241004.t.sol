// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004} from './AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004.sol';

/**
 * @dev Test for AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004.t.sol -vv
 */
contract AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004_Test is ProtocolV3TestBase {
  AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 126486102);
    proposal = new AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_ReserveFactorUpdatesMidOctober_20241004',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
