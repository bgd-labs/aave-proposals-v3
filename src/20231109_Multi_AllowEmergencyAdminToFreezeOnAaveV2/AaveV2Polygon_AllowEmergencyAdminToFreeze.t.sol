// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Polygon_AllowEmergencyAdminToFreeze
 * command: make test-contract filter=AaveV2Polygon_AllowEmergencyAdminToFreeze_Test
 */
contract AaveV2Polygon_AllowEmergencyAdminToFreeze_Test is ProtocolV2TestBase {
  address internal proposal = address(0x1AA25FdD7d55FA8a401D6EFba8e48874Ef730E55);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 49968183);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Polygon_AllowEmergencyAdminToFreeze_Test', AaveV2Polygon.POOL, address(proposal));
  }
}
