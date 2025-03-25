// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Scroll, AaveV3ScrollAssets} from 'aave-address-book/AaveV3Scroll.sol';

import {AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=scroll forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('scroll'), 14111144);
    proposal = new AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Scroll.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Scroll.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Scroll.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Scroll.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Scroll.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Scroll.POOL, address(AaveV3Scroll.ORACLE), AaveV3Scroll.DUST_BIN);
  }
}
