// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/test/ADITestBase.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320 internal payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 201314733);
    payload = new AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Arbitrum.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
