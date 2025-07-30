// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Gnosis, AaveV3GnosisAssets} from 'aave-address-book/AaveV3Gnosis.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722} from './AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol';

import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';

/**
 * @dev Test for AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.t.sol -vv
 */
contract AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722_Test is
  ProtocolV3TestBase
{
  AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  address public AAVE_STEWARD_INJECTOR;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('gnosis'), 41234524);
    proposal = new AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722();

    AAVE_STEWARD_INJECTOR = IRiskSteward(proposal.EDGE_RISK_STEWARD()).RISK_COUNCIL();
    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(AAVE_STEWARD_INJECTOR).RISK_ORACLE());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Gnosis_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722',
      AaveV3Gnosis.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertEq(AaveV3Gnosis.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), false);
    executePayload(vm, address(proposal));

    assertEq(AaveV3Gnosis.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
  }

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    (, uint256 supplyCap) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3GnosisAssets.WETH_UNDERLYING
    );
    uint256 supplyCapToSet = (supplyCap * 130) / 100; // increase caps by 30%

    _addUpdateToRiskOracle(supplyCapToSet);

    (bool upkeepNeeded, bytes memory encodedPerformData) = AutomationCompatibleInterface(
      AAVE_STEWARD_INJECTOR
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    (bool success, ) = AAVE_STEWARD_INJECTOR.call(encodedPerformData);
    assertTrue(success);

    (, uint256 currentSupplyCap) = AaveV3Gnosis.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3GnosisAssets.WETH_UNDERLYING
    );
    assertEq(supplyCapToSet, currentSupplyCap);
  }

  function _addUpdateToRiskOracle(uint256 value) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value * 1e18),
      'supplyCap',
      address(AaveV3GnosisAssets.WETH_A_TOKEN),
      'additionalData'
    );
    vm.stopPrank();
  }
}
