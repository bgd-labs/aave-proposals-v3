// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/test/ADITestBase.sol';
import {GovernanceV3Optimism} from 'aave-address-book/GovernanceV3Optimism.sol';
import {AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320 internal payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 118797852);
    payload = new AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Optimism.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
