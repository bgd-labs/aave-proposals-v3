// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IInitializableAdminUpgradeabilityProxy} from 'src/interfaces/IInitializableAdminUpgradeabilityProxy.sol';
import {ILendToAaveMigrator} from 'src/interfaces/ILendToAaveMigrator.sol';
import {AaveV3Ethereum_LendMigrationShutdown_20260429} from './AaveV3Ethereum_LendMigrationShutdown_20260429.sol';

/**
 * @dev Test for AaveV3Ethereum_LendMigrationShutdown_20260429
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260429_AaveV3Ethereum_LendMigrationShutdown/AaveV3Ethereum_LendMigrationShutdown_20260429.t.sol -vv
 */
contract AaveV3Ethereum_LendMigrationShutdown_20260429_Test is ProtocolV3TestBase {
  IERC20 public constant AAVE = IERC20(AaveV2EthereumAssets.AAVE_UNDERLYING);
  address public constant ECOSYSTEM_RESERVE = MiscEthereum.ECOSYSTEM_RESERVE;

  address public constant LEND_TO_AAVE_MIGRATOR_PROXY = 0x317625234562B1526Ea2FaC4030Ea499C5291de4;
  address public immutable NEW_LEND_TO_AAVE_MIGRATOR_IMPL =
    0x2Da544ae1EA4E19b680E7A39520c64E5D35c0345;

  AaveV3Ethereum_LendMigrationShutdown_20260429 internal proposal;

  ILendToAaveMigrator internal migrator;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 25022080);
    proposal = new AaveV3Ethereum_LendMigrationShutdown_20260429();
    migrator = ILendToAaveMigrator(LEND_TO_AAVE_MIGRATOR_PROXY);
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
    uint256 preEcosystemReserveAaveBalance = AAVE.balanceOf(ECOSYSTEM_RESERVE);

    vm.expectEmit(address(migrator));
    emit ILendToAaveMigrator.AaveTokensRescued(
      address(migrator),
      ECOSYSTEM_RESERVE,
      preMigratorAaveBalance
    );
    executePayload(vm, address(proposal));

    assertEq(AAVE.balanceOf(proposal.LEND_TO_AAVE_MIGRATOR_PROXY()), 0);
    assertEq(
      AAVE.balanceOf(ECOSYSTEM_RESERVE),
      preEcosystemReserveAaveBalance + preMigratorAaveBalance
    );
  }

  function test_revision_updated() public {
    assertEq(IInitializableAdminUpgradeabilityProxy(address(migrator)).REVISION(), 2);

    executePayload(vm, address(proposal));

    assertEq(IInitializableAdminUpgradeabilityProxy(address(migrator)).REVISION(), 3);
  }

  function test_migration_shutdown() public {
    assertTrue(migrator.migrationStarted());

    executePayload(vm, address(proposal));

    assertTrue(migrator.migrationStarted());
    assertTrue(migrator.migrationEnded());

    vm.expectRevert(ILendToAaveMigrator.MigrationClosed.selector);
    migrator.migrateFromLEND(1);
  }

  function test_payload_immutables() public view {
    assertEq(proposal.LEND_TO_AAVE_MIGRATOR_IMPL(), NEW_LEND_TO_AAVE_MIGRATOR_IMPL);
    assertEq(proposal.LEND_TO_AAVE_MIGRATOR_PROXY(), LEND_TO_AAVE_MIGRATOR_PROXY);
  }
}
