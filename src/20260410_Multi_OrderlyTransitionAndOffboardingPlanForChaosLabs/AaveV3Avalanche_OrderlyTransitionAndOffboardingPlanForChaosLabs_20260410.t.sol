// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410} from './AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.sol';
import {IAgentHub} from '../interfaces/chaos-agents/IAgentHub.sol';
import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IKeeperRegistry} from '../interfaces/IKeeperRegistry.sol';

/**
 * @dev Test for AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260410_Multi_OrderlyTransitionAndOffboardingPlanForChaosLabs/AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410.t.sol -vv
 */
contract AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410_Test is
  ProtocolV3TestBase
{
  AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 82595973);
    proposal = new AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Avalanche_OrderlyTransitionAndOffboardingPlanForChaosLabs_20260410',
      AaveV3Avalanche.POOL,
      address(proposal)
    );
  }

  function test_agentsDisabledAndRiskAdminRevoked() public {
    IAgentHub hub = IAgentHub(MiscAvalanche.AGENT_HUB);
    uint256 count = hub.getAgentCount();
    require(count > 0, 'no agents registered');

    executePayload(vm, address(proposal));

    for (uint256 i = 0; i < count; i++) {
      address agent = hub.getAgentAddress(i);
      assertFalse(hub.isAgentEnabled(i), 'agent still enabled');
      assertFalse(AaveV3Avalanche.ACL_MANAGER.isRiskAdmin(agent), 'agent still risk admin');
    }
  }

  function test_robotsCancelled() public {
    IAaveCLRobotOperator operator = IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR);
    uint256[] memory ids = operator.getKeepersList();

    uint256 agentHubRobotCount = 0;
    for (uint256 i = 0; i < ids.length; i++) {
      if (operator.getKeeperInfo(ids[i]).upkeep == MiscAvalanche.AGENT_HUB_AUTOMATION) {
        agentHubRobotCount++;
      }
    }
    require(agentHubRobotCount > 0, 'no agent hub robots found');

    vm.recordLogs();
    executePayload(vm, address(proposal));

    Vm.Log[] memory logs = vm.getRecordedLogs();
    uint256 cancelledCount = 0;
    bytes32 cancelledSig = keccak256('KeeperCancelled(uint256,address)');
    for (uint256 i = 0; i < logs.length; i++) {
      if (logs[i].topics[0] == cancelledSig) {
        cancelledCount++;
      }
    }

    assertEq(cancelledCount, agentHubRobotCount, 'not all agent hub robots cancelled');
  }

  function test_linkReturnedToCollectorAfterCancellation() public {
    address CHAINLINK_REGISTRY = 0x7f00a3Cd4590009C349192510D51F8e6312E08CB; // not in address book

    IAaveCLRobotOperator operator = IAaveCLRobotOperator(MiscAvalanche.AAVE_CL_ROBOT_OPERATOR);
    uint256[] memory ids = operator.getKeepersList();

    uint256[] memory agentRobotIds = new uint256[](ids.length);
    uint256 agentRobotCount = 0;
    for (uint256 i = 0; i < ids.length; i++) {
      if (operator.getKeeperInfo(ids[i]).upkeep == MiscAvalanche.AGENT_HUB_AUTOMATION) {
        agentRobotIds[agentRobotCount++] = ids[i];
      }
    }
    require(agentRobotCount > 0, 'no agent hub robots found');

    executePayload(vm, address(proposal));

    IKeeperRegistry registry = IKeeperRegistry(CHAINLINK_REGISTRY);
    uint256 delay = registry.getCancellationDelay();
    address link = registry.getLinkAddress();
    vm.roll(block.number + delay);

    uint256 collectorLinkBefore = IERC20(link).balanceOf(address(AaveV3Avalanche.COLLECTOR));

    for (uint256 i = 0; i < agentRobotCount; i++) {
      operator.withdrawLink(agentRobotIds[i]);
    }

    uint256 collectorLinkAfter = IERC20(link).balanceOf(address(AaveV3Avalanche.COLLECTOR));
    assertGt(collectorLinkAfter, collectorLinkBefore, 'LINK not returned to collector');
  }
}
