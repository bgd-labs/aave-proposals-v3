// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IRootsConsumer} from './interfaces/IRootsConsumer.sol';
import {ProtocolV3TestBase} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422} from './AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';

/**
 * @dev Test for AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422
 * command: make test-contract filter=AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422
 */
contract AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422_Test is ProtocolV3TestBase {
  AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422 internal proposal;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  address public constant OLD_EXECUTION_CHAIN_ROBOT_ADDRESS =
    0x365d47ceD3D7Eb6a9bdB3814aA23cc06B2D33Ef8;
  address public constant OLD_VOTING_CHAIN_ROBOT_ADDRESS =
    0x2cf0fA5b36F0f89a5EA18F835d1375974a7720B8;
  address public constant OLD_GOVERNANCE_CHAIN_ROBOT_ADDRESS =
    0x011824f238AEE05329213d5Ae029e899e5412343;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 19917667);
    proposal = new AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_MigrateRobotsToChainlinkAutomationV2_20240422',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_oldKeepersCancelledAndNewRegistered() public {
    // validate robots cancelled
    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_GSM_SWAP_FREEZE_USDC_ROBOT_ID(),
      proposal.GSM_SWAP_FREEZE_USDC_ROBOT_ADDRESS()
    );

    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_GSM_SWAP_FREEZE_USDT_ROBOT_ID(),
      proposal.GSM_SWAP_FREEZE_USDT_ROBOT_ADDRESS()
    );

    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_EXECUTION_CHAIN_ROBOT_ID(),
      OLD_EXECUTION_CHAIN_ROBOT_ADDRESS
    );

    vm.expectEmit();
    emit KeeperCancelled(
      proposal.OLD_GOVERNANCE_CHAIN_ROBOT_ID(),
      OLD_GOVERNANCE_CHAIN_ROBOT_ADDRESS
    );

    vm.expectEmit();
    emit KeeperCancelled(proposal.OLD_VOTING_CHAIN_ROBOT_ID(), OLD_VOTING_CHAIN_ROBOT_ADDRESS);

    // validate robots registered
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.GAS_CAPPED_EXECUTION_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.EXECUTION_CHAIN_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.GAS_CAPPED_GOVERNANCE_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.GOVERNANCE_CHAIN_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.GAS_CAPPED_VOTING_CHAIN_ROBOT_ADDRESS(),
      uint96(proposal.VOTING_CHAIN_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.GSM_SWAP_FREEZE_USDC_ROBOT_ADDRESS(),
      uint96(proposal.GSM_SWAP_FREEZE_USDC_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.GSM_SWAP_FREEZE_USDT_ROBOT_ADDRESS(),
      uint96(proposal.GSM_SWAP_FREEZE_USDT_ROBOT_LINK_AMOUNT())
    );

    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.GAS_CAPPED_STATIC_A_TOKEN_ROBOT_ADDRESS(),
      uint96(proposal.STATIC_A_TOKEN_ROBOT_LINK_AMOUNT())
    );

    executePayload(vm, address(proposal));
  }

  function test_robotWhitelistedOnRootsConsumer() public {
    executePayload(vm, address(proposal));

    assertEq(
      IRootsConsumer(proposal.ROOTS_CONSUMER()).getRobotKeeper(),
      proposal.GAS_CAPPED_VOTING_CHAIN_ROBOT_ADDRESS()
    );
  }

  function test_crossChainControllerETHRefill() public {
    uint256 beforeBalance = GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER.balance;
    executePayload(vm, address(proposal));
    uint256 afterBalance = GovernanceV3Ethereum.CROSS_CHAIN_CONTROLLER.balance;

    assertEq(afterBalance - beforeBalance, proposal.CROSS_CHAIN_CONTROLLER_ETH_AMOUNT());
  }
}
