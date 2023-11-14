// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';

/**
 * @dev Test for AaveV2Avalanche_AllowEmergencyAdminToFreeze
 * command: make test-contract filter=AaveV2Avalanche_AllowEmergencyAdminToFreeze_Test
 */
contract AaveV2Avalanche_AllowEmergencyAdminToFreeze_Test is ProtocolV2TestBase {
  address internal proposal = address(0x1AA25FdD7d55FA8a401D6EFba8e48874Ef730E55);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 37751305);
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest('AaveV2Avalanche_AllowEmergencyAdminToFreeze_Test', AaveV2Avalanche.POOL, address(proposal));
  }
}
