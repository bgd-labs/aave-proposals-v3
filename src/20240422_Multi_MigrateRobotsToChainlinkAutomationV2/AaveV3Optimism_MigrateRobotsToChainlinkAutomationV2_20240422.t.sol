// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Optimism} from 'aave-address-book/AaveV3Optimism.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422.sol';

/**
 * @dev Test for AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422
 * command: make test-contract filter=AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422
 */
contract AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422_Test is ProtocolV3TestBase {
  AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422 internal proposal;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('optimism'), 120310846);
    proposal = new AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Optimism_MigrateRobotsToChainlinkAutomationV2_20240422',
      AaveV3Optimism.POOL,
      address(proposal)
    );
  }

  function test_oldKeeperCancelledAndNewRegistered() public {
    // validate robots cancelled
    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_EXECUTION_CHAIN_ROBOT_ID(),
      proposal.EXECUTION_CHAIN_ROBOT_ADDRESS()
    );

    // validate robots registered
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.EXECUTION_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.EXECUTION_CHAIN_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.STATIC_A_TOKEN_ROBOT_ADDRESS(),
      uint96(proposal.STATIC_A_TOKEN_ROBOT_LINK_AMOUNT())
    );

    executePayload(vm, address(proposal));
  }
}
