// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

contract AaveV3Generic_Patch_20240104_Test is ProtocolV3TestBase {
  address internal proposal;

  /**
   * @dev execution will fail because logic is not yet deployed
   */
  function testFail_defaultProposalExecution() public {
    require(proposal != address(0));
    executePayload(vm, proposal);
  }
}
