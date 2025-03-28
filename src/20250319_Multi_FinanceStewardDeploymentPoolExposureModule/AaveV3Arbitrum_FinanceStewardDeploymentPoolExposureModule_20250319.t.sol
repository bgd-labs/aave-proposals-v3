// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';

import {AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=arbitrum forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319_Test is BalanceChecker {
  AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 319049030);
    proposal = new AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_accessGranted() public {
    assertFalse(
      IAccessControl(address(AaveV3Arbitrum.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Arbitrum.POOL_EXPOSURE_STEWARD
      )
    );

    executePayload(vm, address(proposal));

    assertTrue(
      IAccessControl(address(AaveV3Arbitrum.COLLECTOR)).hasRole(
        'FUNDS_ADMIN',
        AaveV3Arbitrum.POOL_EXPOSURE_STEWARD
      )
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(AaveV3Arbitrum.POOL, address(AaveV3Arbitrum.ORACLE), AaveV3Arbitrum.DUST_BIN);
  }
}
