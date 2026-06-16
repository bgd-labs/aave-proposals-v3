// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {GovernanceV3Ink} from 'aave-address-book/GovernanceV3Ink.sol';
import {IPool} from 'aave-address-book/AaveV3.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {Vm} from 'forge-std/Vm.sol';
import {AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603} from './AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603.sol';
import {MaintenanceGrantALRETRY_ROLEOnADITestBase, IRetryRoleProposal} from './MaintenanceGrantALRETRY_ROLEOnADITestBase.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260603_Multi_MaintenanceGrantALRETRY_ROLEOnADI/AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603.t.sol -vv
 */
contract AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603_Test is
  MaintenanceGrantALRETRY_ROLEOnADITestBase
{
  function _createFork() internal override {
    vm.createSelectFork(vm.rpcUrl('ink'), 48128811);
  }

  function _deployProposal() internal override returns (IRetryRoleProposal) {
    return
      IRetryRoleProposal(
        address(new AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603())
      );
  }

  function _POOL() internal pure override returns (IPool) {
    return AaveV3InkWhitelabel.POOL;
  }

  function _GRANULAR_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3Ink.GRANULAR_GUARDIAN;
  }

  function _CROSS_CHAIN_CONTROLLER() internal pure override returns (address) {
    return GovernanceV3Ink.CROSS_CHAIN_CONTROLLER;
  }

  function _GOVERNANCE_GUARDIAN() internal pure override returns (address) {
    return GovernanceV3Ink.GOVERNANCE_GUARDIAN;
  }

  function _reportName() internal pure override returns (string memory) {
    return 'AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603';
  }

  // This is an a.DI (chain-level) action: it is delivered to and executed by the Ink a.DI
  // PayloadsController (GovernanceV3Ink.PAYLOADS_CONTROLLER) - the same controller buildInkPayload and
  // test_role_grant use. defaultTest() otherwise derives the controller from the pool, which for the
  // InkWhitelabel pool is its own permissioned controller (a different executor, not the GranularGuardian
  // admin), so we override the execution hook to route through the a.DI controller.
  function executePayload(Vm, address payload, IPool) internal override {
    GovV3Helpers.executePayload(vm, payload, address(GovernanceV3Ink.PAYLOADS_CONTROLLER));
  }

  // e2e is disabled: the InkWhitelabel pool has paused reserves the harness cannot unpause.
  function test_defaultProposalExecution() public override {
    defaultTest({
      reportName: 'AaveV3InkWhitelabel_MaintenanceGrantALRETRY_ROLEOnADI_20260603',
      pool: AaveV3InkWhitelabel.POOL,
      payload: address(proposal),
      runE2E: false,
      runSeatbelt: true
    });
  }
}
