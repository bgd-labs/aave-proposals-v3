// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Optimism_ConfigurationMaintenance_20250519} from './AaveV3Optimism_ConfigurationMaintenance_20250519.sol';

/**
 * @dev Test for AaveV3Optimism_ConfigurationMaintenance_20250519
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250519_Multi_ConfigurationMaintenance/AaveV3Optimism_ConfigurationMaintenance_20250519.t.sol -vv
 */
contract AaveV3Optimism_ConfigurationMaintenance_20250519_Test is ProtocolV3TestBase {
  AaveV3Optimism_ConfigurationMaintenance_20250519 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 136029207);
    proposal = new AaveV3Optimism_ConfigurationMaintenance_20250519();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_ConfigurationMaintenance_20250519',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }
}
