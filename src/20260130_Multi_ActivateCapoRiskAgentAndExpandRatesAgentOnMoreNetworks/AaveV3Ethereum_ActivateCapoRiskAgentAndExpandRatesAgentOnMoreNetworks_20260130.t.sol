// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLido} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {ProtocolV3TestBase, GovV3Helpers} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';

import {AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130, IRangeValidationModule, IAaveCLRobotOperator} from './AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.sol';
import {AutomationCompatibleInterface} from '../interfaces/AutomationCompatibleInterface.sol';
import {IRiskOracle} from '../interfaces/IRiskOracle.sol';
import {IPriceCapAdapter} from '../interfaces/IPriceCapAdapter.sol';
import {IAgentHub} from '../interfaces/IAgentHub.sol';
import {IBaseAaveAgent} from '../interfaces/IBaseAaveAgent.sol';

/**
 * @dev Test for AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260130_Multi_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks/AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130.t.sol -vv
 */
contract AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130_Test is
  ProtocolV3TestBase
{
  using SafeCast for uint256;

  AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130 internal proposal;
  uint256 public constant AGENT_ID = 4;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), 24390711);
    proposal = new AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130();
  }

  /**
   * @dev executes the generic test suite including e2e and config snapshots
   */
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_ActivateCapoRiskAgentAndExpandRatesAgentOnMoreNetworks_20260130',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  function test_agentsRegistered() public {
    uint256 oldAgentCount = IAgentHub(MiscEthereum.AGENT_HUB).getAgentCount();
    GovV3Helpers.executePayload(vm, address(proposal));

    uint256 currentAgentCount = IAgentHub(MiscEthereum.AGENT_HUB).getAgentCount();
    assertEq(AGENT_ID, currentAgentCount - 1);
    assertEq(currentAgentCount, oldAgentCount + 1);

    assertEq(IAgentHub(MiscEthereum.AGENT_HUB).getUpdateType(AGENT_ID), 'CapoPriceCapUpdate_Core');
  }

  function test_rangeValidationConfiguration() public {
    GovV3Helpers.executePayload(vm, address(proposal));

    IRangeValidationModule.RangeConfig memory snapshotConfig = IRangeValidationModule(
      MiscEthereum.RANGE_VALIDATION_MODULE
    ).getDefaultRangeConfig(MiscEthereum.AGENT_HUB, AGENT_ID, 'CapoSnapshotRatio');
    assertEq(snapshotConfig.maxIncrease, 3_00);
    assertEq(snapshotConfig.maxDecrease, 3_00);
    assertEq(snapshotConfig.isIncreaseRelative, true);
    assertEq(snapshotConfig.isDecreaseRelative, true);

    IRangeValidationModule.RangeConfig memory maxGrowthConfig = IRangeValidationModule(
      MiscEthereum.RANGE_VALIDATION_MODULE
    ).getDefaultRangeConfig(MiscEthereum.AGENT_HUB, AGENT_ID, 'CapoMaxYearlyGrowthRatePercent');
    assertEq(maxGrowthConfig.maxIncrease, 10_00);
    assertEq(maxGrowthConfig.maxDecrease, 10_00);
    assertEq(maxGrowthConfig.isIncreaseRelative, true);
    assertEq(maxGrowthConfig.isDecreaseRelative, true);
  }

  function test_validateAgentContractImmutables() public virtual {
    GovV3Helpers.executePayload(vm, address(proposal));

    address agentContract = IAgentHub(MiscEthereum.AGENT_HUB).getAgentAddress(AGENT_ID);
    assertEq(
      address(IBaseAaveAgent(agentContract).RANGE_VALIDATION_MODULE()),
      address(MiscEthereum.RANGE_VALIDATION_MODULE)
    );
    assertEq(address(IBaseAaveAgent(agentContract).POOL()), address(AaveV3Ethereum.POOL));
    assertEq(address(IBaseAaveAgent(agentContract).AGENT_HUB()), MiscEthereum.AGENT_HUB);
  }

  function test_riskAdminRole() public {
    address agentContract = proposal.CAPO_AGENT();

    assertFalse(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(agentContract));
    assertFalse(AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(agentContract));

    GovV3Helpers.executePayload(vm, address(proposal));

    assertTrue(AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(agentContract));
    assertTrue(AaveV3EthereumLido.ACL_MANAGER.isRiskAdmin(agentContract));
  }

  function test_automationRegistered() public {
    vm.expectEmit(false, true, true, true, MiscEthereum.AAVE_CL_ROBOT_OPERATOR);
    emit IAaveCLRobotOperator.KeeperRegistered(
      0,
      MiscEthereum.AGENT_HUB_AUTOMATION,
      uint96(proposal.LINK_AMOUNT())
    );
    GovV3Helpers.executePayload(vm, address(proposal));
  }

  function test_injection_capo() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory markets = proposal.getAssetsToEnableForCapoAgent();

    for (uint256 i = 0; i < markets.length && markets[i] != address(0); i++) {
      vm.startPrank(0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9);
      IPriceCapAdapter capo = IPriceCapAdapter(AaveV3Ethereum.ORACLE.getSourceOfAsset(markets[i]));

      IRiskOracle(AaveV3Ethereum.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
        'referenceId',
        abi.encode(
          IPriceCapAdapter.PriceCapUpdateParams({
            snapshotRatio: ((capo.getSnapshotRatio() * 103) / 100).toUint104(), // 3% increase
            snapshotTimestamp: (capo.getSnapshotTimestamp() + 1).toUint48(),
            maxYearlyRatioGrowthPercent: ((capo.getMaxYearlyGrowthRatePercent() * 110) / 100)
              .toUint16() // 10% increase
          })
        ),
        'CapoPriceCapUpdate_Core',
        markets[i],
        'additionalData'
      );
      vm.stopPrank();

      // check injection
      assertTrue(_checkAndPerformAutomation());
    }
  }

  function test_injection_capo_wrong_update() public {
    GovV3Helpers.executePayload(vm, address(proposal));
    address[] memory markets = proposal.getAssetsToEnableForCapoAgent();

    for (uint256 i = 0; i < markets.length && markets[i] != address(0); i++) {
      vm.startPrank(0x42939e82DF15afc586bb95f7dD69Afb6Dc24A6f9);
      IPriceCapAdapter capo = IPriceCapAdapter(AaveV3Ethereum.ORACLE.getSourceOfAsset(markets[i]));

      IRiskOracle(AaveV3Ethereum.EDGE_RISK_ORACLE).publishRiskParameterUpdate(
        'referenceId',
        abi.encode(
          IPriceCapAdapter.PriceCapUpdateParams({
            snapshotRatio: ((capo.getSnapshotRatio() * 104) / 100).toUint104(), // 4% increase
            snapshotTimestamp: (capo.getSnapshotTimestamp() + 1).toUint48(),
            maxYearlyRatioGrowthPercent: ((capo.getMaxYearlyGrowthRatePercent() * 111) / 100)
              .toUint16() // 11% increase
          })
        ),
        'CapoPriceCapUpdate_Core',
        markets[i],
        'additionalData'
      );
      vm.stopPrank();

      // check injection
      assertFalse(_checkAndPerformAutomation());
    }
  }

  function _checkAndPerformAutomation() public returns (bool) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = AGENT_ID;

    (bool upkeepNeeded, bytes memory performData) = AutomationCompatibleInterface(
      MiscEthereum.AGENT_HUB_AUTOMATION
    ).checkUpkeep(abi.encode(agentIds));

    if (upkeepNeeded) {
      AutomationCompatibleInterface(MiscEthereum.AGENT_HUB_AUTOMATION).performUpkeep(performData);
    }
    return upkeepNeeded;
  }
}
