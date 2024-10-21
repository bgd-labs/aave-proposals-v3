// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004} from './AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004.sol';

/**
 * @dev Test for AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004
 * command: FOUNDRY_PROFILE=gnosis forge test --match-path=src/20241004_Multi_ReserveFactorUpdatesMidOctober/AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004.t.sol -vv
 */
contract AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004_Test is ProtocolV3TestBase {
  AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 36435033);
    proposal = new AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_ReserveFactorUpdatesMidOctober_20241004',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
