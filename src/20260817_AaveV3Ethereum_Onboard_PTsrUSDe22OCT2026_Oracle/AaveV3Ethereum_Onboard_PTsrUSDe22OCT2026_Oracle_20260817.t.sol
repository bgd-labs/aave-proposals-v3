// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

import 'forge-std/Test.sol';
import {ProtocolV3TestBase, ReserveConfig} from 'aave-helpers/src/ProtocolV3TestBase.sol';
import {AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817} from './AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817.sol';
import {IAgentHub} from '../interfaces/IAgentHub.sol';
import {IBaseAaveAgent, IAaveDiscountRateAgent} from '../interfaces/IBaseAaveAgent.sol';
import {IRangeValidationModule} from '../interfaces/IRangeValidationModule.sol';

/**
 * @dev Test for AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817
 * command: FOUNDRY_PROFILE=test forge test --match-path=src/20260817_AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle/AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817.t.sol -vv
 */
contract AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817_Test is ProtocolV3TestBase {
  AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817 internal proposal;

  uint256 internal discountAgentId;
  uint256 internal eModeAgentId;

  uint256 internal constant FORK_BLOCK = 25789439;

  function setUp() public {
    vm.createSelectFork(vm.rpcUrl('mainnet'), FORK_BLOCK);
    proposal = new AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817();

    // The ids the payload will be handed, derived from the live count rather than hardcoded, since
    // anything registered between now and execution shifts them.
    uint256 startCount = IAgentHub(MiscEthereum.AGENT_HUB).getAgentCount();
    discountAgentId = startCount;
    eModeAgentId = startCount + 1;
  }

  /// forge-config: default.isolate = true
  function test_defaultProposalExecution() public {
    defaultTest(
      'AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817',
      AaveV3Ethereum.POOL,
      address(proposal)
    );
  }

  /// @dev The payload touches no reserve configuration at all: it registers agents and grants a
  ///      role. Asserting the empty diff is what proves that.
  function test_reserveConfigChanges() public {
    ReserveConfig[] memory allConfigsBefore = createConfigurationSnapshot(
      'preAaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817',
      AaveV3Ethereum.POOL
    );

    executePayload(vm, address(proposal));

    ReserveConfig[] memory allConfigsAfter = createConfigurationSnapshot(
      'postAaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817',
      AaveV3Ethereum.POOL
    );

    diffReports(
      'preAaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817',
      'postAaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817'
    );

    _noReservesConfigsChangesApartNewListings(allConfigsBefore, allConfigsAfter);
  }

  /// @dev Both agents are pre-deployed. Their immutable dependencies are checked before the payload
  ///      registers their addresses in the AgentHub.
  function test_agentsPredeployedAndWired() public {
    IAgentHub hub = IAgentHub(MiscEthereum.AGENT_HUB);
    IAaveDiscountRateAgent discountAgent = IAaveDiscountRateAgent(proposal.DISCOUNT_RATE_AGENT());
    IBaseAaveAgent eModeAgent = IBaseAaveAgent(proposal.EMODE_AGENT());

    assertGt(proposal.DISCOUNT_RATE_AGENT().code.length, 0, 'discount agent has no code');
    assertGt(proposal.EMODE_AGENT().code.length, 0, 'eMode agent has no code');

    assertEq(discountAgent.AGENT_HUB(), MiscEthereum.AGENT_HUB);
    assertEq(discountAgent.RANGE_VALIDATION_MODULE(), MiscEthereum.RANGE_VALIDATION_MODULE);
    assertEq(discountAgent.POOL(), address(AaveV3Ethereum.POOL));
    assertEq(discountAgent.AAVE_ORACLE(), address(AaveV3Ethereum.ORACLE));
    assertEq(discountAgent.getUpdateType(), proposal.DISCOUNT_UPDATE_TYPE());

    assertEq(eModeAgent.AGENT_HUB(), MiscEthereum.AGENT_HUB);
    assertEq(eModeAgent.RANGE_VALIDATION_MODULE(), MiscEthereum.RANGE_VALIDATION_MODULE);
    assertEq(eModeAgent.POOL(), address(AaveV3Ethereum.POOL));
    assertEq(eModeAgent.getUpdateType(), proposal.EMODE_UPDATE_TYPE());

    executePayload(vm, address(proposal));

    assertEq(hub.getAgentAddress(discountAgentId), proposal.DISCOUNT_RATE_AGENT());
    assertEq(hub.getAgentAddress(eModeAgentId), proposal.EMODE_AGENT());
    assertEq(discountAgent.getUpdateType(), hub.getUpdateType(discountAgentId));
    assertEq(eModeAgent.getUpdateType(), hub.getUpdateType(eModeAgentId));
  }

  function test_agentsRegisteredAndRiskAdminGranted() public {
    IAgentHub hub = IAgentHub(MiscEthereum.AGENT_HUB);
    uint256 countBefore = hub.getAgentCount();

    executePayload(vm, address(proposal));

    assertEq(hub.getAgentCount(), countBefore + 2, 'expected exactly two new agents');

    // Discount agent
    assertTrue(hub.isAgentEnabled(discountAgentId), 'discount agent not enabled');
    assertEq(hub.getRiskOracle(discountAgentId), proposal.LLAMARISK_RISK_ORACLE());
    assertEq(hub.getUpdateType(discountAgentId), proposal.DISCOUNT_UPDATE_TYPE());
    assertEq(hub.getAgentAdmin(discountAgentId), GovernanceV3Ethereum.EXECUTOR_LVL_1);
    assertEq(hub.getMinimumDelay(discountAgentId), proposal.DISCOUNT_MINIMUM_DELAY());

    address[] memory discountMarkets = hub.getAllowedMarkets(discountAgentId);
    assertEq(discountMarkets.length, 1, 'discount agent should allow one market');
    assertEq(discountMarkets[0], AaveV3EthereumAssets.PT_srUSDe_22OCT2026_UNDERLYING);

    // eMode agent
    assertTrue(hub.isAgentEnabled(eModeAgentId), 'eMode agent not enabled');
    assertEq(hub.getRiskOracle(eModeAgentId), proposal.LLAMARISK_RISK_ORACLE());
    assertEq(hub.getUpdateType(eModeAgentId), proposal.EMODE_UPDATE_TYPE());
    assertEq(hub.getMinimumDelay(eModeAgentId), proposal.EMODE_MINIMUM_DELAY());

    // The delegatecall target the eMode agent decodes from its context. A wrong engine here is the
    // difference between an injection landing and reverting.
    assertEq(
      abi.decode(hub.getAgentContext(eModeAgentId), (address)),
      AaveV3Ethereum.CONFIG_ENGINE,
      'eMode agent context is not the current config engine'
    );

    address[] memory eModeMarkets = hub.getAllowedMarkets(eModeAgentId);
    assertEq(eModeMarkets.length, 2, 'eMode agent should allow two categories');
    assertEq(
      eModeMarkets[0],
      address(uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDC_USDT_USDe))
    );
    assertEq(
      eModeMarkets[1],
      address(uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDe))
    );

    // Without the role neither agent can write: the discount one is rejected by the
    // PendlePriceCapAdapter, the eMode one by the PoolConfigurator.
    assertTrue(
      AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(hub.getAgentAddress(discountAgentId)),
      'discount agent is not a risk admin'
    );
    assertTrue(
      AaveV3Ethereum.ACL_MANAGER.isRiskAdmin(hub.getAgentAddress(eModeAgentId)),
      'eMode agent is not a risk admin'
    );
  }

  /// @dev A fresh agent id inherits no default range config, and the module reads a missing config
  ///      as a zero bound, which rejects every injection. So an unset range is not a loose stack,
  ///      it is a dead one, and this is the assertion that catches a forgotten call.
  function test_rangeConfiguration() public {
    executePayload(vm, address(proposal));

    _assertAbsoluteRange(
      discountAgentId,
      proposal.DISCOUNT_UPDATE_TYPE(),
      proposal.DISCOUNT_RANGE_ABS()
    );
    _assertAbsoluteRange(eModeAgentId, 'EModeLTV', proposal.EMODE_RANGE_ABS_BPS());
    _assertAbsoluteRange(eModeAgentId, 'EModeLiquidationThreshold', proposal.EMODE_RANGE_ABS_BPS());
    _assertAbsoluteRange(eModeAgentId, 'EModeLiquidationBonus', proposal.EMODE_RANGE_ABS_BPS());
  }

  function _assertAbsoluteRange(
    uint256 agentId,
    string memory updateType,
    uint120 expected
  ) internal view {
    IRangeValidationModule.RangeConfig memory config = IRangeValidationModule(
      MiscEthereum.RANGE_VALIDATION_MODULE
    ).getDefaultRangeConfig(MiscEthereum.AGENT_HUB, agentId, updateType);

    assertEq(config.maxIncrease, expected, 'unexpected maxIncrease');
    assertEq(config.maxDecrease, expected, 'unexpected maxDecrease');
    // Absolute, because a relative cap is measured against a previous injection that a fresh id
    // does not have, which would leave the first one unbounded.
    assertFalse(config.isIncreaseRelative, 'increase should be absolute');
    assertFalse(config.isDecreaseRelative, 'decrease should be absolute');
  }
}
