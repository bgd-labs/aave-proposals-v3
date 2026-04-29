// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IInitializableAdminUpgradeabilityProxy} from 'src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {AaveV3Ethereum_LendMigrationShutdown_20260429} from './AaveV3Ethereum_LendMigrationShutdown_20260429.sol';

/**
 * @dev Test for AaveV3Ethereum_LendMigrationShutdown_20260429
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260429_AaveV3Ethereum_LendMigrationShutdown/AaveV3Ethereum_LendMigrationShutdown_20260429.t.sol -vv
 */
contract AaveV3Ethereum_LendMigrationShutdown_20260429_Test is ProtocolV3TestBase {
  IERC20 public constant AAVE = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING);
  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  AaveV3Ethereum_LendMigrationShutdown_20260429 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24985073);
    proposal = new AaveV3Ethereum_LendMigrationShutdown_20260429();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_LendMigrationShutdown_20260429',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_rescue_AAVE_balance() public {
    uint256 preMigratorAaveBalance = AAVE.balanceOf(proposal.LEND_TO_AAVE_MIGRATOR_PROXY());
    uint256 preCollectorAaveBalance = AAVE.balanceOf(COLLECTOR);

    executePayload(vm, address(proposal));

    assertEq(AAVE.balanceOf(proposal.LEND_TO_AAVE_MIGRATOR_PROXY()), 0);
    assertEq(AAVE.balanceOf(COLLECTOR), preCollectorAaveBalance + preMigratorAaveBalance);
  }
}
