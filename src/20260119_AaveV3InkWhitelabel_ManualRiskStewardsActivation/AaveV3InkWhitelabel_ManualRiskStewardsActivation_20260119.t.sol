// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3InkWhitelabel} from 'aave-address-book/AaveV3InkWhitelabel.sol';
import {GovernanceV3InkWhitelabel} from 'aave-address-book/GovernanceV3InkWhitelabel.sol';
import {IOwnable} from 'aave-address-book/common/IOwnable.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119} from './AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119.sol';

import {IRiskSteward} from '../interfaces/IRiskSteward.sol';

/**
 * @dev Test for AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260119_AaveV3InkWhitelabel_ManualRiskStewardsActivation/AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119.t.sol -vv
 */
contract AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119_Test is ProtocolV3TestBase {
  AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119 internal proposal;

  address public constant RISK_COUNCIL = 0xEcD37F855bB9814D75A83F0021815dc5cd6fd889;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('ink'), 35911234);
    proposal = new AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3InkWhitelabel_ManualRiskStewardsActivation_20260119',
      AaveV3InkWhitelabel.POOL,
      address(proposal),
      true,
      true
    );
  }

  function test_role() public {
    assertFalse(AaveV3InkWhitelabel.ACL_MANAGER.isRiskAdmin(proposal.RISK_STEWARD()));
    GovV3Helpers.executePayload(
      vm,
      address(proposal),
      address(GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER)
    );

    assertTrue(AaveV3InkWhitelabel.ACL_MANAGER.isRiskAdmin(proposal.RISK_STEWARD()));
  }

  function test_riskStewardConfigs() public view {
    assertEq(
      address(IRiskSteward(proposal.RISK_STEWARD()).POOL()),
      address(AaveV3InkWhitelabel.POOL)
    );
    assertEq(
      address(IRiskSteward(proposal.RISK_STEWARD()).CONFIG_ENGINE()),
      AaveV3InkWhitelabel.CONFIG_ENGINE
    );
    assertEq(address(IRiskSteward(proposal.RISK_STEWARD()).RISK_COUNCIL()), RISK_COUNCIL);
    assertEq(
      IOwnable(proposal.RISK_STEWARD()).owner(),
      GovernanceV3InkWhitelabel.PERMISSIONED_PAYLOADS_CONTROLLER_EXECUTOR
    );

    IRiskSteward.Config memory expectedConfig = IRiskSteward.Config({
      collateralConfig: IRiskSteward.CollateralConfig({
        ltv: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 50}),
        liquidationThreshold: IRiskSteward.RiskParamConfig({
          minDelay: 1 days,
          maxPercentChange: 50
        }),
        liquidationBonus: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 50}),
        debtCeiling: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 20_00})
      }),
      eModeConfig: IRiskSteward.EmodeConfig({
        ltv: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 50}),
        liquidationThreshold: IRiskSteward.RiskParamConfig({
          minDelay: 1 days,
          maxPercentChange: 10
        }),
        liquidationBonus: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 50})
      }),
      rateConfig: IRiskSteward.RateConfig({
        baseVariableBorrowRate: IRiskSteward.RiskParamConfig({
          minDelay: 1 days,
          maxPercentChange: 1_00
        }),
        variableRateSlope1: IRiskSteward.RiskParamConfig({
          minDelay: 1 days,
          maxPercentChange: 1_00
        }),
        variableRateSlope2: IRiskSteward.RiskParamConfig({
          minDelay: 1 days,
          maxPercentChange: 20_00
        }),
        optimalUsageRatio: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 3_00})
      }),
      capConfig: IRiskSteward.CapConfig({
        supplyCap: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 100_00}),
        borrowCap: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 100_00})
      }),
      priceCapConfig: IRiskSteward.PriceCapConfig({
        priceCapLst: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 5_00}),
        priceCapStable: IRiskSteward.RiskParamConfig({minDelay: 1 days, maxPercentChange: 50}),
        discountRatePendle: IRiskSteward.RiskParamConfig({
          minDelay: 2 days,
          maxPercentChange: 0.025e18
        })
      })
    });

    IRiskSteward.Config memory currentConfig = IRiskSteward(proposal.RISK_STEWARD())
      .getRiskConfig();
    _validateRiskConfig(expectedConfig, currentConfig);
  }

  function _validateRiskConfig(
    IRiskSteward.Config memory expectedConfig,
    IRiskSteward.Config memory currentRiskConfig
  ) internal pure {
    assertEq(
      expectedConfig.collateralConfig.ltv.minDelay,
      currentRiskConfig.collateralConfig.ltv.minDelay
    );
    assertEq(
      expectedConfig.collateralConfig.ltv.maxPercentChange,
      currentRiskConfig.collateralConfig.ltv.maxPercentChange
    );
    assertEq(
      expectedConfig.collateralConfig.liquidationThreshold.minDelay,
      currentRiskConfig.collateralConfig.liquidationThreshold.minDelay
    );
    assertEq(
      expectedConfig.collateralConfig.liquidationThreshold.maxPercentChange,
      currentRiskConfig.collateralConfig.liquidationThreshold.maxPercentChange
    );
    assertEq(
      expectedConfig.collateralConfig.liquidationBonus.minDelay,
      currentRiskConfig.collateralConfig.liquidationBonus.minDelay
    );
    assertEq(
      expectedConfig.collateralConfig.liquidationBonus.maxPercentChange,
      currentRiskConfig.collateralConfig.liquidationBonus.maxPercentChange
    );
    assertEq(
      expectedConfig.capConfig.supplyCap.minDelay,
      currentRiskConfig.capConfig.supplyCap.minDelay
    );
    assertEq(
      expectedConfig.capConfig.supplyCap.maxPercentChange,
      currentRiskConfig.capConfig.supplyCap.maxPercentChange
    );
    assertEq(
      expectedConfig.capConfig.borrowCap.minDelay,
      currentRiskConfig.capConfig.borrowCap.minDelay
    );
    assertEq(
      expectedConfig.capConfig.borrowCap.maxPercentChange,
      currentRiskConfig.capConfig.borrowCap.maxPercentChange
    );
    assertEq(
      expectedConfig.collateralConfig.debtCeiling.minDelay,
      currentRiskConfig.collateralConfig.debtCeiling.minDelay
    );
    assertEq(
      expectedConfig.collateralConfig.debtCeiling.maxPercentChange,
      currentRiskConfig.collateralConfig.debtCeiling.maxPercentChange
    );
    assertEq(
      expectedConfig.rateConfig.baseVariableBorrowRate.minDelay,
      currentRiskConfig.rateConfig.baseVariableBorrowRate.minDelay
    );
    assertEq(
      expectedConfig.rateConfig.baseVariableBorrowRate.maxPercentChange,
      currentRiskConfig.rateConfig.baseVariableBorrowRate.maxPercentChange
    );
    assertEq(
      expectedConfig.rateConfig.variableRateSlope1.minDelay,
      currentRiskConfig.rateConfig.variableRateSlope1.minDelay
    );
    assertEq(
      expectedConfig.rateConfig.variableRateSlope1.maxPercentChange,
      currentRiskConfig.rateConfig.variableRateSlope1.maxPercentChange
    );
    assertEq(
      expectedConfig.rateConfig.variableRateSlope2.minDelay,
      currentRiskConfig.rateConfig.variableRateSlope2.minDelay
    );
    assertEq(
      expectedConfig.rateConfig.variableRateSlope2.maxPercentChange,
      currentRiskConfig.rateConfig.variableRateSlope2.maxPercentChange
    );
    assertEq(
      expectedConfig.rateConfig.optimalUsageRatio.minDelay,
      currentRiskConfig.rateConfig.optimalUsageRatio.minDelay
    );
    assertEq(
      expectedConfig.rateConfig.optimalUsageRatio.maxPercentChange,
      currentRiskConfig.rateConfig.optimalUsageRatio.maxPercentChange
    );
    assertEq(
      expectedConfig.priceCapConfig.priceCapLst.maxPercentChange,
      currentRiskConfig.priceCapConfig.priceCapLst.maxPercentChange
    );
    assertEq(
      expectedConfig.priceCapConfig.priceCapLst.minDelay,
      currentRiskConfig.priceCapConfig.priceCapLst.minDelay
    );
    assertEq(
      expectedConfig.priceCapConfig.priceCapStable.maxPercentChange,
      currentRiskConfig.priceCapConfig.priceCapStable.maxPercentChange
    );
    assertEq(
      expectedConfig.priceCapConfig.priceCapStable.minDelay,
      currentRiskConfig.priceCapConfig.priceCapStable.minDelay
    );
  }
}
