// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_ExtendAhabFunding_20251022} from './AaveV3Plasma_ExtendAhabFunding_20251022.sol';

/**
 * @dev Test for AaveV3Plasma_ExtendAhabFunding_20251022
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251022_Multi_ExtendAhabFunding/AaveV3Plasma_ExtendAhabFunding_20251022.t.sol -vv
 */
contract AaveV3Plasma_ExtendAhabFunding_20251022_Test is ProtocolV3TestBase {
  AaveV3Plasma_ExtendAhabFunding_20251022 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 4230876);
    proposal = new AaveV3Plasma_ExtendAhabFunding_20251022();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Plasma_ExtendAhabFunding_20251022', AaveV3Plasma.POOL, address(proposal));
  }
}
