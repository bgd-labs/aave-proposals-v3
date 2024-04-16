// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import 'aave-helpers/adi/test/ADITestBase.sol';
import {GovernanceV3Gnosis} from 'aave-address-book/GovernanceV3Gnosis.sol';
import {AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';

/**
 * @dev Test for AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 33457580);
    payload = new AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  function test_defaultTest() public {
    defaultTest(
      'AaveV3Gnosis_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3Gnosis.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
