// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3MegaEth} from 'aave-address-book/AaveV3MegaEth.sol';
import {GovernanceV3MegaEth} from 'aave-address-book/GovernanceV3MegaEth.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2} from './AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.sol';
import {MaintenanceGrantALRETRY_ROLEOnADITestBase, IRetryRoleProposal} from '../20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/MaintenanceGrantALRETRY_ROLEOnADITestBase.sol';

/**
 * @dev Test for AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI_Part2/AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2.t.sol -vv
 */
/// forge-config: default.isolate = true
contract AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2_Test is
  MaintenanceGrantALRETRY_ROLEOnADITestBase
{
  function _createFork() internal override {
    vm.createSelectFork(vm.rpcUrl('megaeth'), 18827721);
  }

  function _deployProposal() internal override returns (IRetryRoleProposal) {
    return
      IRetryRoleProposal(
        address(new AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2())
      );
  }

  function _POOL() internal pure override returns (IPool) {
    return AaveV3MegaEth.POOL;
  }

  function _GRANULAR_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3MegaEth.GRANULAR_GUARDIAN;
  }

  function _CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3MegaEth.CROSS_CHAIN_CONTROLLER;
  }

  function _GOVERNANCE_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3MegaEth.GOVERNANCE_GUARDIAN;
  }

  function _reportName() internal pure override returns (string memory) {
    return 'AaveV3MegaEth_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Part2';
  }
}
