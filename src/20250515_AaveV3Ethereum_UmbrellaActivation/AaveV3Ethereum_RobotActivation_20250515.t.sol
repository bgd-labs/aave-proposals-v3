// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum, AaveV3Ethereum_RobotActivation_20250515, IAaveCLRobotOperator} from './AaveV3Ethereum_RobotActivation_20250515.sol';

/**
 * @dev Test for AaveV3Ethereum_UmbrellaActivation_20250515
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250515_AaveV3Ethereum_UmbrellaActivation/AaveV3Ethereum_RobotActivation_20250515.t.sol -vv
 */
contract AaveV3Ethereum_RobotActivation_20250515_Test is ProtocolV3TestBase {
  AaveV3Ethereum_RobotActivation_20250515 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22581600);
    proposal = new AaveV3Ethereum_RobotActivation_20250515();
  }

  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_RobotActivation_20250515', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_newRobotsRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.SLASHING_ROBOT(),
      proposal.SLASHING_ROBOT_LINK_AMOUNT()
    );

    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.UMBRELLA_PPC_ROBOT(),
      proposal.UMBRELLA_PPC_ROBOT_LINK_AMOUNT()
    );

    executePayload(vm, address(proposal));
  }
}
