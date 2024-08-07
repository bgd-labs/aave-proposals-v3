// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617.sol';
import {AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617} from './AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.sol';
import {IAaveCLRobotOperator} from './interfaces/IAaveCLRobotOperator.sol';
import {IProofOfReserveExecutor} from './interfaces/IProofOfReserveExecutor.sol';
import {AggregatorV3Interface} from './interfaces/AggregatorV3Interface.sol';

/**
 * @dev Test for AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617
 * command: FOUNDRY_PROFILE=avalanche forge test --match-path=src/20240617_AaveV3Avalanche_UpdatePoRExecutorV3Robot/AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617.t.sol -vv
 */
contract AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617_Test is ProtocolV3TestBase {
  AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617 internal cancelProposal;
  AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617 internal proposal;

  // CL Proof of Reserve feed
  address private constant PORF_AAVE = 0x14C4c668E34c09E1FBA823aD5DB47F60aeBDD4F7;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  event AssetIsNotBacked(address indexed asset);
  event EmergencyActionExecuted();

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 48662670);
    cancelProposal = new AaveV3Avalanche_UpdatePoRExecutorV3RobotCancel_20240617();
    proposal = new AaveV3Avalanche_UpdatePoRExecutorV3RobotRegister_20240617();

    // execute the payload to cancel the robot and withraw link to collector
    executePayload(vm, address(cancelProposal));

    // after robot cancel we need to wait for some blocks to withdraw so we fast-forward
    vm.roll(block.number + 50);
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

    assertTrue(AaveV3Avalanche.ACL_MANAGER.isRiskAdmin(proposal.PROOF_OF_RESERVE_EXECUTOR_V3()));
  }

  function test_executeEmergencyAction() public {
    // Arrange
    vm.mockCall(
      PORF_AAVE,
      abi.encodeWithSelector(AggregatorV3Interface.latestRoundData.selector),
      abi.encode(1, 99, 1, 1, 1)
    );

    IProofOfReserveExecutor executor = IProofOfReserveExecutor(
      proposal.PROOF_OF_RESERVE_EXECUTOR_V3()
    );

    // Act
    executePayload(vm, address(proposal));

    vm.expectEmit(true, false, false, true);
    emit AssetIsNotBacked(AaveV3AvalancheAssets.AAVEe_UNDERLYING);

    bool isEmergencyActionPossible = executor.isEmergencyActionPossible();
    assertEq(isEmergencyActionPossible, true);

    vm.expectEmit(false, false, false, true);
    emit EmergencyActionExecuted();

    executor.executeEmergencyAction();

    // Assert
    isEmergencyActionPossible = executor.isEmergencyActionPossible();

    assertEq(isEmergencyActionPossible, false);

    (, , , , , , , , , bool isFrozen) = AaveV3Avalanche
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getReserveConfigurationData(AaveV3AvalancheAssets.AAVEe_UNDERLYING);

    assertTrue(isFrozen);
  }
}
