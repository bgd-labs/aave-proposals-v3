// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV2Polygon} from 'aave-address-book/AaveV2Polygon.sol';
import {ProtocolV2TestBase} from 'aave-helpers/ProtocolV2TestBase.sol';
import {AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422.sol';

/**
 * @dev Test for AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422
 * command: make test-contract filter=AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422
 */
contract AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422_Test is ProtocolV2TestBase {
  AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422 internal proposal;
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  address public constant OLD_EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x249396a890F89D47F89326d7EE116b1d374Fb3A9;
  address public constant OLD_VOTING_CHAIN_ROBOT_ADDRESS =
    0xbe7998712402B6A63975515A532Ce503437998b7;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('polygon'), 56113527);
    proposal = new AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV2Polygon_MigrateRobotsToChainlinkAutomationV2_20240422',
      AaveV2Polygon.POOL,
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
