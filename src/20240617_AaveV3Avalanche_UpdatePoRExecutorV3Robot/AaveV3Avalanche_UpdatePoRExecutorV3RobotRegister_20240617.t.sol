// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';

/**
 * @dev Test for AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.t.sol -vv
 */
contract AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617_Test is ProtocolV3TestBase {
  AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617 internal cancelProposal;
  AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617 internal proposal;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 48662670);
    cancelProposal = new AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617();
    proposal = new AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617();

    // execute the payload to cancel the robot and withraw link to collector
    executePayload(vm, address(cancelProposal));

    // after robot cancel we need to wait for some blocks to withdraw so we fast-forward
    vm.roll(block.number + 50);
    IAaveCLRobotOperator(cancelProposal.ROBOT_OPERATOR()).withdrawLink(
      cancelProposal.OLD_POR_ROBOT_ID()
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_robotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.PROOF_OF_RESERVE_ROBOT_ADDRESS(),
      uint96(proposal.LINK_AMOUNT())
    );

    executePayload(vm, address(proposal));
  }
}
