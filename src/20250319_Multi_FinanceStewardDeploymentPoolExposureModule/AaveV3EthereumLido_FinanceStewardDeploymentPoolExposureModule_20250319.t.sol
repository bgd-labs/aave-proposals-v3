// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IAccessControl} from 'openzeppelin-contracts/contracts/access/IAccessControl.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';

import {AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319} from './AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319.sol';
import {BalanceChecker} from './BalanceChecker.sol';

/**
 * @dev Test for AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol -vv
 */
contract AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319_Test is
  BalanceChecker
{
  AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22080648);
    proposal = new AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_allReservesHaveEnoughBalanceOnDustBin() public {
    executePayload(vm, address(proposal));

    assertBalances(
      AaveV3EthereumLido.POOL,
      address(AaveV3EthereumLido.ORACLE),
      AaveV3EthereumLido.DUST_BIN
    );
  }
}
