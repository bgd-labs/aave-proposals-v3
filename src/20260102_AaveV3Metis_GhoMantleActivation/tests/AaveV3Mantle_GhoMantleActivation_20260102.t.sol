// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Mantle} from 'aave-address-book/AaveV3Mantle.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Mantle_GhoMantleActivation_20260102} from '../AaveV3Mantle_GhoMantleActivation_20260102.sol';

/**
 * @dev Test for AaveV3Mantle_GhoMantleActivation_20260102
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260102_AaveV3Mantle_GhoMantleActivation/tests/AaveV3Mantle_GhoMantleActivation_20260102.t.sol -vv
 */
contract AaveV3Mantle_GhoMantleActivation_20260102_Test is ProtocolV3TestBase {
  AaveV3Mantle_GhoMantleActivation_20260102 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mantle'), 21902963);
    proposal = new AaveV3Mantle_GhoMantleActivation_20260102();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Mantle_GhoMantleActivation_20260102', AaveV3Mantle.POOL, address(proposal));
  }
}
