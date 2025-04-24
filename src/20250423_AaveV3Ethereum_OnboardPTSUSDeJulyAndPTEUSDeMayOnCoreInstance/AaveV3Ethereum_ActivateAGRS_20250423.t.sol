// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum} from 'aave-address-book/AaveV3Ethereum.sol';
import {DataTypes} from 'aave-v3-origin/contracts/protocol/libraries/types/DataTypes.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423} from './AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423.sol';
import {AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423} from './AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.sol';
import {AaveV3Ethereum_ActivateAGRS_20250423, IAaveStewardInjector, IAaveCLRobotOperator} from './AaveV3Ethereum_ActivateAGRS_20250423.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';

/**
 * @dev Test for AaveV3Ethereum_ActivateAGRS_20250423
 * command: FOUNDRY_PROFILE=mainnet forge test --match-path=src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_ActivateAGRS_20250423.t.sol -vv
 */
contract AaveV3Ethereum_ActivateAGRS_20250423_Test is ProtocolV3TestBase {
  AaveV3Ethereum_ActivateAGRS_20250423 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22330904);
    proposal = new AaveV3Ethereum_ActivateAGRS_20250423();

    executePayload(vm, address(new AaveV3Ethereum_OnboardPTEUSDeMayOnCoreInstance_20250423()));
    executePayload(vm, address(new AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423()));

    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());
  }

  /// forge-config: default.evm_version = 'cancun'
  function test_defaultProposalExecution() public {
    defaultTest('AaveV3Ethereum_ActivateAGRS_20250423', AaveV3Ethereum.POOL, address(proposal));
  }

  function test_permissions() public {
    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), false);
    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.MANUAL_RISK_STEWARD()), false);
    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.RISK_STEWARD), true);
    executePayload(vm, address(proposal));

    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.MANUAL_RISK_STEWARD()), true);

    // we revoke old risk steward permission
    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(AaveV3Ethereum.RISK_STEWARD), false);
    assertEq(
      IRiskSteward(proposal.EDGE_RISK_STEWARD()).RISK_COUNCIL(),
      proposal.AAVE_STEWARD_INJECTOR()
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

  function test_inject_sUSDeEModeUpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 8;
    uint256 ltv = 87_90;
    uint256 liqThreshold = 89_90;
    uint256 liqBonus = 5_10;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);
    DataTypes.CollateralConfig memory eModeConfig = AaveV3Ethereum
      .POOL
      .getEModeCategoryCollateralConfig(eModeId);

    assertEq(eModeConfig.ltv, ltv);
    assertEq(eModeConfig.liquidationThreshold, liqThreshold);
    assertEq(eModeConfig.liquidationBonus, 100_00 + liqBonus);
  }

  function test_inject_eUSDeEModeUpdateToProtocol() public {
    executePayload(vm, address(proposal));

    uint8 eModeId = 9;
    uint256 ltv = 91_50;
    uint256 liqThreshold = 93_50;
    uint256 liqBonus = 3_80;
    _addUpdateToRiskOracle(eModeId, ltv, liqThreshold, liqBonus);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);
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
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encode(eModeParam),
      'EModeCategoryUpdate_Core',
      address(uint160(eModeId)),
      'additionalData'
    );
    vm.stopPrank();
  }
}
