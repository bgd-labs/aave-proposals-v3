// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3EthereumLido, AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {IRiskOracle} from './interfaces/IRiskOracle.sol';
import {IAaveStewardInjector} from './interfaces/IAaveStewardInjector.sol';
import {AutomationCompatibleInterface} from './interfaces/AutomationCompatibleInterface.sol';
import {AaveV3EthereumLido_AutomatedAGRSActivation_20241108} from './AaveV3EthereumLido_AutomatedAGRSActivation_20241108.sol';
import {IAaveV3ConfigEngine as IEngine} from 'aave-v3-origin/contracts/extensions/v3-config-engine/IAaveV3ConfigEngine.sol';
import {IDefaultInterestRateStrategyV2} from 'aave-v3-origin/contracts/interfaces/IDefaultInterestRateStrategyV2.sol';

/**
 * @dev Test for AaveV3EthereumLido_AutomatedAGRSActivation_20241108
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20241108_AaveV3EthereumLido_AutomatedAGRSActivation/AaveV3EthereumLido_AutomatedAGRSActivation_20241108.t.sol -vv
 */
contract AaveV3EthereumLido_AutomatedAGRSActivation_20241108_Test is ProtocolV3TestBase {
  AaveV3EthereumLido_AutomatedAGRSActivation_20241108 internal proposal;
  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IRiskOracle public RISK_ORACLE;

  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 21142784);
    proposal = new AaveV3EthereumLido_AutomatedAGRSActivation_20241108();
    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3EthereumLido_AutomatedAGRSActivation_20241108',
      AaveV3EthereumLido.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    executePayload(vm, address(proposal));

    assertEq(AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
    assertEq(
      IRiskSteward(proposal.EDGE_RISK_STEWARD()).RISK_COUNCIL(),
      proposal.AAVE_STEWARD_INJECTOR()
    );
  }

  function test_robotInjectorRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit KeeperRegistered(
      uint256(0),
      proposal.AAVE_STEWARD_INJECTOR(),
      uint96(proposal.LINK_AMOUNT())
    );
    executePayload(vm, address(proposal));
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    address rateStrategyAddress = AaveV3EthereumLido
      .AAVE_PROTOCOL_DATA_PROVIDER
      .getInterestRateStrategyAddress(AaveV3EthereumLidoAssets.WETH_UNDERLYING);

    IDefaultInterestRateStrategyV2.InterestRateData
      memory currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress)
        .getInterestRateDataBps(AaveV3EthereumLidoAssets.WETH_UNDERLYING);

    IEngine.InterestRateInputData memory newRate = IEngine.InterestRateInputData({
      optimalUsageRatio: currentRate.optimalUsageRatio + 3_00,
      baseVariableBorrowRate: currentRate.baseVariableBorrowRate,
      variableRateSlope1: currentRate.variableRateSlope1 + 50,
      variableRateSlope2: currentRate.variableRateSlope2 + 5_00
    });

    _addUpdateToRiskOracle(newRate);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);

    currentRate = IDefaultInterestRateStrategyV2(rateStrategyAddress).getInterestRateDataBps(
      AaveV3EthereumLidoAssets.WETH_UNDERLYING
    );
    assertEq(newRate.optimalUsageRatio, currentRate.optimalUsageRatio);
    assertEq(newRate.baseVariableBorrowRate, currentRate.baseVariableBorrowRate);
    assertEq(newRate.variableRateSlope1, currentRate.variableRateSlope1);
    assertEq(newRate.variableRateSlope2, currentRate.variableRateSlope2);
  }

  function _addUpdateToRiskOracle(IEngine.InterestRateInputData memory rate) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encode(rate),
      'RateStrategyUpdate',
      address(AaveV3EthereumLidoAssets.WETH_UNDERLYING),
      'additionalData'
    );
    vm.stopPrank();
  }
}
