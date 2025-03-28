// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Optimism, AaveV3OptimismAssets} from 'aave-address-book/AaveV3Optimism.sol';

import {AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=optimism forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 133392643);
    proposal = new AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Optimism.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Optimism.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Optimism.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Optimism.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Optimism.POOL, address(AaveV3Optimism.ORACLE), AaveV3Optimism.DUST_BIN);
  }
}
