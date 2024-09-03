// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_ReserveFactorUpdatesLateAugust_20240821} from './AaveV3Base_ReserveFactorUpdatesLateAugust_20240821.sol';

/**
 * @dev Test for AaveV3Base_ReserveFactorUpdatesLateAugust_20240821
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20240821_Multi_ReserveFactorUpdatesLateAugust/AaveV3Base_ReserveFactorUpdatesLateAugust_20240821.t.sol -vv
 */
contract AaveV3Base_ReserveFactorUpdatesLateAugust_20240821_Test is ProtocolV3TestBase {
  AaveV3Base_ReserveFactorUpdatesLateAugust_20240821 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 18819884);
    proposal = new AaveV3Base_ReserveFactorUpdatesLateAugust_20240821();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_ReserveFactorUpdatesLateAugust_20240821',
      AaveV3Base.POOL,
      address(proposal)
    );
  }
}
