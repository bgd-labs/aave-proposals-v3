// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';

import {AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=linea forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 17122442);
    proposal = new AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Linea.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Linea.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Linea.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Linea.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Linea.POOL, address(AaveV3Linea.ORACLE), AaveV3Linea.DUST_BIN);
  }
}
