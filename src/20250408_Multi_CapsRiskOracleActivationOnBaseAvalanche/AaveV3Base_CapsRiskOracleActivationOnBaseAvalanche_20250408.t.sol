// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Base, AaveV3BaseAssets} from 'aave-address-book/AaveV3Base.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';

import {AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408, IAaveCLRobotOperator} from './AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408.sol';
import {AutomationCompatibleInterface} from './interfaces/AutomationCompatibleInterface.sol';
import {IAaveStewardInjector} from './interfaces/IAaveStewardInjector.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';

/**
 * @dev Test for AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408
 * command: FOUNDRY_PROFILE=base forge test --match-path=src/20250408_Multi_CapsRiskOracleActivationOnBaseAvalanche/AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408.t.sol -vv
 */
contract AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408_Test is ProtocolV3TestBase {
  AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('base'), 28696835);
    proposal = new AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408();

    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Base_CapsRiskOracleActivationOnBaseAvalanche_20250408',
      AaveV3Base.POOL,
      address(proposal)
    );
  }

  function test_permissions() public {
    assertEq(AaveV3Base.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), false);
    executePayload(vm, address(proposal));

    assertEq(AaveV3Base.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
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

  /// forge-config: default.evm_version = 'cancun'
  function test_injectUpdateToProtocol() public {
    executePayload(vm, address(proposal));
    (, uint256 supplyCap) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3BaseAssets.WETH_UNDERLYING
    );
    uint256 supplyCapToSet = (supplyCap * 130) / 100; // increase caps by 30%

    _addUpdateToRiskOracle(supplyCapToSet);

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      proposal.AAVE_STEWARD_INJECTOR()
    ).checkUpkeep('');
    assertTrue(upkeepNeeded);

    AutomationCompatibleInterface(proposal.AAVE_STEWARD_INJECTOR()).performUpkeep(performData);

    (, uint256 currentSupplyCap) = AaveV3Base.AAVE_PROTOCOL_DATA_PROVIDER.getReserveCaps(
      AaveV3BaseAssets.WETH_UNDERLYING
    );
    assertEq(supplyCapToSet, currentSupplyCap);
  }

  function test_injectorConfigurations() public view {
    address[] memory configuredMarkets = IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR())
      .getMarkets();

    address[] memory listedAssets = AaveV3Base.POOL.getReservesList();
    address[] memory expectedMarkets = new address[](listedAssets.length - 2);
    uint256 count;
    for (uint256 i = 0; i < listedAssets.length; i++) {
      if (
        listedAssets[i] == AaveV3BaseAssets.wrsETH_UNDERLYING ||
        listedAssets[i] == AaveV3BaseAssets.ezETH_UNDERLYING
      ) continue;
      expectedMarkets[count] = AaveV3Base.POOL.getReserveAToken(listedAssets[i]);
      count++;
    }

    // all aTokens listed are configured on the injector except for wrsETH and ezETH
    assertEq(configuredMarkets, expectedMarkets);

    string[] memory updateTypes = IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR())
      .getUpdateTypes();
    assertEq(updateTypes.length, 2);
    assertEq(updateTypes[0], 'supplyCap');
    assertEq(updateTypes[1], 'borrowCap');
  }

  function _addUpdateToRiskOracle(uint256 value) internal {
    vm.startPrank(RISK_ORACLE_OWNER);
    RISK_ORACLE.publishRiskParameterUpdate(
      'referenceId',
      abi.encodePacked(value * 1e18),
      'supplyCap',
      address(AaveV3BaseAssets.WETH_A_TOKEN),
      'additionalData'
    );
    vm.stopPrank();
  }
}
