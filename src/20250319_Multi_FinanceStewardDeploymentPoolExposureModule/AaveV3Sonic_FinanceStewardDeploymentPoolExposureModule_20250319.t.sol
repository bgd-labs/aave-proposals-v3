// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Sonic, AaveV3SonicAssets} from 'aave-address-book/AaveV3Sonic.sol';

import {AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=sonic forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('sonic'), 14619228);
    proposal = new AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Sonic.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Sonic.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Sonic.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Sonic.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Sonic.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Sonic.POOL, address(AaveV3Sonic.ORACLE), AaveV3Sonic.DUST_BIN);
  }
}
