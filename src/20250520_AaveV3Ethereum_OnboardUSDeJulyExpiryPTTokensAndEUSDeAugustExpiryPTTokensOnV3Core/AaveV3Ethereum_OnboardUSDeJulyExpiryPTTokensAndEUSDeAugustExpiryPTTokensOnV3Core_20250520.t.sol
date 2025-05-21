// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {GovV3Helpers} from 'aave-helpers/src/GovV3Helpers.sol';
import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {IEmissionManager} from 'aave-v3-origin/contracts/rewards/interfaces/IEmissionManager.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520} from './AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520.sol';

import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
/**
 * @dev Test for AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250520_AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core/AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520.t.sol -vv
 */
contract AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520_Test is
  ProtocolV3TestBase
{
  AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520
    internal proposal;
  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22531404);
    proposal = new AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_inject_EMode10UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 10;
    uint256 ltv = 88_10;
    uint256 liqThreshold = 91_10;
    uint256 liqBonus = 3_90;
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

  function test_inject_EMode12UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 12;
    uint256 ltv = 90_10;
    uint256 liqThreshold = 92_10;
    uint256 liqBonus = 2_80;
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

  function test_inject_EMode13UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 13;
    uint256 ltv = 87_10;
    uint256 liqThreshold = 90_10;
    uint256 liqBonus = 4_10;
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

  function test_inject_EMode14UpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 14;
    uint256 ltv = 89_00;
    uint256 liqThreshold = 91_00;
    uint256 liqBonus = 3_10;
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

  function test_dustBinHasPT_USDe_31JUL2025Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_USDe_31JUL2025());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_PT_USDe_31JUL2025Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_USDe_31JUL2025 = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_USDe_31JUL2025());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_USDe_31JUL2025()
      ),
      proposal.LM_ACI_ETH()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aPT_USDe_31JUL2025),
      proposal.LM_ACI_ETH()
    );
  }

  function test_dustBinHasPT_eUSDe_14AUG2025Funds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.PT_eUSDe_14AUG2025());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_PT_eUSDe_14AUG2025Admin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aPT_eUSDe_14AUG2025 = AaveV3Ethereum.POOL.getReserveAToken(
      proposal.PT_eUSDe_14AUG2025()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(
        proposal.PT_eUSDe_14AUG2025()
      ),
      proposal.LM_ACI_ETH()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aPT_eUSDe_14AUG2025),
      proposal.LM_ACI_ETH()
    );
  }

  function test_dustBinHaseUSDeFunds() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aTokenAddress = AaveV3Ethereum.POOL.getReserveAToken(proposal.eUSDe());
    assertGe(IERC20(aTokenAddress).balanceOf(address(AaveV3Ethereum.DUST_BIN)), 100 * 10 ** 18);
  }

  function test_eUSDeAdmin() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address aeUSDe = AaveV3Ethereum.POOL.getReserveAToken(proposal.eUSDe());
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(proposal.eUSDe()),
      proposal.LM_ACI_ETH()
    );
    assertEq(
      IEmissionManager(AaveV3Ethereum.EMISSION_MANAGER).getEmissionAdmin(aeUSDe),
      proposal.LM_ACI_ETH()
    );
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
}
