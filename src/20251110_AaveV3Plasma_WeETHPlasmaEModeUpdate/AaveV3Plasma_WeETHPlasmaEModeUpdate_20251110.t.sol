// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110} from './AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110.sol';

/**
 * @dev Test for AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251110_AaveV3Plasma_WeETHPlasmaEModeUpdate/AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110.t.sol -vv
 */
contract AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110_Test is ProtocolV3TestBase {
  AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 5851943);
    proposal = new AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_WeETHPlasmaEModeUpdate_20251110',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }
}
