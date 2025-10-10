// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';

import {AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009} from './AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';

/**
 * @dev Test for AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251009_Multi_Slope2RiskOracleActivationOnCoreEthereumLinea/AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009.t.sol -vv
 */
contract AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009 internal proposal;
  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IRiskOracle public RISK_ORACLE;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 23546177);
    proposal = new AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009();

    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.EDGE_INJECTOR_RATES()).RISK_ORACLE());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_Slope2RiskOracleActivationOnCoreEthereumLinea_20251009',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD_RATES()), true);
    assertEq(
      IRiskSteward(proposal.EDGE_RISK_STEWARD_RATES()).RISK_COUNCIL(),
      proposal.EDGE_INJECTOR_RATES()
    );
  }

  function test_configuredMarkets_injector() public {
    executePayload(vm, address(proposal));

    address[] memory configuredMarkets = IAaveStewardInjector(proposal.EDGE_INJECTOR_RATES())
      .getMarkets();
    assertEq(configuredMarkets.length, 4);
    assertEq(configuredMarkets[0], AaveV3EthereumAssets.WETH_UNDERLYING);
    assertEq(configuredMarkets[1], AaveV3EthereumAssets.USDC_UNDERLYING);
    assertEq(configuredMarkets[2], AaveV3EthereumAssets.USDT_UNDERLYING);
    assertEq(configuredMarkets[3], AaveV3EthereumAssets.USDe_UNDERLYING);
  }

  function test_robotInjectorRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.EDGE_INJECTOR_RATES(),
      uint96(proposal.LINK_AMOUNT())
    );
    executePayload(vm, address(proposal));
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    address rateStrategyAddress = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3EthereumAssets.WETH_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
        .getInterestRateDataBps(AaveV3EthereumAssets.WETH_UNDERLYING);

    IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
      optimalUsageRatio: currentRate.optimalUsageRatio,
      baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
      variableRateSlope1: currentRate.variableRateSlope1,
      variableRateSlope2: currentRate.variableRateSlope2 + 4_00
    });

    _addUpdateToRiskOracle(newRate);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.EDGE_INJECTOR_RATES()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.EDGE_INJECTOR_RATES()).performUpkeep(performData);

    currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps(
      AaveV3EthereumAssets.WETH_UNDERLYING
    );
    assertEq(newRate.optimalUsageRatio, currentRate.optimalUsageRatio);
    assertEq(newRate.baseVariableBorrowRate, currentRate.baseVariableBorrowRate);
    assertEq(newRate.variableRateSlope1, currentRate.variableRateSlope1);
    assertEq(newRate.variableRateSlope2, currentRate.variableRateSlope2);
  }

  function test_injectUpdateToProtocol_invalidRateUpdate() public {
    executePayload(vm, address(proposal));
    address rateStrategyAddress = AaveV3Ethereum
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3EthereumAssets.WETH_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
        .getInterestRateDataBps(AaveV3EthereumAssets.WETH_UNDERLYING);

    IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
      optimalUsageRatio: currentRate.optimalUsageRatio,
      baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
      variableRateSlope1: currentRate.variableRateSlope1,
      variableRateSlope2: currentRate.variableRateSlope2 + 4_01
    });

    _addUpdateToRiskOracle(newRate);
    address injector = proposal.EDGE_INJECTOR_RATES();

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(injector)
      .checkUpkeep('');
    assertTrue(upkeepNeeded);

    vm.expectRevert(IRiskSteward.UpdateNotInRange.selector);
    AutomationCompatibleInterface(injector).performUpkeep(performData);
  }

  function _addUpdateToRiskOracle(IEngine.InterestRateInputData memory rate) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encode(rate),
      'RateStrategyUpdate',
      address(AaveV3EthereumAssets.WETH_UNDERLYING),
      'additionalData'
    );
    vm.stopPrank();
  }
}
