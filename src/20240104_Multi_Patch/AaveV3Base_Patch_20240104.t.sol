// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Base_Patch_20240104} from './AaveV3Base_Patch_20240104.sol';

/**
 * @dev Test for AaveV3Base_Patch_20240104
 * command: make test-contract filter=AaveV3Base_Patch_20240104
 */
contract AaveV3Base_Patch_20240104_Test is ProtocolV3TestBase {
  AaveV3Base_Patch_20240104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 8792857);
    proposal = new AaveV3Base_Patch_20240104();
  }

  /**
   * @dev execution will fail because logic is not yet deployed
   */
  function testFail_defaultProposalExecution() public {
    executePayload(vm, address(proposal));
  }
}
