// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IACLManager} from 'aave-v3-origin/contracts/interfaces/IACLManager.sol';
import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';
import {ProtocolV3TestBase, GovV3Helpers} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IAaveCLRobotOperator} from './AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IBaseAaveAgent} from '../interfaces/IBaseAaveAgent.sol';
import {IAgentHub} from '../interfaces/IAgentHub.sol';

/**
 * @dev Base test contract for agent activation tests
 * Provides common test logic shared across all networks
 */
abstract contract BaseActivateRiskAgentTest is ProtocolV3TestBase {
  struct TestConfig {
    IPool pool;
    IACLManager aclManager;
    IPoolDataProvider protocolDataProvider;
    address agentHub;
    address rangeValidationModule;
    address agentHubAutomation;
    address robotOperator;
    address edgeRiskOracle;
    address proposal;
    address riskAgent;
    uint256 linkAmount;
    address[] assetsToEnable;
    string testName;
    uint256 agentId;
    string updateType;
  }

  function _getConfig() internal view virtual returns (TestConfig memory);

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    TestConfig memory config = _getConfig();
    defaultTest(config.testName, config.pool, config.proposal);
  }

  function test_agentsRegistered() public {
    TestConfig memory config = _getConfig();
    uint256 oldAgentCount = IAgentHub(config.agentHub).getAgentCount();
    GovV3Helpers.executePayload(vm, config.proposal);

    uint256 currentAgentCount = IAgentHub(config.agentHub).getAgentCount();
    assertEq(config.agentId, currentAgentCount - 1);
    assertEq(currentAgentCount, oldAgentCount + 1);

    assertEq(IAgentHub(config.agentHub).getUpdateType(config.agentId), config.updateType);
  }

  function test_validateAgentContractImmutables() public virtual {
    TestConfig memory config = _getConfig();
    GovV3Helpers.executePayload(vm, config.proposal);

    address agentContract = IAgentHub(config.agentHub).getAgentAddress(config.agentId);
    assertEq(
      address(IBaseAaveAgent(agentContract).RANGE_VALIDATION_MODULE()),
      config.rangeValidationModule
    );
    assertEq(address(IBaseAaveAgent(agentContract).POOL()), address(config.pool));
    assertEq(address(IBaseAaveAgent(agentContract).AGENT_HUB()), config.agentHub);
  }

  function test_riskAdminRole() public virtual {
    TestConfig memory config = _getConfig();
    assertFalse(config.aclManager.isRiskAdmin(config.riskAgent));
    GovV3Helpers.executePayload(vm, config.proposal);

    assertTrue(config.aclManager.isRiskAdmin(config.riskAgent));
  }

  function test_automationRegistered() public {
    TestConfig memory config = _getConfig();
    vm.expectEmit(false, true, true, true, config.robotOperator);
    emit IAaveCLRobotOperator.KeeperRegistered(
      0,
      config.agentHubAutomation,
      uint96(config.linkAmount)
    );
    GovV3Helpers.executePayload(vm, config.proposal);
  }

  function _checkAndPerformAutomation(
    address agentHubAutomation,
    uint256 agentId
  ) internal returns (bool) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = agentId;

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      agentHubAutomation
    ).checkUpkeep(abi.encode(agentIds));

    if (upkeepNeeded) {
      AutomationCompatibleInterface(agentHubAutomation).performUpkeep(performData);
    }
    return upkeepNeeded;
  }
}
