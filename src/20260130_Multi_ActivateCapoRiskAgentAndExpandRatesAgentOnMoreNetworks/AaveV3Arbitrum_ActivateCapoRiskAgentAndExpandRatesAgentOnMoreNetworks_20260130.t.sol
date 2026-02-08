// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';

import {AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130} from './AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {ArbSys} from '../interfaces/ArbSys.sol';
import {BaseActivateRatesRiskAgentTest} from './BaseActivateRatesRiskAgentTest.t.sol';

/**
 * @dev Test for AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol -vv
 */
contract AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130_Test is
  BaseActivateRatesRiskAgentTest
{
  AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 internal proposal;
  address public constant ARB_SYS = 0x0000000000000000000000000000000000000064;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 429908766);
    proposal = new AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130();

    // https://github.com/foundry-rs/foundry/issues/5085
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockNumber.selector),
      abi.encode(429908766)
    );
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockHash.selector, 429908766 - 1),
      abi.encode(0xbe6f5dfa9ce3324bd677f5195ecd8d1a258cbf3800f24621d0e0d2724224704f)
    );
  }

  function _getConfig() internal view override returns (TestConfig memory) {
    return
      TestConfig({
        pool: AaveV3Arbitrum.POOL,
        aclManager: AaveV3Arbitrum.ACL_MANAGER,
        protocolDataProvider: AaveV3Arbitrum.AAVE_PROTOCOL_DATA_PROVIDER,
        agentHub: MiscArbitrum.AGENT_HUB,
        rangeValidationModule: MiscArbitrum.RANGE_VALIDATION_MODULE,
        agentHubAutomation: MiscArbitrum.AGENT_HUB_AUTOMATION,
        robotOperator: MiscArbitrum.AAVE_CL_ROBOT_OPERATOR,
        edgeRiskOracle: AaveV3Arbitrum.EDGE_RISK_ORACLE,
        proposal: address(proposal),
        riskAgent: proposal.RATES_AGENT(),
        linkAmount: proposal.LINK_AMOUNT(),
        assetsToEnable: proposal.getAllowedMarkets(),
        testName: 'AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130',
        agentId: 2,
        updateType: 'RateStrategyUpdate'
      });
  }
}
