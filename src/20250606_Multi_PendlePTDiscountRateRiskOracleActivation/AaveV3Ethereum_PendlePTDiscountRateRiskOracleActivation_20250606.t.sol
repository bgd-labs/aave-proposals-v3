// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606, IAaveCLRobotOperator} from './AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {IPendlePriceCapAdapter} from './interfaces/IPendlePriceCapAdapter.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IRiskSteward} from './interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';

/**
 * @dev Test for AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IPendlePriceCapAdapter public PT_ORACLE;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22774149);
    proposal = new AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606();

    PT_ORACLE = IPendlePriceCapAdapter(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(AaveV3EthereumAssets.PT_sUSDE_31JUL2025_UNDERLYING)
    );
    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()));
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.RISK_STEWARD));
    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()));
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.FREEZING_STEWARD));
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD));

    executePayload(vm, address(proposal));

    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()));
    assertEq(
      IRiskSteward(proposal.EDGE_RISK_STEWARD()).RISK_COUNCIL(),
      proposal.AAVE_STEWARD_INJECTOR()
    );
    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.RISK_STEWARD));
    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.NEW_RISK_STEWARD()));
    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.FREEZING_STEWARD));
    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD));
  }

  function test_steward_restricted() public {
    // GHO is restricted as the risk param for GHO should be updated by GHO steward
    assertFalse(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
    executePayload(vm, address(proposal));
    assertTrue(
      IRiskSteward(proposal.NEW_RISK_STEWARD()).isAddressRestricted(
        AaveV3EthereumAssets.GHO_UNDERLYING
      )
    );
  }

  function test_robotRegistered() public {
    vm.expectEmit(false, true, true, true);
    emit IAaveCLRobotOperator.KeeperRegistered(
      uint256(0),
      proposal.AAVE_STEWARD_INJECTOR(),
      uint96(proposal.LINK_AMOUNT())
    );
    executePayload(vm, address(proposal));
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    uint256 currentDiscountRate = PT_ORACLE.discountRatePerYear();
    uint256 discountRateToSet = currentDiscountRate + 0.01e18; // increase by 1% absolute value

    _addUpdateToRiskOracle(discountRateToSet);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);

    currentDiscountRate = PT_ORACLE.discountRatePerYear();
    assertEq(discountRateToSet, currentDiscountRate);
  }

  function test_injectorConfigurations() public view {
    address[] memory configuredMarkets = IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR())
      .getMarkets();

    address[] memory expectedMarkets = new address[](3);
    expectedMarkets[0] = AaveV3EthereumAssets.PT_sUSDE_31JUL2025_UNDERLYING;
    expectedMarkets[1] = AaveV3EthereumAssets.PT_USDe_31JUL2025_UNDERLYING;
    expectedMarkets[2] = AaveV3EthereumAssets.PT_eUSDE_14AUG2025_UNDERLYING;

    // all pendle pt assets listed are configured on the injector
    assertEq(configuredMarkets, expectedMarkets);

    string[] memory updateTypes = IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR())
      .getUpdateTypes();
    assertEq(updateTypes.length, 1);
    assertEq(updateTypes[0], 'PendleDiscountRateUpdate_Core');
  }

  function test_risk_steward_configurations() public view {
    IRiskSteward currentSteward = IRiskSteward(AaveV3Ethereum.RISK_STEWARD);
    IRiskSteward newSteward = IRiskSteward(proposal.NEW_RISK_STEWARD());

    IRiskSteward.Config memory oldConfig = currentSteward.getRiskConfig();
    IRiskSteward.Config memory newConfig = newSteward.getRiskConfig();

    // only maxPercentChange of discountRate changed from 5% to 2.5% rest all params are same
    assertEq(newConfig.priceCapConfig.discountRatePendle.maxPercentChange, 0.025e18);

    assertEq(
      oldConfig.priceCapConfig.discountRatePendle.minDelay,
      newConfig.priceCapConfig.discountRatePendle.minDelay
    );

    assertEq(oldConfig.collateralConfig.ltv.minDelay, newConfig.collateralConfig.ltv.minDelay);
    assertEq(
      oldConfig.collateralConfig.ltv.maxPercentChange,
      newConfig.collateralConfig.ltv.maxPercentChange
    );
    assertEq(
      oldConfig.collateralConfig.liquidationThreshold.minDelay,
      newConfig.collateralConfig.liquidationThreshold.minDelay
    );
    assertEq(
      oldConfig.collateralConfig.liquidationThreshold.maxPercentChange,
      newConfig.collateralConfig.liquidationThreshold.maxPercentChange
    );
    assertEq(
      oldConfig.collateralConfig.liquidationBonus.minDelay,
      newConfig.collateralConfig.liquidationBonus.minDelay
    );
    assertEq(
      oldConfig.collateralConfig.liquidationBonus.maxPercentChange,
      newConfig.collateralConfig.liquidationBonus.maxPercentChange
    );
    assertEq(
      oldConfig.collateralConfig.debtCeiling.minDelay,
      newConfig.collateralConfig.debtCeiling.minDelay
    );
    assertEq(
      oldConfig.collateralConfig.debtCeiling.maxPercentChange,
      newConfig.collateralConfig.debtCeiling.maxPercentChange
    );

    assertEq(
      oldConfig.rateConfig.baseVariableBorrowRate.minDelay,
      newConfig.rateConfig.baseVariableBorrowRate.minDelay
    );
    assertEq(
      oldConfig.rateConfig.baseVariableBorrowRate.maxPercentChange,
      newConfig.rateConfig.baseVariableBorrowRate.maxPercentChange
    );
    assertEq(
      oldConfig.rateConfig.variableRateSlope1.minDelay,
      newConfig.rateConfig.variableRateSlope1.minDelay
    );
    assertEq(
      oldConfig.rateConfig.variableRateSlope1.maxPercentChange,
      newConfig.rateConfig.variableRateSlope1.maxPercentChange
    );
    assertEq(
      oldConfig.rateConfig.variableRateSlope2.minDelay,
      newConfig.rateConfig.variableRateSlope2.minDelay
    );
    assertEq(
      oldConfig.rateConfig.variableRateSlope2.maxPercentChange,
      newConfig.rateConfig.variableRateSlope2.maxPercentChange
    );
    assertEq(
      oldConfig.rateConfig.optimalUsageRatio.minDelay,
      newConfig.rateConfig.optimalUsageRatio.minDelay
    );
    assertEq(
      oldConfig.rateConfig.optimalUsageRatio.maxPercentChange,
      newConfig.rateConfig.optimalUsageRatio.maxPercentChange
    );

    assertEq(oldConfig.capConfig.supplyCap.minDelay, newConfig.capConfig.supplyCap.minDelay);
    assertEq(
      oldConfig.capConfig.supplyCap.maxPercentChange,
      newConfig.capConfig.supplyCap.maxPercentChange
    );
    assertEq(oldConfig.capConfig.borrowCap.minDelay, newConfig.capConfig.borrowCap.minDelay);
    assertEq(
      oldConfig.capConfig.borrowCap.maxPercentChange,
      newConfig.capConfig.borrowCap.maxPercentChange
    );

    assertEq(
      oldConfig.priceCapConfig.priceCapLst.minDelay,
      newConfig.priceCapConfig.priceCapLst.minDelay
    );
    assertEq(
      oldConfig.priceCapConfig.priceCapLst.maxPercentChange,
      newConfig.priceCapConfig.priceCapLst.maxPercentChange
    );
    assertEq(
      oldConfig.priceCapConfig.priceCapStable.minDelay,
      newConfig.priceCapConfig.priceCapStable.minDelay
    );
    assertEq(
      oldConfig.priceCapConfig.priceCapStable.maxPercentChange,
      newConfig.priceCapConfig.priceCapStable.maxPercentChange
    );

    assertEq(oldConfig.eModeConfig.ltv.minDelay, newConfig.eModeConfig.ltv.minDelay);
    assertEq(
      oldConfig.eModeConfig.ltv.maxPercentChange,
      newConfig.eModeConfig.ltv.maxPercentChange
    );
    assertEq(
      oldConfig.eModeConfig.liquidationThreshold.minDelay,
      newConfig.eModeConfig.liquidationThreshold.minDelay
    );
    assertEq(
      oldConfig.eModeConfig.liquidationThreshold.maxPercentChange,
      newConfig.eModeConfig.liquidationThreshold.maxPercentChange
    );
    assertEq(
      oldConfig.eModeConfig.liquidationBonus.minDelay,
      newConfig.eModeConfig.liquidationBonus.minDelay
    );
    assertEq(
      oldConfig.eModeConfig.liquidationBonus.maxPercentChange,
      newConfig.eModeConfig.liquidationBonus.maxPercentChange
    );

    // validate immutables
    assertEq(address(currentSteward.CONFIG_ENGINE()), address(newSteward.CONFIG_ENGINE()));
    assertEq(address(currentSteward.RISK_COUNCIL()), address(newSteward.RISK_COUNCIL()));
    assertEq(address(currentSteward.POOL()), address(newSteward.POOL()));
  }

  function _addUpdateToRiskOracle(uint256 value) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value),
      'PendleDiscountRateUpdate_Core',
      address(AaveV3EthereumAssets.PT_sUSDE_31JUL2025_UNDERLYING),
      'additionalData'
    );
    vm.stopPrank();
  }
}
