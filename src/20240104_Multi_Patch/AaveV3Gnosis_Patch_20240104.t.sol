// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Generic_Patch_20240104_Test} from './AaveV3Generic_Patch_20240104_Test.sol';
import {AaveV3Gnosis_Patch_20240104} from './AaveV3Gnosis_Patch_20240104.sol';

/**
 * @dev Test for AaveV3Gnosis_Patch_20240104
 * command: make test-contract filter=AaveV3Gnosis_Patch_20240104
 */
contract AaveV3Gnosis_Patch_20240104_Test is AaveV3Generic_Patch_20240104_Test {
  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 31781458);
    proposal = address(new AaveV3Gnosis_Patch_20240104());
  }
}
