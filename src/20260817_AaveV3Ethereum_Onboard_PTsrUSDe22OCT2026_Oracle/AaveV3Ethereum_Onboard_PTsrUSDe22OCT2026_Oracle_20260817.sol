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
  /// @dev Predeployed LlamaRisk RiskOracle shared by the PT oracle agents. The agents read their
  ///      update records from this contract.
  address public constant LLAMARISK_RISK_ORACLE = 0x8346170dcE5455A1205f55A0b5448E67e42CD270;

  // https://etherscan.io/address/0xa142d56b1b77cafdf3a6cca885b471483a56551e
  address public constant DISCOUNT_RATE_AGENT = 0xA142d56B1b77CAfdf3A6cCA885B471483A56551e;

  // https://etherscan.io/address/0x5100392fcdb4515f53af2056bdf3887a85b7a8d9
  address public constant EMODE_AGENT = 0x5100392FCDB4515F53AF2056bDf3887A85b7a8d9;

  /// @dev Governance executor authorized to manage the registered agents' configuration.
  address public constant AGENT_ADMIN = GovernanceV3Ethereum.EXECUTOR_LVL_1;

  /// @dev No suffix is needed because this RiskOracle is dedicated to the LlamaGuard stack.
  string public constant UPDATE_TYPE_SUFFIX = '';

  /// @dev Must match the update types published to the RiskOracle.
  string public constant DISCOUNT_UPDATE_TYPE = 'PendleDiscountRateUpdate';
  string public constant EMODE_UPDATE_TYPE = 'EModeCategoryUpdate';

  /// @dev Minimum time between successful injections for each agent and market.
  uint256 public constant DISCOUNT_MINIMUM_DELAY = 2 days;
  uint256 public constant EMODE_MINIMUM_DELAY = 3 days;

  /// @dev Period during which a RiskOracle update remains eligible for injection.
  uint256 public constant DISCOUNT_EXPIRATION_PERIOD = 2 days;
  uint256 public constant EMODE_EXPIRATION_PERIOD = 3 days;

  /// @dev Absolute per-injection bounds: 100 bps for discount rate and 50 bps for eMode fields.
  uint120 public constant DISCOUNT_RANGE_ABS = 1e16;
  uint120 public constant EMODE_RANGE_ABS_BPS = 50;

  function execute() external {
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

    address eModeAgent = EMODE_AGENT;

    address[] memory eModeMarkets = new address[](2);
    // The AgentHub represents eMode category ids as address values.
    eModeMarkets[0] = address(
      uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDC_USDT_USDe)
    );
    eModeMarkets[1] = address(uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDe));

    uint256 eModeAgentId = _registerAgentAndGrantRole(
      eModeAgent,
      EMODE_EXPIRATION_PERIOD,
      EMODE_MINIMUM_DELAY,
      string.concat(EMODE_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      // The eMode agent executes updates through the Aave ConfigEngine.
      abi.encode(AaveV3Ethereum.CONFIG_ENGINE),
      eModeMarkets
    );

    // Fresh agent ids require default ranges before they can inject updates.
    _setDefaultRange(
      discountAgentId,
      string.concat(DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      DISCOUNT_RANGE_ABS
    );
    _setDefaultRange(eModeAgentId, 'EModeLTV', EMODE_RANGE_ABS_BPS);
    _setDefaultRange(eModeAgentId, 'EModeLiquidationThreshold', EMODE_RANGE_ABS_BPS);
    _setDefaultRange(eModeAgentId, 'EModeLiquidationBonus', EMODE_RANGE_ABS_BPS);
  }

  /// @dev Grants the agent the Aave permission required to apply updates and registers it in the
  ///      AgentHub. The assigned id is returned instead of assumed because it is allocated at
  ///      execution time.
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

  /// @dev Sets symmetric absolute bounds. Relative bounds are unsuitable for a new agent id because
  ///      it has no previous injected value.
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
