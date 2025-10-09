// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Plasma} from 'aave-address-book/AaveV3Plasma.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007} from './AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007.sol';

import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IPendlePriceCapAdapter} from '../interfaces/IPendlePriceCapAdapter.sol';
import {ExecutionChainRobotKeeper} from '../interfaces/ExecutionChainRobotKeeper.sol';
/**
 * @dev Test for AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20251007_AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance/AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007.t.sol -vv
 */
contract AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007_Test is
  ProtocolV3TestBase
{
  AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007
    internal proposal;
  address public constant EDGE_RISK_ORACLE = 0xAe48F22903d43f13f66Cc650F57Bd4654ac222cb;
  address public constant RISK_ORACLE_OWNER = 0xDe841Bf4B67970f5a19165443B0e9ec808E1cC85;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('plasma'), 3116719);
    proposal = new AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007();
    vm.startPrank(RISK_ORACLE_OWNER);
    IRiskOracle(EDGE_RISK_ORACLE).addAuthorizedSender(RISK_ORACLE_OWNER);
    vm.stopPrank();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007',
      AaveV3Plasma.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_USDe_15JAN2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_USDe_15JAN2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_PT_USDe_15JAN2026Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_USDe_15JAN2026 = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_USDe_15JAN2026());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_USDe_15JAN2026()
      ),
      proposal.PT_USDe_15JAN2026_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aPT_USDe_15JAN2026),
      proposal.PT_USDe_15JAN2026_LM_ADMIN()
    );
  }

  function test_dustBinHasPT_sUSDE_15JAN2026Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_15JAN2026());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Plasma.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_PT_sUSDE_15JAN2026Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_sUSDE_15JAN2026 = AaveV3Plasma.POOL.getReserveAToken(proposal.PT_sUSDE_15JAN2026());
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_sUSDE_15JAN2026()
      ),
      proposal.PT_sUSDE_15JAN2026_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Plasma.EMISSION_MANAGER).getEmissionAdmin(aPT_sUSDE_15JAN2026),
      proposal.PT_sUSDE_15JAN2026_LM_ADMIN()
    );
  }

  function test_inject_EMode5UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 5;
    uint256 ltv = 85_40;
    uint256 liqThreshold = 87_40;
    uint256 liqBonus = 4_90;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    bool upkeepNeeded = _checkAndPerformUpKeep(
      ExecutionChainRobotKeeper(proposal.EDGE_INJECTOR_PENDLE_EMODE())
    );
    assertTrue(upkeepNeeded);

    DataTypes.CollateralConfig memory eModeConfig = AaveV3Plasma
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function test_inject_EMode6UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 6;
    uint256 ltv = 86_20;
    uint256 liqThreshold = 88_20;
    uint256 liqBonus = 3_90;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    bool upkeepNeeded = _checkAndPerformUpKeep(
      ExecutionChainRobotKeeper(proposal.EDGE_INJECTOR_PENDLE_EMODE())
    );
    assertTrue(upkeepNeeded);

    DataTypes.CollateralConfig memory eModeConfig = AaveV3Plasma
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function test_inject_EMode7UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 7;
    uint256 ltv = 83_90;
    uint256 liqThreshold = 85_90;
    uint256 liqBonus = 6_00;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    bool upkeepNeeded = _checkAndPerformUpKeep(
      ExecutionChainRobotKeeper(proposal.EDGE_INJECTOR_PENDLE_EMODE())
    );
    assertTrue(upkeepNeeded);

    DataTypes.CollateralConfig memory eModeConfig = AaveV3Plasma
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function test_inject_EMode8UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 8;
    uint256 ltv = 84_50;
    uint256 liqThreshold = 86_50;
    uint256 liqBonus = 5_20;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    bool upkeepNeeded = _checkAndPerformUpKeep(
      ExecutionChainRobotKeeper(proposal.EDGE_INJECTOR_PENDLE_EMODE())
    );
    assertTrue(upkeepNeeded);

    DataTypes.CollateralConfig memory eModeConfig = AaveV3Plasma
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function test_injectUpdateToProtocol_sUSDe() public {
    executePayload(vm, address(proposal));
    IPendlePriceCapAdapter PT_ORACLE = IPendlePriceCapAdapter(
      AaveV3Plasma.ORACLE.getSourceOfAsset(proposal.PT_sUSDE_15JAN2026())
    );
    uint256 currentDiscountRate = PT_ORACLE.discountRatePerYear();
    uint256 discountRateToSet = currentDiscountRate + 0.01e18; // increase by 1% absolute value

    _addUpdateToRiskOracle(discountRateToSet, proposal.PT_sUSDE_15JAN2026());

    bool upkeepNeeded = _checkAndPerformUpKeep(
      ExecutionChainRobotKeeper(proposal.EDGE_INJECTOR_DISCOUNT_RATE())
    );
    assertTrue(upkeepNeeded);

    currentDiscountRate = PT_ORACLE.discountRatePerYear();
    assertEq(discountRateToSet, currentDiscountRate);
  }

  function test_injectUpdateToProtocol_USDe() public {
    executePayload(vm, address(proposal));
    IPendlePriceCapAdapter PT_ORACLE = IPendlePriceCapAdapter(
      AaveV3Plasma.ORACLE.getSourceOfAsset(proposal.PT_USDe_15JAN2026())
    );
    uint256 currentDiscountRate = PT_ORACLE.discountRatePerYear();
    uint256 discountRateToSet = currentDiscountRate + 0.01e18; // increase by 1% absolute value

    _addUpdateToRiskOracle(discountRateToSet, proposal.PT_USDe_15JAN2026());

    bool upkeepNeeded = _checkAndPerformUpKeep(
      ExecutionChainRobotKeeper(proposal.EDGE_INJECTOR_DISCOUNT_RATE())
    );
    assertTrue(upkeepNeeded);

    currentDiscountRate = PT_ORACLE.discountRatePerYear();
    assertEq(discountRateToSet, currentDiscountRate);
  }

  function _addUpdateToRiskOracle(uint8 eModeId, uint256 ltv, uint256 lt, uint256 lb) internal {
    IAaveStewardInjector.EModeCategoryUpdate memory eModeParam = IAaveStewardInjector
      .EModeCategoryUpdate({ltv: ltv, liqThreshold: lt, liqBonus: lb});

    vm.startPrank(RISK_ORACLE_OWNER);
    IRiskOracle(IAaveStewardInjector(proposal.EDGE_INJECTOR_PENDLE_EMODE()).RISK_ORACLE())
      .publishRiskParameterUpdate(
        'referenceId',
        abi.encode(eModeParam),
        'EModeCategoryUpdate',
        address(uint160(eModeId)),
        'additionalData'
      );
    vm.stopPrank();
  }

  function _addUpdateToRiskOracle(uint256 value, address asset) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    IRiskOracle(EDGE_RISK_ORACLE).publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value),
      'PendleDiscountRateUpdate',
      asset,
      'additionalData'
    );
    vm.stopPrank();
  }

  function _checkAndPerformUpKeep(
    ExecutionChainRobotKeeper executionChainRobotKeeper
  ) internal returns (bool) {
    (bool shouldRunKeeper, bytes memory encodedPerformData) = executionChainRobotKeeper.checkUpkeep(
      ''
    );
    if (shouldRunKeeper) {
      (bool status, ) = address(executionChainRobotKeeper).call(encodedPerformData);
      assertTrue(status, 'Perform Upkeep Failed');
    }
    return shouldRunKeeper;
  }
}
