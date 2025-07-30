// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3BNB, AaveV3BNBAssets} from 'aave-address-book/AaveV3BNB.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722, IAaveCLRobotOperator} from './AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.sol';

import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';

/**
 * @dev Test for AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250722_Multi_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon/AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722.t.sol -vv
 */
contract AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722_Test is
  ProtocolV3TestBase
{
  AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('bnb'), 54918263);
    proposal = new AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722();

    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3BNB_CapsRiskOracleActivationOnOptimismBNBGnosisPolygon_20250722',
      AaveV3BNB.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertEq(AaveV3BNB.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), false);
    executePayload(vm, address(proposal));

    assertEq(AaveV3BNB.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
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

  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    (, uint256 supplyCap) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3BNBAssets.ETH_UNDERLYING
    );
    uint256 supplyCapToSet = (supplyCap * 130) / 100; // increase caps by 30%

    _addUpdateToRiskOracle(supplyCapToSet);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);

    (, uint256 currentSupplyCap) = AaveV3BNB.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3BNBAssets.ETH_UNDERLYING
    );
    assertEq(supplyCapToSet, currentSupplyCap);
  }

  function _addUpdateToRiskOracle(uint256 value) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value * 1e18),
      'supplyCap',
      address(AaveV3BNBAssets.ETH_A_TOKEN),
      'additionalData'
    );
    vm.stopPrank();
  }
}
