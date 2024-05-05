// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/test/ADITestBase.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320 internal payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('metis'), 16616814);
    payload = new AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Metis_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Metis.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
