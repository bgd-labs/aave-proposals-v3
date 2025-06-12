// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis} from 'aave-address-book/AaveV3Gnosis.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_ConfigurationMaintenance_20250519} from './AaveV3Gnosis_ConfigurationMaintenance_20250519.sol';

/**
 * @dev Test for AaveV3Gnosis_ConfigurationMaintenance_20250519
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250519_Multi_ConfigurationMaintenance/AaveV3Gnosis_ConfigurationMaintenance_20250519.t.sol -vv
 */
contract AaveV3Gnosis_ConfigurationMaintenance_20250519_Test is ProtocolV3TestBase {
  AaveV3Gnosis_ConfigurationMaintenance_20250519 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 40141257);
    proposal = new AaveV3Gnosis_ConfigurationMaintenance_20250519();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_ConfigurationMaintenance_20250519',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }
}
