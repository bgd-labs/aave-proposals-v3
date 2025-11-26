// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV2Ethereum_WindingDownLendMigrationContract_20251126} from './AaveV2Ethereum_WindingDownLendMigrationContract_20251126.sol';
import {LendToAaveMigrator, IERC20} from './LendToAaveMigrator/src/contracts/LendToAaveMigrator.sol';

/**
 * @dev Test for AaveV2Ethereum_WindingDownLendMigrationContract_20251126
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251126_AaveV2Ethereum_WindingDownLendMigrationContract/AaveV2Ethereum_WindingDownLendMigrationContract_20251126.t.sol -vv
 */
contract AaveV2Ethereum_WindingDownLendMigrationContract_20251126_Test is ProtocolV3TestBase {
  AaveV2Ethereum_WindingDownLendMigrationContract_20251126 internal proposal;
  address public constant LEND_MIGARTION_CONTRACT = 0x317625234562B1526Ea2FaC4030Ea499C5291de4;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23881984);
    proposal = new AaveV2Ethereum_WindingDownLendMigrationContract_20251126();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Ethereum_WindingDownLendMigrationContract_20251126',
      AaveV3Ethereum.POOL,
      address(proposal),
      false,
      true
    );

    vm.warp(proposal.LEND_TO_AAVE_MIGRATOR_IMPLEMENTATION().MIGRATION_END_TIMESTAMP() + 1);

    vm.expectRevert(abi.encodeWithSelector(LendToAaveMigrator.MigrationFinished.selector));
    LendToAaveMigrator(LEND_MIGARTION_CONTRACT).migrateFromLEND(100);

    uint256 balanceBefore = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      LEND_MIGARTION_CONTRACT
    );
    uint256 balanceBeforeCollector = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    LendToAaveMigrator(proposal.LEND_MIGARTION_CONTRACT()).transferRemainingFundsToTreasury();
    uint256 balanceAfter = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      LEND_MIGARTION_CONTRACT
    );
    uint256 balanceAfterCollector = IERC20(AaveV3EthereumAssets.AAVE_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    assertNotEq(balanceBefore, 0);
    assertEq(balanceAfter, 0);
    assertEq(balanceAfterCollector - balanceBeforeCollector, balanceBefore);
  }
}
