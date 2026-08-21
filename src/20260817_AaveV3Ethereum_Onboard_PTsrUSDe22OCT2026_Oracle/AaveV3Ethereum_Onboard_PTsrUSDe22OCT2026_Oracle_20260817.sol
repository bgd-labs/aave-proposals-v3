// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3Ethereum, AaveV3EthereumAssets, AaveV3EthereumEModes} from 'aave-address-book/AaveV3Ethereum.sol';
import {GovernanceV3Ethereum} from 'aave-address-book/GovernanceV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AgentHubAgentActivationPayload} from '../helpers/agent-hub/AgentHubAgentActivationPayload.sol';

/**
 * @title Onboard_PTsrUSDe22OCT2026_Oracle
 * @author LlamaRisk
 * - Snapshot: direct-to-AIP
 * - Discussion: https://gov.discussion.placeholder
 */
contract AaveV3Ethereum_Onboard_PTsrUSDe22OCT2026_Oracle_20260817 is
  AgentHubAgentActivationPayload
{
  /// @dev Governance executor authorized to manage the registered agents' configuration.
  address public constant AGENT_ADMIN = GovernanceV3Ethereum.EXECUTOR_LVL_1;

  /// @dev No suffix is needed because this RiskOracle is dedicated to the LlamaGuard stack.
  string public constant UPDATE_TYPE_SUFFIX = '';

  function execute() external {
    AgentHubConfig memory agentHubConfig = AgentHubConfig({
      aclManager: address(AaveV3Ethereum.ACL_MANAGER),
      agentHub: MiscEthereum.AGENT_HUB,
      rangeValidationModule: MiscEthereum.RANGE_VALIDATION_MODULE,
      agentAdmin: AGENT_ADMIN,
      riskOracle: MiscEthereum.LLAMARISK_RISK_ORACLE
    });

    address discountRateAgent = MiscEthereum.LLAMARISK_PT_DISCOUNT_RATE_AGENT;

    address[] memory ptMarkets = new address[](1);
    ptMarkets[0] = AaveV3EthereumAssets.PT_srUSDe_22OCT2026_UNDERLYING;

    uint256 discountAgentId = _registerAgentAndGrantRole(
      agentHubConfig,
      AgentActivationInput({
        agentAddress: discountRateAgent,
        expirationPeriod: DISCOUNT_EXPIRATION_PERIOD,
        minimumDelay: DISCOUNT_MINIMUM_DELAY,
        updateType: string.concat(DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
        agentContext: bytes(''),
        allowedMarkets: ptMarkets
      })
    );

    address eModeAgent = MiscEthereum.LLAMARISK_PT_EMODE_AGENT;

    address[] memory eModeMarkets = new address[](2);
    // The AgentHub represents eMode category ids as address values.
    eModeMarkets[0] = address(
      uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDC_USDT_USDe)
    );
    eModeMarkets[1] = address(uint160(AaveV3EthereumEModes.sUSDe_PT_srUSDe_22OCT2026__USDe));

    uint256 eModeAgentId = _registerAgentAndGrantRole(
      agentHubConfig,
      AgentActivationInput({
        agentAddress: eModeAgent,
        expirationPeriod: EMODE_EXPIRATION_PERIOD,
        minimumDelay: EMODE_MINIMUM_DELAY,
        updateType: string.concat(EMODE_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
        // The eMode agent executes updates through the Aave ConfigEngine.
        agentContext: abi.encode(AaveV3Ethereum.CONFIG_ENGINE),
        allowedMarkets: eModeMarkets
      })
    );

    // Fresh agent ids require default ranges before they can inject updates.
    _setDefaultRange(
      agentHubConfig,
      discountAgentId,
      string.concat(DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      DISCOUNT_RANGE_ABS
    );
    _setDefaultRange(agentHubConfig, eModeAgentId, 'EModeLTV', EMODE_RANGE_ABS_BPS);
    _setDefaultRange(
      agentHubConfig,
      eModeAgentId,
      'EModeLiquidationThreshold',
      EMODE_RANGE_ABS_BPS
    );
    _setDefaultRange(agentHubConfig, eModeAgentId, 'EModeLiquidationBonus', EMODE_RANGE_ABS_BPS);
  }
}
