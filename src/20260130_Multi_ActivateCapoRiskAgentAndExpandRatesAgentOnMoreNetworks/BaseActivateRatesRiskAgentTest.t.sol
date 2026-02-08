// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {GovV3Helpers} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {IRangeValidationModule} from './AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {BaseActivateRiskAgentTest} from './BaseActivateRiskAgentTest.t.sol';

/**
 * @dev Base test contract for rates agent activation tests
 * Provides common test logic for Avalanche, Arbitrum, and Base networks
 * Extends BaseActivateRiskAgentTest with rates-specific tests
 */
abstract contract BaseActivateRatesRiskAgentTest is BaseActivateRiskAgentTest {
  function test_rangeValidationConfiguration() public {
    TestConfig memory config = _getConfig();
    GovV3Helpers.executePayload(vm, config.proposal);

    IRangeValidationModule.RangeConfig memory slope2Config = IRangeValidationModule(
      config.rangeValidationModule
    ).getDefaultRangeConfig(config.agentHub, config.agentId, 'VariableRateSlope2');
    assertEq(slope2Config.maxIncrease, 4_00);
    assertEq(slope2Config.maxDecrease, 4_00);
    assertEq(slope2Config.isIncreaseRelative, false);
    assertEq(slope2Config.isDecreaseRelative, false);
  }

  function test_injection_slope2() public {
    TestConfig memory config = _getConfig();
    GovV3Helpers.executePayload(vm, config.proposal);

    for (
      uint256 i = 0;
      i < config.assetsToEnable.length && config.assetsToEnable[i] != address(0);
      i++
    ) {
      address rateStrategyAddress = config.protocolDataProvider.getInterestRateStrategyAddress(
        config.assetsToEnable[i]
      );

      IDefaultInterestRateStrategyV2.InterestRateData
        memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
          .getInterestRateDataBps(config.assetsToEnable[i]);

      IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
        optimalUsageRatio: currentRate.optimalUsageRatio,
        baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
        variableRateSlope1: currentRate.variableRateSlope1,
        variableRateSlope2: currentRate.variableRateSlope2 + 4_00 // 4% increase
      });

      vm.prank(0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9);
      IRiskOracle(config.edgeRiskOracle).publishRiskParameterUpdate(
        'referenceId',
        abi.encode(newRate),
        'RateStrategyUpdate',
        config.assetsToEnable[i],
        'additionalData'
      );

      // check injection allowed
      assertTrue(_checkAndPerformAutomation(config.agentHubAutomation, config.agentId));
    }
  }

  function test_injection_slope2_wrong_update() public {
    TestConfig memory config = _getConfig();
    GovV3Helpers.executePayload(vm, config.proposal);

    for (
      uint256 i = 0;
      i < config.assetsToEnable.length && config.assetsToEnable[i] != address(0);
      i++
    ) {
      address rateStrategyAddress = config.protocolDataProvider.getInterestRateStrategyAddress(
        config.assetsToEnable[i]
      );

      IDefaultInterestRateStrategyV2.InterestRateData
        memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
          .getInterestRateDataBps(config.assetsToEnable[i]);

      IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
        optimalUsageRatio: currentRate.optimalUsageRatio,
        baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
        variableRateSlope1: currentRate.variableRateSlope1,
        variableRateSlope2: currentRate.variableRateSlope2 + 4_01 // 4.01% increase
      });

      vm.prank(0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9);
      IRiskOracle(config.edgeRiskOracle).publishRiskParameterUpdate(
        'referenceId',
        abi.encode(newRate),
        'RateStrategyUpdate',
        config.assetsToEnable[i],
        'additionalData'
      );

      // check injection not allowed
      assertFalse(_checkAndPerformAutomation(config.agentHubAutomation, config.agentId));
    }
  }
}
