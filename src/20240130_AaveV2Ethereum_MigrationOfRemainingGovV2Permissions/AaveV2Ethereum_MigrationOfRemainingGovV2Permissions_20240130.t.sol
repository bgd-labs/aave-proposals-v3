// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Ethereum} from 'aave-address-book/AaveV2Ethereum.sol';

import 'forge-std/Test.sol';
import {AaveGovernanceV2} from 'aave-address-book/AaveGovernanceV2.sol';
import {ProtocolV2TestBase, ReserveConfig} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130, IExecutor, AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130} from './AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.sol';

/**
 * @dev Test for AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130
 * command: make test-contract filter=AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130
 */
contract AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130_Test is ProtocolV2TestBase {
  AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130 internal proposal;
  AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130 internal proposalPart2;

  // maximum time between payload creation & execution
  uint256 estimatedExecutionDelay = 6 days; // 5 days + 1 day margin

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19119958);
    proposal = new AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130(
      address(0),
      block.timestamp +
        estimatedExecutionDelay +
        IExecutor(AaveGovernanceV2.SHORT_EXECUTOR).getDelay()
    );
    proposalPart2 = new AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_Part2_20240130(
      proposal
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    vm.warp(block.timestamp + estimatedExecutionDelay);
    executePayload(vm, address(proposal));
    vm.warp(block.timestamp + 1 days);
    executePayload(vm, address(proposalPart2));
  }
}
