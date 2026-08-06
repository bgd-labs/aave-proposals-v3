// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Scroll} from 'aave-address-book/AaveV3Scroll.sol';
import {GovernanceV3Scroll} from 'aave-address-book/GovernanceV3Scroll.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603} from './AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol';
import {MaintenanceGrantALRETRY_ROLEOnADITestBase, IRetryRoleProposal} from './MaintenanceGrantALRETRY_ROLEOnADITestBase.sol';

/**
 * @dev Test for AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol -vv
 */
/// forge-config: default.isolate = true
contract AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Test is
  MaintenanceGrantALRETRY_ROLEOnADITestBase
{
  function _createFork() internal override {
    vm.createSelectFork(vm.rpcUrl('scroll'), 34100777);
  }

  function _deployProposal() internal override returns (IRetryRoleProposal) {
    return
      IRetryRoleProposal(address(new AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603()));
  }

  function _POOL() internal pure override returns (IPool) {
    return AaveV3Scroll.POOL;
  }

  function _GRANULAR_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3Scroll.GRANULAR_GUARDIAN;
  }

  function _CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Scroll.CROSS_CHAIN_CONTROLLER;
  }

  function _GOVERNANCE_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3Scroll.GOVERNANCE_GUARDIAN;
  }

  function _reportName() internal pure override returns (string memory) {
    return 'AaveV3Scroll_MaintenanceGrantALRETRY_ROLEOnADI_20260603';
  }
}
