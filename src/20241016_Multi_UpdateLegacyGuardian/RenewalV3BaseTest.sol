// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
import {IACLManager, IPoolConfigurator} from 'aave-address-book/AaveV3.sol';
import 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IOwnableWithGuardian} from './interfaces/IOwnableWithGuardian.sol';
struct GuardianUpdateTestParams {
  address proposal;
  address oldGuardian;
  address protocolGuardian;
  address governanceGuardian;
  IACLManager aclManager;
  address governance;
  address payloadsController;
  IPoolConfigurator poolConfigurator;
}
contract RenewalV3BaseTest is ProtocolV3TestBase {
  event GuardianUpdated(address oldGuardian, address newGuardian);
  function _checkGuardianUpdate(GuardianUpdateTestParams memory params) internal {
    // check old protocol guardian
    assertTrue(params.aclManager.isEmergencyAdmin(params.oldGuardian));
    // check old governance guardian
    if (params.governance != address(0)) {
      assertEq(IOwnableWithGuardian(params.governance).guardian(), params.oldGuardian);
    }
    assertEq(IOwnableWithGuardian(params.payloadsController).guardian(), params.oldGuardian);
    // check governance gurdian update events
    if (params.governance != address(0)) {
      vm.expectEmit(true, true, false, false);
      emit GuardianUpdated(params.oldGuardian, params.governanceGuardian);
    }
    vm.expectEmit(true, true, false, false);
    emit GuardianUpdated(params.oldGuardian, params.governanceGuardian);
    // execute
    executePayload(vm, params.proposal);
    // check protocol guardian upate
    assertFalse(params.aclManager.isEmergencyAdmin(params.oldGuardian));
    assertTrue(params.aclManager.isEmergencyAdmin(params.protocolGuardian));
    // check action
    vm.startPrank(params.protocolGuardian);
    params.poolConfigurator.setPoolPause(true);
    vm.stopPrank();
    // check governance guardian update
    if (params.governance != address(0)) {
      assertEq(IOwnableWithGuardian(params.governance).guardian(), params.governanceGuardian);
    }
    assertEq(IOwnableWithGuardian(params.payloadsController).guardian(), params.governanceGuardian);
  }
}
