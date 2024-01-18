// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';

import {StkGHO_Activation_20240118} from './StkGHO_Activation_20240118.sol';

/**
 * @dev Test for StkGHO_Activation_20240118
 * command: make test-contract filter=StkGHO_Activation_20240118
 */
contract StkGHO_Activation_20240118_Test is ProtocolV2TestBase {
  struct Changes {
    address asset;
    uint256 reserveFactor;
  }

  StkGHO_Activation_20240118 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ethereum'), 51940815);
    proposal = new StkGHO_Activation_20240118();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {

      
  }
}
