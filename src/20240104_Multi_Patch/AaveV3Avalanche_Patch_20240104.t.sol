// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Generic_Patch_20240104_Test} from './AaveV3Generic_Patch_20240104_Test.sol';
import {AaveV3Avalanche_Patch_20240104} from './AaveV3Avalanche_Patch_20240104.sol';

/**
 * @dev Test for AaveV3Avalanche_Patch_20240104
 * command: make test-contract filter=AaveV3Avalanche_Patch_20240104
 */
contract AaveV3Avalanche_Patch_20240104_Test is AaveV3Generic_Patch_20240104_Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 39925983);
    proposal = address(new AaveV3Avalanche_Patch_20240104());
  }
}
