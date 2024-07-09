// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IACLManager, IPoolConfigurator} from 'aave-address-book/AaveV3.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';

struct GuardianUpdateTestParams {
  address proposal;
  address oldGuardian;
  address newGuardian;
  IACLManager aclManager;
  IPoolConfigurator poolConfigurator;
}

contract RenewalV3BaseTest is ProtocolV3TestBase {
  function _checkGuardianUpdate(GuardianUpdateTestParams memory params) internal {
    // check old guardian
    assertTrue(params.aclManager.isEmergencyAdmin(params.oldGuardian));

    // execute
    executePayload(vm, params.proposal);

    // check guardian upate
    assertFalse(params.aclManager.isEmergencyAdmin(params.oldGuardian));
    assertTrue(params.aclManager.isEmergencyAdmin(params.newGuardian));

    // check action
    vm.prank(params.newGuardian);
    params.poolConfigurator.setPoolPause(true);
  }
}
