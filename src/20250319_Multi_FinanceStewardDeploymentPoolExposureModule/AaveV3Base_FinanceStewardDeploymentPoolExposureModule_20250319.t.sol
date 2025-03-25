// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';

import {AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 27797204);
    proposal = new AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Base.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Base.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Base.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Base.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Base.POOL, address(AaveV3Base.ORACLE), AaveV3Base.DUST_BIN);
  }
}
