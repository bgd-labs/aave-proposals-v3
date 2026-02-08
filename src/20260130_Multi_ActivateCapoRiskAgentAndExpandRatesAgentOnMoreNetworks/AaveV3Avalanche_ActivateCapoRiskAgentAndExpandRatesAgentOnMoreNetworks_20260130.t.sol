// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Avalanche} from 'aave-address-book/AaveV3Avalanche.sol';
import {MiscAvalanche} from 'aave-address-book/MiscAvalanche.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IACLManager} from 'aave-v3-origin/contracts/interfaces/IACLManager.sol';
import {IPoolDataProvider} from 'aave-v3-origin/contracts/interfaces/IPoolDataProvider.sol';

import {AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130} from './AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {BaseActivateRatesRiskAgentTest} from './BaseActivateRatesRiskAgentTest.t.sol';

/**
 * @dev Test for AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol -vv
 */
contract AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130_Test is
  BaseActivateRatesRiskAgentTest
{
  AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 internal proposal;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('avalanche'), 76877281);
    proposal = new AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130();
  }

  function _getConfig() internal view override returns (TestConfig memory) {
    return
      TestConfig({
        pool: IPool(address(AaveV3Avalanche.POOL)),
        aclManager: IACLManager(address(AaveV3Avalanche.ACL_MANAGER)),
        protocolDataProvider: IPoolDataProvider(
          address(AaveV3Avalanche.AAVE_PROTOCOL_DATA_PROVIDER)
        ),
        agentHub: MiscAvalanche.AGENT_HUB,
        rangeValidationModule: MiscAvalanche.RANGE_VALIDATION_MODULE,
        agentHubAutomation: MiscAvalanche.AGENT_HUB_AUTOMATION,
        robotOperator: MiscAvalanche.AAVE_CL_ROBOT_OPERATOR,
        edgeRiskOracle: address(AaveV3Avalanche.EDGE_RISK_ORACLE),
        proposal: address(proposal),
        riskAgent: proposal.RATES_AGENT(),
        linkAmount: proposal.LINK_AMOUNT(),
        assetsToEnable: proposal.getAssetsToEnableForRatesAgent(),
        testName: 'AaveV3Avalanche_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130',
        agentId: 2,
        updateType: 'RateStrategyUpdate'
      });
  }
}
