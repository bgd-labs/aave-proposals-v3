// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722} from './AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722.sol';

import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IPendlePriceCapAdapter} from '../interfaces/IPendlePriceCapAdapter.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';

/**
 * @dev Test for AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250722_AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722.t.sol -vv
 */
contract AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22983122);
    proposal = new AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_dustBinHasPT_USDe_25SEP2025Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_USDe_25SEP2025());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_PT_USDe_25SEP2025Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_USDe_25SEP2025 = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_USDe_25SEP2025());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_USDe_25SEP2025()
      ),
      proposal.PT_USDe_25SEP2025_LM_ADMIN()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aPT_USDe_25SEP2025),
      proposal.PT_USDe_25SEP2025_LM_ADMIN()
    );
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    IPendlePriceCapAdapter PT_ORACLE = IPendlePriceCapAdapter(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(proposal.PT_USDe_25SEP2025())
    );
    uint256 currentDiscountRate = PT_ORACLE.discountRatePerYear();
    uint256 discountRateToSet = currentDiscountRate + 0.01e18; // increase by 1% absolute value

    _addUpdateToRiskOracle(discountRateToSet);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      AaveV3Ethereum.EDGE_INJECTOR_DISCOUNT_RATE
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(AaveV3Ethereum.EDGE_INJECTOR_DISCOUNT_RATE).performUpkeep(
      performData
    );

    currentDiscountRate = PT_ORACLE.discountRatePerYear();
    assertEq(discountRateToSet, currentDiscountRate);
  }

  function test_inject_EMode19UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 19;
    uint256 ltv = 90_30;
    uint256 liqThreshold = 92_30;
    uint256 liqBonus = 3_50;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE).performUpkeep(
      performData
    );
    DataTypes.CollateralConfig memory eModeConfig = AaveV3Ethereum
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function test_inject_EMode20UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 20;
    uint256 ltv = 91_20;
    uint256 liqThreshold = 93_20;
    uint256 liqBonus = 2_50;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE).performUpkeep(
      performData
    );
    DataTypes.CollateralConfig memory eModeConfig = AaveV3Ethereum
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function _addUpdateToRiskOracle(uint8 eModeId, uint256 ltv, uint256 lt, uint256 lb) internal {
    IAaveStewardInjector.EModeCategoryUpdate memory eModeParam = IAaveStewardInjector
      .EModeCategoryUpdate({ltv: ltv, liqThreshold: lt, liqBonus: lb});

    vm.startPrank(RISK_ORACLE_OWNER);
    IRiskOracle(IAaveStewardInjector(AaveV3Ethereum.EDGE_INJECTOR_PENDLE_EMODE).RISK_ORACLE())
      .publishRiskParameterUpdate(
        'referenceId',
        abi.encode(eModeParam),
        'EModeCategoryUpdate_Core',
        address(uint160(eModeId)),
        'additionalData'
      );
    vm.stopPrank();
  }
  function _addUpdateToRiskOracle(uint256 value) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    IRiskOracle(AaveV3Ethereum.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value),
      'PendleDiscountRateUpdate_Core',
      proposal.PT_USDe_25SEP2025(),
      'additionalData'
    );
    vm.stopPrank();
  }
}
