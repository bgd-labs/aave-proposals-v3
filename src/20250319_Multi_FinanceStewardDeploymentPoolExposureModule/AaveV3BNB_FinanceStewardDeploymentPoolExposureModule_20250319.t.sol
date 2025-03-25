// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';

import {AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=bnb forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 47600798);
    proposal = new AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3BNB.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3BNB.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3BNB.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3BNB.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3BNB.POOL, address(AaveV3BNB.ORACLE), AaveV3BNB.DUST_BIN);
  }
}
