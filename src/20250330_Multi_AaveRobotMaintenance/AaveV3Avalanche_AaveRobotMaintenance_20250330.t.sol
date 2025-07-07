// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {Test} from 'forge-std/Test.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';

import {IERC20, IAaveCLRobotOperator, AaveV3Avalanche_AaveRobotMaintenance_20250330} from './AaveV3Avalanche_AaveRobotMaintenance_20250330.sol';

/**
 * @dev Test for AaveV3Avalanche_AaveRobotMaintenance_20250330
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250330_Multi_AaveRobotMaintenance/AaveV3Avalanche_AaveRobotMaintenance_20250330.t.sol -vv
 */
contract AaveV3Avalanche_AaveRobotMaintenance_20250330_Test is ProtocolV3TestBase {
  AaveV3Avalanche_AaveRobotMaintenance_20250330 internal proposal;

  address public constant OLD_STATA_ROBOT_ADDRESS = 0x8aD3f00e91F0a3Ad8b0dF897c19EC345EaB761c4;
  address public constant OLD_VOTING_CHAIN_ROBOT_ADDRESS =
    0x10E49034306EaA663646773C04b7B67E81eD0D52;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 64922209);
    proposal = new AaveV3Avalanche_AaveRobotMaintenance_20250330();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_AaveRobotMaintenance_20250330',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_robotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.STATA_ROBOT(),
      proposal.STATA_ROBOT_LINK_AMOUNT()
    );

    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.VOTING_CHAIN_ROBOT(),
      uint96(proposal.VOTING_CHAIN_ROBOT_LINK_AMOUNT())
    );

    executePayload(vm, address(proposal));
  }

  function test_oldRobotsCancelled() public {
    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_STATA_ROBOT_ID(),
      OLD_STATA_ROBOT_ADDRESS
    );

    vm.expectEmit();
    emit IAaveCLRobotOperator.KeeperCancelled(
      proposal.OLD_VOTING_CHAIN_ROBOT_ID(),
      OLD_VOTING_CHAIN_ROBOT_ADDRESS
    );

    executePayload(vm, address(proposal));
  }

  function test_newRootsConsumerBalance() public {
    uint256 linkBalanceBefore = IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).balanceOf(
      proposal.OLD_ROOTS_CONSUMER()
    );
    assertEq(linkBalanceBefore, 100 ether);

    executePayload(vm, address(proposal));

    assertEq(
      IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING).balanceOf(proposal.ROOTS_CONSUMER()),
      linkBalanceBefore
    );
  }
}
