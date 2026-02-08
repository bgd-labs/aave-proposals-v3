// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IACLManager} from 'aave-v3-origin/contracts/interfaces/IACLManager.sol';
import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';

import {AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130} from './AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {BaseActivateRatesRiskAgentTest} from './BaseActivateRatesRiskAgentTest.t.sol';

/**
 * @dev Test for AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol -vv
 */
contract AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130_Test is
  BaseActivateRatesRiskAgentTest
{
  AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 41495649);
    proposal = new AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130();

    // fund link manually TODO: remove later
    deal(proposal.LINK_TOKEN(), GovernanceV3Base.EXECUTOR_LVL_1, proposal.LINK_AMOUNT());
  }

  function _getConfig() internal view override returns (TestConfig memory) {
    return
      TestConfig({
        pool: IPool(address(AaveV3Base.POOL)),
        aclManager: IACLManager(address(AaveV3Base.ACL_MANAGER)),
        protocolDataProvider: IPoolDataProvider(address(AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER)),
        agentHub: MiscBase.AGENT_HUB,
        rangeValidationModule: MiscBase.RANGE_VALIDATION_MODULE,
        agentHubAutomation: MiscBase.AGENT_HUB_AUTOMATION,
        robotOperator: MiscBase.AAVE_CL_ROBOT_OPERATOR,
        edgeRiskOracle: address(AaveV3Base.EDGE_RISK_ORACLE),
        proposal: address(proposal),
        riskAgent: proposal.RATES_AGENT(),
        linkAmount: proposal.LINK_AMOUNT(),
        assetsToEnable: proposal.getAssetsToEnableForRatesAgent(),
        testName: 'AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130',
        agentId: 2,
        updateType: 'RateStrategyUpdate'
      });
  }
}
