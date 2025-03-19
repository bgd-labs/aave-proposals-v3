// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea} from 'aave-address-book/AaveV3Linea.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319.sol';

/**
 * @dev Test for AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=linea forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319_Test is
  ProtocolV3TestBase
{
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
}
