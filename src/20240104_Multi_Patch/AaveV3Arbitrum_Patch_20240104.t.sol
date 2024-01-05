// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Arbitrum_Patch_20240104} from './AaveV3Arbitrum_Patch_20240104.sol';

/**
 * @dev Test for AaveV3Arbitrum_Patch_20240104
 * command: make test-contract filter=AaveV3Arbitrum_Patch_20240104
 */
contract AaveV3Arbitrum_Patch_20240104_Test is ProtocolV3TestBase {
  AaveV3Arbitrum_Patch_20240104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 167017329);
    proposal = new AaveV3Arbitrum_Patch_20240104();
  }

  /**
   * @dev execution will fail because logic is not yet deployed
   */
  function testFail_defaultProposalExecution() public {
    executePayload(vm, address(proposal));
  }
}
