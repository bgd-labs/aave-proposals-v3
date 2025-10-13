// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Linea, AaveV3LineaAssets} from 'aave-address-book/AaveV3Linea.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';

import {AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009} from './AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';

/**
 * @dev Test for AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251009_Multi_Slope2RiskOracleActivationOnCoreEthereumLinea/AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.t.sol -vv
 */
contract AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009_Test is
  ProtocolV3TestBase
{
  AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009 internal proposal;
  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;

  address public EDGE_INJECTOR_RATES;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('linea'), 24364832);
    proposal = new AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009();

    EDGE_INJECTOR_RATES = IRiskSteward(proposal.EDGE_RISK_STEWARD_RATES()).RISK_COUNCIL();
    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(EDGE_INJECTOR_RATES).RISK_ORACLE());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Linea_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009',
      AaveV3Linea.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Linea.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD_RATES()), true);
    assertEq(
      IRiskSteward(proposal.EDGE_RISK_STEWARD_RATES()).RISK_COUNCIL(),
      AaveV3Linea.EDGE_INJECTOR_RATES
    );
  }

  function test_configuredMarkets_injector() public {
    executePayload(vm, address(proposal));

    address[] memory configuredMarkets = IAaveStewardInjector(EDGE_INJECTOR_RATES).getMarkets();
    assertEq(configuredMarkets.length, 3);
    assertEq(configuredMarkets[0], AaveV3LineaAssets.WETH_UNDERLYING);
    assertEq(configuredMarkets[1], AaveV3LineaAssets.USDC_UNDERLYING);
    assertEq(configuredMarkets[2], AaveV3LineaAssets.USDT_UNDERLYING);
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    address rateStrategyAddress = AaveV3Linea
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3LineaAssets.WETH_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
        .getInterestRateDataBps(AaveV3LineaAssets.WETH_UNDERLYING);

    IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
      optimalUsageRatio: currentRate.optimalUsageRatio,
      baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
      variableRateSlope1: currentRate.variableRateSlope1,
      variableRateSlope2: currentRate.variableRateSlope2 + 4_00
    });

    _addUpdateToRiskOracle(newRate);

    (bool upkeepNeeded, bytes memory encodedPerformData) = AutomationCompatibleInterface(
      EDGE_INJECTOR_RATES
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    (bool status, ) = address(EDGE_INJECTOR_RATES).call(encodedPerformData);
    assertTrue(status);

    currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps(
      AaveV3LineaAssets.WETH_UNDERLYING
    );
    assertEq(newRate.optimalUsageRatio, currentRate.optimalUsageRatio);
    assertEq(newRate.baseVariableBorrowRate, currentRate.baseVariableBorrowRate);
    assertEq(newRate.variableRateSlope1, currentRate.variableRateSlope1);
    assertEq(newRate.variableRateSlope2, currentRate.variableRateSlope2);
  }

  function test_injectUpdateToProtocol_invalidRateUpdate() public {
    executePayload(vm, address(proposal));
    address rateStrategyAddress = AaveV3Linea
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3LineaAssets.WETH_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
        .getInterestRateDataBps(AaveV3LineaAssets.WETH_UNDERLYING);

    IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
      optimalUsageRatio: currentRate.optimalUsageRatio,
      baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
      variableRateSlope1: currentRate.variableRateSlope1,
      variableRateSlope2: currentRate.variableRateSlope2 + 4_01
    });

    _addUpdateToRiskOracle(newRate);

    (bool upkeepNeeded, bytes memory encodedPerformData) = AutomationCompatibleInterface(
      EDGE_INJECTOR_RATES
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    (bool status, ) = address(EDGE_INJECTOR_RATES).call(encodedPerformData);
    assertFalse(status);
  }

  function _addUpdateToRiskOracle(IEngine.InterestRateInputData memory rate) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encode(rate),
      'RateStrategyUpdate',
      address(AaveV3LineaAssets.WETH_UNDERLYING),
      'additionalData'
    );
    vm.stopPrank();
  }
}
