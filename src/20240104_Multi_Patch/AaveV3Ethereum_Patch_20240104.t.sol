// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_Patch_20240104} from './AaveV3Ethereum_Patch_20240104.sol';

/**
 * @dev Test for AaveV3Ethereum_Patch_20240104
 * command: make test-contract filter=AaveV3Ethereum_Patch_20240104
 */
contract AaveV3Ethereum_Patch_20240104_Test is ProtocolV3TestBase {
  AaveV3Ethereum_Patch_20240104 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 18934274);
    proposal = new AaveV3Ethereum_Patch_20240104();
  }

  /**
   * @dev execution will fail because logic is not yet deployed
   */
  function testFail_defaultProposalExecution() public {
    executePayload(vm, address(proposal));
  }
}
