// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol';
import {AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';

/**
 * @dev Test for AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422
 * command: make test-contract filter=AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422
 */
contract AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422_Test is ProtocolV3TestBase {
  AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422 internal cancelRobotsProposal;
  AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422 internal proposal;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 45718364);
    proposal = new AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422();
    cancelRobotsProposal = new AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422();

    // execute the payload to cancel the robot and withraw link to collector
    executePayload(vm, address(cancelRobotsProposal));

    // after robot cancel we need to wait for some blocks to withdraw so we fast-forward
    vm.roll(block.number + 50);
    IAaveCLRobotOperator(cancelRobotsProposal.OLD_ROBOT_OPERATOR()).withdrawLink(
      cancelRobotsProposal.OLD_EXECUTION_CHAIN_ROBOT_ID()
    );
    IAaveCLRobotOperator(cancelRobotsProposal.OLD_ROBOT_OPERATOR()).withdrawLink(
      cancelRobotsProposal.OLD_VOTING_CHAIN_ROBOT_ID()
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_robotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.EXECUTION_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.EXECUTION_CHAIN_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.VOTING_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.VOTING_CHAIN_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.PROOF_OF_RESERVE_ROBOT_ADDRESS(),
      uint96(proposal.PROOF_OF_RESERVE_ROBOT_LINK_AMOUNT())
    );
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.PROOF_OF_RESERVE_ROBOT_ADDRESS(),
      uint96(proposal.PROOF_OF_RESERVE_ROBOT_LINK_AMOUNT())
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
