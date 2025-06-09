// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {ProtocolV3TestBase} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606, IAaveCLRobotOperator} from './AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.sol';

import {IPendlePriceCapAdapter} from './interfaces/IPendlePriceCapAdapter.sol';
import {IAaveStewardInjector} from '../interfaces/IAaveStewardInjector.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IRiskSteward} from '../interfaces/IRiskSteward.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';

import {BaseStewardUpdateTest} from './BaseStewardUpdateTest.t.sol';

/**
 * @dev Test for AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20250606_Multi_PendlePTDiscountRateRiskOracleActivation/AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606.t.sol -vv
 */
contract AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606_Test is
  ProtocolV3TestBase,
  BaseStewardUpdateTest
{
  AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606 internal proposal;

  address public constant RISK_ORACLE_OWNER = 0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9;
  IPendlePriceCapAdapter public PT_ORACLE;
  IRiskOracle public RISK_ORACLE;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 22646074);
    proposal = new AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606();

    PT_ORACLE = IPendlePriceCapAdapter(
      AaveV3Ethereum.ORACLE.getSourceOfAsset(AaveV3EthereumAssets.PT_sUSDE_31JUL2025_UNDERLYING)
    );
    RISK_ORACLE = IRiskOracle(IAaveStewardInjector(proposal.AAVE_STEWARD_INJECTOR()).RISK_ORACLE());

    vm.prank(0x2400ad77C8aCCb958b824185897db9B9DD771830);
    RISK_ORACLE.addUpdateType('PendleDiscountRateUpdate_Core');
  }

  function getBaseTestInput() public virtual override returns (ValidationInput memory) {
    return
      ValidationInput({
        payload: address(proposal),
        aclManager: address(AaveV3Ethereum.ACL_MANAGER),
        currentRiskSteward: AaveV3Ethereum.RISK_STEWARD,
        newRiskSteward: proposal.NEW_RISK_STEWARD(),
        freezingSteward: AaveV3Ethereum.FREEZING_STEWARD,
        capsPlusSteward: AaveV3Ethereum.CAPS_PLUS_RISK_STEWARD
      });
  }

  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_PendlePTDiscountRateRiskOracleActivation_20250606',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_injector_permissions() public {
    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), false);
    executePayload(vm, address(proposal));

    assertEq(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(proposal.EDGE_RISK_STEWARD()), true);
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
