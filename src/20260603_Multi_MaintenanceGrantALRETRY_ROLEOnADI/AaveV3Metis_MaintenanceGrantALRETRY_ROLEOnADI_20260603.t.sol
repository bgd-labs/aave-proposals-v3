// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Metis} from 'aave-address-book/AaveV3Metis.sol';
import {GovernanceV3Metis} from 'aave-address-book/GovernanceV3Metis.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603} from './AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol';
import {MaintenanceGrantALRETRY_ROLEOnADITestBase, IRetryRoleProposal} from './MaintenanceGrantALRETRY_ROLEOnADITestBase.sol';

/**
 * @dev Test for AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol -vv
 */
/// forge-config: default.isolate = true
contract AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Test is
  MaintenanceGrantALRETRY_ROLEOnADITestBase
{
  function _createFork() internal override {
    vm.createSelectFork(vm.rpcUrl('metis'), 22769592);
  }

  function _deployProposal() internal override returns (IRetryRoleProposal) {
    return
      IRetryRoleProposal(address(new AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603()));
  }

  function _POOL() internal pure override returns (IPool) {
    return AaveV3Metis.POOL;
  }

  function _GRANULAR_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3Metis.GRANULAR_GUARDIAN;
  }

  function _CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Metis.CROSS_CHAIN_CONTROLLER;
  }

  function _GOVERNANCE_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3Metis.GOVERNANCE_GUARDIAN;
  }

  function _reportName() internal pure override returns (string memory) {
    return 'AaveV3Metis_MaintenanceGrantALRETRY_ROLEOnADI_20260603';
  }
}
