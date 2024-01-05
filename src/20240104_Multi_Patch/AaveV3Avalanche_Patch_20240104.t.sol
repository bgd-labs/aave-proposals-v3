// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_Patch_20240104} from './AaveV3Avalanche_Patch_20240104.sol';

/**
 * @dev Test for AaveV3Avalanche_Patch_20240104
 * command: make test-contract filter=AaveV3Avalanche_Patch_20240104
 */
contract AaveV3Avalanche_Patch_20240104_Test is ProtocolV3TestBase {
  AaveV3Avalanche_Patch_20240104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 39925983);
    proposal = new AaveV3Avalanche_Patch_20240104();
  }

  /**
   * @dev execution will fail because logic is not yet deployed
   */
  function testFail_defaultProposalExecution() public {
    executePayload(vm, address(proposal));
  }
}
