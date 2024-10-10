// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Base_IncreaseCbBTCSupplyCaps_20241004} from './AaveV3Base_IncreaseCbBTCSupplyCaps_20241004.sol';

/**
 * @dev Test for AaveV3Base_IncreaseCbBTCSupplyCaps_20241004
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20241004_Multi_IncreaseCbBTCSupplyCaps/AaveV3Base_IncreaseCbBTCSupplyCaps_20241004.t.sol -vv
 */
contract AaveV3Base_IncreaseCbBTCSupplyCaps_20241004_Test is ProtocolV3TestBase {
  AaveV3Base_IncreaseCbBTCSupplyCaps_20241004 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 20884619);
    proposal = new AaveV3Base_IncreaseCbBTCSupplyCaps_20241004();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Base_IncreaseCbBTCSupplyCaps_20241004', AaveV3Base.POOL, address(proposal));
  }
}
