// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Arbitrum} from 'aave-address-book/AaveV3Arbitrum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {GovernanceV3Arbitrum} from 'aave-address-book/GovernanceV3Arbitrum.sol';
import {ProtocolV3TestBase, GovV3Helpers} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';

import {AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130, IRangeValidationModule, IAaveCLRobotOperator} from './AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {ArbSys} from '../interfaces/ArbSys.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IBaseAaveAgent} from '../interfaces/IBaseAaveAgent.sol';
import {IAgentHub} from '../interfaces/IAgentHub.sol';

/**
 * @dev Test for AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol -vv
 */
contract AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130_Test is
  ProtocolV3TestBase
{
  AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 internal proposal;
  address public constant ARB_SYS = 0x0000000000000000000000000000000000000064;
  uint256 public constant AGENT_ID = 2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('arbitrum'), 428919624);
    proposal = new AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130();

    // https://github.com/foundry-rs/foundry/issues/5085
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockNumber.selector),
      abi.encode(428919624)
    );
    vm.mockCall(
      ARB_SYS,
      abi.encodeWithSelector(ArbSys.arbBlockHash.selector, 428919624 - 1),
      abi.encode(0xbe6f5dfa9ce3324bd677f5195ecd8d1a258cbf3800f24621d0e0d2724224704f)
    );
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Arbitrum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130',
      AaveV3Arbitrum.POOL,
      address(proposal)
    );
  }

  function test_agentsRegistered() public {
    uint256 oldAgentCount = IAgentHub(MiscArbitrum.AGENT_HUB).getAgentCount();
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentAgentCount = IAgentHub(MiscArbitrum.AGENT_HUB).getAgentCount();
    assertEq(AGENT_ID, currentAgentCount - 1);
    assertEq(currentAgentCount, oldAgentCount + 1);

    assertEq(IAgentHub(MiscArbitrum.AGENT_HUB).getUpdateType(AGENT_ID), 'RateStrategyUpdate');
  }

  function test_rangeValidationConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    IRangeValidationModule.RangeConfig memory slope2Config = IRangeValidationModule(
      MiscArbitrum.RANGE_VALIDATION_MODULE
    ).getDefaultRangeConfig(MiscArbitrum.AGENT_HUB, AGENT_ID, 'VariableRateSlope2');
    assertEq(slope2Config.maxIncrease, 4_00);
    assertEq(slope2Config.maxDecrease, 4_00);
    assertEq(slope2Config.isIncreaseRelative, false);
    assertEq(slope2Config.isDecreaseRelative, false);
  }

  function test_validateAgentContractImmutables() public virtual {
    GovV3Helpers.executePayload(vm, address(proposal));

    address agentContract = IAgentHub(MiscArbitrum.AGENT_HUB).getAgentAddress(AGENT_ID);
    assertEq(
      address(IBaseAaveAgent(agentContract).RANGE_VALIDATION_MODULE()),
      address(MiscArbitrum.RANGE_VALIDATION_MODULE)
    );
    assertEq(address(IBaseAaveAgent(agentContract).POOL()), address(AaveV3Arbitrum.POOL));
    assertEq(address(IBaseAaveAgent(agentContract).AGENT_HUB()), MiscArbitrum.AGENT_HUB);
  }

  function test_riskAdminRole() public {
    address agentContract = proposal.RATES_AGENT();
    assertFalse(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(agentContract));
    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(AaveV3Arbitrum.ACL_MANAGER.isRiskAdmin(agentContract));
  }

  function test_automationRegistered() public {
    vm.expectEmit(false, true, true, true, MiscArbitrum.AAVE_CL_ROBOT_OPERATOR);
    emit IAaveCLRobotOperator.KeeperRegistered(
      0,
      MiscArbitrum.AGENT_HUB_AUTOMATION,
      uint96(proposal.LINK_AMOUNT())
    );
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function test_injection_slope2() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory markets = proposal.getAssetsToEnableForRatesAgent();

    for (uint256 i = 0; i < markets.length && markets[i] != address(0); i++) {
      // push slope2 rate update
      address rateStrategyAddress = AaveV3Arbitrum
        .AAVE_PROTOCOL_DATA_PROVIDER
        .getInterestRateStrategyAddress(markets[i]);

      IDefaultInterestRateStrategyV2.InterestRateData
        memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
          .getInterestRateDataBps(markets[i]);

      IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
        optimalUsageRatio: currentRate.optimalUsageRatio,
        baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
        variableRateSlope1: currentRate.variableRateSlope1,
        variableRateSlope2: currentRate.variableRateSlope2 + 4_00 // 4% increase
      });

      vm.prank(0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9);
      IRiskOracle(AaveV3Arbitrum.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
        'referenceId',
        abi.encode(newRate),
        'RateStrategyUpdate',
        markets[i],
        'additionalData'
      );

      // check injection allowed
      assertTrue(_checkAndPerformAutomation());
    }
  }

  function test_injection_slope2_wrong_update() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory markets = proposal.getAssetsToEnableForRatesAgent();

    for (uint256 i = 0; i < markets.length && markets[i] != address(0); i++) {
      // push slope2 rate update
      address rateStrategyAddress = AaveV3Arbitrum
        .AAVE_PROTOCOL_DATA_PROVIDER
        .getInterestRateStrategyAddress(markets[i]);

      IDefaultInterestRateStrategyV2.InterestRateData
        memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
          .getInterestRateDataBps(markets[i]);

      IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
        optimalUsageRatio: currentRate.optimalUsageRatio,
        baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
        variableRateSlope1: currentRate.variableRateSlope1,
        variableRateSlope2: currentRate.variableRateSlope2 + 4_01 // 4.01% increase
      });

      vm.prank(0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9);
      IRiskOracle(AaveV3Arbitrum.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
        'referenceId',
        abi.encode(newRate),
        'RateStrategyUpdate',
        markets[i],
        'additionalData'
      );

      // check injection not allowed
      assertFalse(_checkAndPerformAutomation());
    }
  }

  function _checkAndPerformAutomation() public returns (bool) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = AGENT_ID;

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      MiscArbitrum.AGENT_HUB_AUTOMATION
    ).checkUpkeep(abi.encode(agentIds));

    if (upkeepNeeded) {
      AutomationCompatibleInterface(MiscArbitrum.AGENT_HUB_AUTOMATION).performUpkeep(performData);
    }
    return upkeepNeeded;
  }
}
