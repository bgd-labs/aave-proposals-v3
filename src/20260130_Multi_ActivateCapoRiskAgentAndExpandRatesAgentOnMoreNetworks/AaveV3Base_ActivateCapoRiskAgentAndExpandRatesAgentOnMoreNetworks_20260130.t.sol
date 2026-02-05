// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base} from 'aave-address-book/AaveV3Base.sol';
import {MiscBase} from 'aave-address-book/MiscBase.sol';
import {GovernanceV3Base} from 'aave-address-book/GovernanceV3Base.sol';
import {ProtocolV3TestBase, GovV3Helpers} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130, IRangeValidationModule, IAaveCLRobotOperator} from './AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';

import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IBaseAaveAgent} from '../interfaces/IBaseAaveAgent.sol';
import {IAgentHub} from '../interfaces/IAgentHub.sol';

/**
 * @dev Test for AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol -vv
 */
contract AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130_Test is
  ProtocolV3TestBase
{
  AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 internal proposal;
  uint256 public constant AGENT_ID = 2;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 41495649);
    proposal = new AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130();

    // fund link manually TODO: remove later
    deal(proposal.LINK_TOKEN(), GovernanceV3Base.EXECUTOR_LVL_1, proposal.LINK_AMOUNT());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_agentsRegistered() public {
    uint256 oldAgentCount = IAgentHub(MiscBase.AGENT_HUB).getAgentCount();
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentAgentCount = IAgentHub(MiscBase.AGENT_HUB).getAgentCount();
    assertEq(AGENT_ID, currentAgentCount - 1);
    assertEq(currentAgentCount, oldAgentCount + 1);

    assertEq(IAgentHub(MiscBase.AGENT_HUB).getUpdateType(AGENT_ID), 'RateStrategyUpdate');
  }

  function test_rangeValidationConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    IRangeValidationModule.RangeConfig memory slope2Config = IRangeValidationModule(
      MiscBase.RANGE_VALIDATION_MODULE
    ).getDefaultRangeConfig(MiscBase.AGENT_HUB, AGENT_ID, 'VariableRateSlope2');
    assertEq(slope2Config.maxIncrease, 4_00);
    assertEq(slope2Config.maxDecrease, 4_00);
    assertEq(slope2Config.isIncreaseRelative, false);
    assertEq(slope2Config.isDecreaseRelative, false);
  }

  function test_validateAgentContractImmutables() public virtual {
    GovV3Helpers.executePayload(vm, address(proposal));

    address agentContract = IAgentHub(MiscBase.AGENT_HUB).getAgentAddress(AGENT_ID);
    assertEq(
      address(IBaseAaveAgent(agentContract).RANGE_VALIDATION_MODULE()),
      address(MiscBase.RANGE_VALIDATION_MODULE)
    );
    assertEq(address(IBaseAaveAgent(agentContract).POOL()), address(AaveV3Base.POOL));
    assertEq(address(IBaseAaveAgent(agentContract).AGENT_HUB()), MiscBase.AGENT_HUB);
  }

  function test_riskAdminRole() public {
    address agentContract = proposal.RATES_AGENT();
    assertFalse(AaveV3Base.ACL_MANAGER.isRiskAdmin(agentContract));
    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(AaveV3Base.ACL_MANAGER.isRiskAdmin(agentContract));
  }

  function test_automationRegistered() public {
    vm.expectEmit(false, true, true, true, MiscBase.AAVE_CL_ROBOT_OPERATOR);
    emit IAaveCLRobotOperator.KeeperRegistered(
      0,
      MiscBase.AGENT_HUB_AUTOMATION,
      uint96(proposal.LINK_AMOUNT())
    );
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function test_injection_slope2() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory markets = proposal.getAssetsToEnableForRatesAgent();

    for (uint256 i = 0; i < markets.length && markets[i] != address(0); i++) {
      // push slope2 rate update
      address rateStrategyAddress = AaveV3Base
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
      IRiskOracle(AaveV3Base.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
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
      address rateStrategyAddress = AaveV3Base
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
      IRiskOracle(AaveV3Base.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
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
      MiscBase.AGENT_HUB_AUTOMATION
    ).checkUpkeep(abi.encode(agentIds));

    if (upkeepNeeded) {
      AutomationCompatibleInterface(MiscBase.AGENT_HUB_AUTOMATION).performUpkeep(performData);
    }
    return upkeepNeeded;
  }
}
