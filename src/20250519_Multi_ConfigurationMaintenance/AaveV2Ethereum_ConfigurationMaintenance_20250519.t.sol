// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_ConfigurationMaintenance_20250519} from './AaveV2Ethereum_ConfigurationMaintenance_20250519.sol';

/**
 * @dev Test for AaveV2Ethereum_ConfigurationMaintenance_20250519
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250519_Multi_ConfigurationMaintenance/AaveV2Ethereum_ConfigurationMaintenance_20250519.t.sol -vv
 */
contract AaveV2Ethereum_ConfigurationMaintenance_20250519_Test is ProtocolV2TestBase {
  AaveV2Ethereum_ConfigurationMaintenance_20250519 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22516931);
    proposal = new AaveV2Ethereum_ConfigurationMaintenance_20250519();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_ConfigurationMaintenance_20250519',
      AaveV2Ethereum.POOL,
      address(proposal)
    );
  }
}
