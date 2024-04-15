// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/test/ADITestBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320 internal payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 13202337);
    payload = new AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Base.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
