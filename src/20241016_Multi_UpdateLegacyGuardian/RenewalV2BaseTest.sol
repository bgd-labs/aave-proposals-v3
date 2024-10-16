// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ILendingPoolAddressesProvider, ILendingPoolConfigurator} from 'aave-address-book/AaveV2.sol';
import 'forge-std/Test.sol';
import {ProtocolV2TestBase} from 'aave-helpers/src/ProtocolV2TestBase.sol';

struct GuardianUpdateTestParams {
  address proposal;
  address oldGuardian;
  address newGuardian;
  ILendingPoolAddressesProvider addressesProvider;
  ILendingPoolConfigurator poolConfigurator;
}

contract RenewalV2BaseTest is ProtocolV2TestBase {
  function _checkGuardianUpdate(GuardianUpdateTestParams memory params) internal {
    // check old guardian
    assertEq(params.addressesProvider.getEmergencyAdmin(), params.oldGuardian);
    // execute
    executePayload(vm, params.proposal);
    // check new guardian
    assertEq(params.addressesProvider.getEmergencyAdmin(), params.newGuardian);
    // check action
    vm.prank(params.newGuardian);
    params.poolConfigurator.setPoolPause(true);
  }
}
