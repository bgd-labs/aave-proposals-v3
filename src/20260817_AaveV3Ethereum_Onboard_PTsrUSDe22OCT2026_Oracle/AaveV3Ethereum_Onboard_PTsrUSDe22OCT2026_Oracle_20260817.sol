// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IAgentHub, IAgentConfigurator} from '../interfaces/IAgentHub.sol';
import {IRangeValidationModule} from '../interfaces/IRangeValidationModule.sol';

/**
 * @title Onboard_PTsrUSDe22OCT2026_Oracle
 * @author LlamaRisk
 * - Snapshot: direct-to-AIP
 * - Discussion: https://gov.discussion.placeholder
 */
contract AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817 is IProposalGenericExecutor {
  // ---------------------------------------------------------------------------------------------
  // LlamaRisk deployment on Ethereum mainnet (llamaguard-risk-oracles stack)
  // ---------------------------------------------------------------------------------------------

  /// @dev BGD stock RiskOracle, written only by the LlamaguardRiskOracleRouter, which in turn is
  ///      written only by the Chainlink CRE forwarder. Constructed with the two update types below
  ///      and nothing else, and owned by the LlamaRisk multisig.
  ///
  ///      The RiskOracle is deployed ahead of the vote because it is shared across every PT this
  ///      instance onboards and is not a per-proposal artifact.
  address public constant LLAMARISK_RISK_ORACLE = 0x8346170dcE5455A1205f55A0b5448E67e42CD270;

  // https://etherscan.io/address/0xa142d56b1b77cafdf3a6cca885b471483a56551e
  address public constant DISCOUNT_RATE_AGENT = 0xA142d56B1b77CAfdf3A6cCA885B471483A56551e;

  // https://etherscan.io/address/0x5100392fcdb4515f53af2056bdf3887a85b7a8d9
  address public constant EMODE_AGENT = 0x5100392FCDB4515F53AF2056bDf3887A85b7a8d9;

  // ---------------------------------------------------------------------------------------------
  // Registration parameters
  // ---------------------------------------------------------------------------------------------

  /// @dev Manages the agents' markets, senders and range configs once registered. Cannot widen the
  ///      authority granted here. Set to the short executor, which is what already owns the
  ///      AgentHub and holds DEFAULT_ADMIN_ROLE on the ACL manager, rather than to a provider
  ///      multisig. Mainnet has no permissioned payloads controller executor to use instead.
  address public constant AGENT_ADMIN = GovernanceV3Ethereum.EXECUTOR_LVL_1;

  /// @dev The agents' `updateTypeSuffix` constructor parameter exists so that one shared RiskOracle
  ///      can feed several Aave instances without their records colliding. The LlamaRisk RiskOracle
  ///      is dedicated to this stack and feeds nothing else, so the suffix is empty and the
  ///      registered types are the base types below.
  string public constant UPDATE_TYPE_SUFFIX = '';

  /// @dev Base update types, and the types the RiskOracle publishes. Each agent concatenates its
  ///      own base type with the suffix at construction, and rejects any record whose type does not
  ///      match, so registering these strings under the same two constants the agents are built from
  ///      is what keeps the hub, the agents and the oracle in agreement.
  string public constant DISCOUNT_UPDATE_TYPE = 'PendleDiscountRateUpdate';
  string public constant EMODE_UPDATE_TYPE = 'EModeCategoryUpdate';

  /// @dev Cooldown enforced at injection, per agent and market. The discount workflow additionally
  ///      self-gates on the Router's own 48 hour throttle; the risk-params workflow has no delay
  ///      gate of its own, so for the eMode agent this is the only rate limit.
  uint256 public constant DISCOUNT_MINIMUM_DELAY = 2 days;
  uint256 public constant EMODE_MINIMUM_DELAY = 3 days;

  /// @dev How long a published record stays injectable. Matched to the delays so a record cannot
  ///      outlive the cooldown that gates it.
  uint256 public constant DISCOUNT_EXPIRATION_PERIOD = 2 days;
  uint256 public constant EMODE_EXPIRATION_PERIOD = 3 days;

  // ---------------------------------------------------------------------------------------------
  // Range bounds, absolute rather than relative
  // ---------------------------------------------------------------------------------------------

  /// @dev 100 bps of discount rate per injection, in the adapter's 1e18 units. Matches the step cap
  ///      the Router enforces on the same route, so neither gate is dead weight.
  uint120 public constant DISCOUNT_RANGE_ABS = 1e16;

  /// @dev 50 bps per injection on each eMode field.
  uint120 public constant EMODE_RANGE_ABS_BPS = 50;

  function execute() external {
    // 1. Register the pre-deployed discount-rate agent for PT-srUSDe-22OCT2026.
    address discountRateAgent = DISCOUNT_RATE_AGENT;

    address[] memory ptMarkets = new address[](1);
    ptMarkets[0] = AaveV3EthereumAssets.PT_srUSDe_22OCT2026_UNDERLYING;

    uint256 discountAgentId = _registerAgentAndGrantRole(
      discountRateAgent,
      DISCOUNT_EXPIRATION_PERIOD,
      DISCOUNT_MINIMUM_DELAY,
      string.concat(DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      bytes(''),
      ptMarkets
    );

    // 2. Register the pre-deployed eMode agent for the two PT-srUSDe-22OCT2026 eMode categories.
    //    eMode ids are encoded as addresses, following the chaos-agents convention.
    address eModeAgent = EMODE_AGENT;

    address[] memory eModeMarkets = new address[](2);
    eModeMarkets[0] = address(
      uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDC_USDT_USDe)
    );
    eModeMarkets[1] = address(uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDe));

    uint256 eModeAgentId = _registerAgentAndGrantRole(
      eModeAgent,
      EMODE_EXPIRATION_PERIOD,
      EMODE_MINIMUM_DELAY,
      string.concat(EMODE_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      // the eMode agent delegatecalls updateEModeCategories on the target decoded from its context
      abi.encode(AaveV3Ethereum.CONFIG_ENGINE),
      eModeMarkets
    );

    // 3. Bound every parameter step the agents can inject. A freshly assigned agent id inherits no
    //    default range config, and the module treats a missing config as a zero bound, so without
    //    these four calls every injection is silently rejected.
    _setDefaultRange(
      discountAgentId,
      string.concat(DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      DISCOUNT_RANGE_ABS
    );
    _setDefaultRange(eModeAgentId, 'EModeLTV', EMODE_RANGE_ABS_BPS);
    _setDefaultRange(eModeAgentId, 'EModeLiquidationThreshold', EMODE_RANGE_ABS_BPS);
    _setDefaultRange(eModeAgentId, 'EModeLiquidationBonus', EMODE_RANGE_ABS_BPS);
  }

  /**
   * @dev Grants RISK_ADMIN, then registers the agent and returns the id the hub assigned.
   *
   *      The grant is what lets the agents write at all. The discount agent resolves the PT price
   *      source through the Aave oracle and calls `setDiscountRatePerYear` on the
   *      PendlePriceCapAdapter directly, which gates on `isRiskAdmin || isPoolAdmin`. The eMode
   *      agent delegatecalls the config engine, and because delegatecall preserves the caller the
   *      PoolConfigurator sees the agent rather than the engine, so the role has to sit on the
   *      agent there too.
   *
   *      The id is captured rather than assumed. `agentCount++` decides it, so anything registered
   *      between drafting and execution shifts it, and the range configs below are keyed by it.
   */
  function _registerAgentAndGrantRole(
    address agentAddress,
    uint256 expirationPeriod,
    uint256 minimumDelay,
    string memory updateType,
    bytes memory agentContext,
    address[] memory allowedMarkets
  ) internal returns (uint256 agentId) {
    AaveV3Ethereum.ACL_MANAGER.addRiskAdmin(agentAddress);

    return
      IAgentHub(MiscEthereum.AGENT_HUB).registerAgent(
        IAgentConfigurator.AgentRegistrationInput({
          admin: AGENT_ADMIN,
          riskOracle: LLAMARISK_RISK_ORACLE,
          isAgentEnabled: true,
          isAgentPermissioned: false, // default
          isMarketsFromAgentEnabled: false, // default
          agentAddress: agentAddress,
          expirationPeriod: expirationPeriod,
          minimumDelay: minimumDelay,
          updateType: updateType,
          agentContext: agentContext,
          allowedMarkets: allowedMarkets,
          restrictedMarkets: new address[](0), // default
          permissionedSenders: new address[](0) // default
        })
      );
  }

  /// @dev Absolute bounds, not relative. A relative cap is measured against the last value the
  ///      agent injected, which does not exist on a fresh id, so the first injection would be
  ///      unbounded.
  function _setDefaultRange(uint256 agentId, string memory updateType, uint120 bound) internal {
    IRangeValidationModule(MiscEthereum.RANGE_VALIDATION_MODULE).setDefaultRangeConfig(
      MiscEthereum.AGENT_HUB,
      agentId,
      updateType,
      IRangeValidationModule.RangeConfig({
        maxIncrease: bound,
        maxDecrease: bound,
        isIncreaseRelative: false,
        isDecreaseRelative: false
      })
    );
  }
}
