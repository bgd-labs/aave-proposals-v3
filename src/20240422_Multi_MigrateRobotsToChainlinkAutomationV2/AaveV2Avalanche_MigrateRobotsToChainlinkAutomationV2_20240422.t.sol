// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Avalanche} from 'aave-address-book/AaveV2Avalanche.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422.sol';

/**
 * @dev Test for AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422
 * command: make test-contract filter=AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422
 */
contract AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422_Test is ProtocolV2TestBase {
  AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422 internal proposal;
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  address public constant OLD_EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x7B74938583Eb03e06042fcB651046BaF0bf15644;
  address public constant OLD_VOTING_CHAIN_ROBOT_ADDRESS =
    0x10E49034306EaA663646773C04b7B67E81eD0D52;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 44528432);
    proposal = new AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Avalanche_MigrateRobotsToChainlinkAutomationV2_20240422',
      AaveV2Avalanche.POOL,
      address(proposal)
    );
  }

  function test_keepersCancelled() public {
    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_EXECUTION_CHAIN_ROBOT_ID(),
      OLD_EXECUTION_CHAIN_ROBOT_ADDRESS
    );

    vm.expectEmit();
    emit KeeperCancelled(proposal.OLD_VOTING_CHAIN_ROBOT_ID(), OLD_VOTING_CHAIN_ROBOT_ADDRESS);

    executePayload(vm, address(proposal));
  }
}
