// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovernanceV3BNB} from 'aave-address-book/GovernanceV3BNB.sol';
import {AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320} from './AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320.sol';
import 'aave-helpers/adi/test/ADITestBase.sol';

/**
 * @dev Test for AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320
 * command: make test-contract filter=AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320
 */
contract AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320_Test is ADITestBase {
  AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320 public payload;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 37137492);
    payload = new AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320();
  }

  function test_defaultTest() public {
    defaultTest(
      'AaveV3BNB_HyperlaneBridgeAdapterUpdateToV3_20240320',
      GovernanceV3BNB.CROSS_CHAIN_CONTROLLER,
      address(payload),
      true
    );
  }
}
