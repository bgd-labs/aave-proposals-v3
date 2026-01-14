// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Mantle_GhoMantleActivation_20260105} from '../AaveV3Mantle_GhoMantleActivation_20260105.sol';

/**
 * @dev Test for AaveV3Mantle_GhoMantleActivation_20260105
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260105_AaveV3Mantle_GhoMantleActivation/tests/AaveV3Mantle_GhoMantleActivation_20260105.t.sol -vv
 */
contract AaveV3Mantle_GhoMantleActivation_20260105_Test is ProtocolV3TestBase {
  AaveV3Mantle_GhoMantleActivation_20260105 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 90136862);
    proposal = new AaveV3Mantle_GhoMantleActivation_20260105();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Mantle_GhoMantleActivation_20260105', AaveV3Mantle.POOL, address(proposal));
  }
}
