// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AaveV3XLayer} from 'aave-address-book/AaveV3XLayer.sol';
import {MiscXLayer} from 'aave-address-book/MiscXLayer.sol';
import {AgentHubAgentActivationPayload} from '../helpers/agent-hub/AgentHubAgentActivationPayload.sol';
import {AgentHubConfigs} from '../helpers/agent-hub/Configs.sol';

/**
 * @dev Addresses not yet in the address book. Names match the address book keys, so each one is
 *      swapped for its `MiscXLayer`, `AaveV3XLayerAssets` or `AaveV3XLayerEModes` entry once it lands.
 */
library XLayerLlamaGuard {
  // https://www.oklink.com/xlayer/address/0x7532F38Be8AB746DD6c1B686A9aAED3400eD35a0
  address internal constant AGENT_HUB = 0x7532F38Be8AB746DD6c1B686A9aAED3400eD35a0;

  // https://www.oklink.com/xlayer/address/0x863D5B3f24E6b84564432dd20606a82bB1C61dC5
  address internal constant RANGE_VALIDATION_MODULE = 0x863D5B3f24E6b84564432dd20606a82bB1C61dC5;

  // https://www.oklink.com/xlayer/address/0x3e0C920C2bdDF6DF87f9A39Ea4db9CF65Cec1EDE
  address internal constant LLAMARISK_RISK_ORACLE = 0x3e0C920C2bdDF6DF87f9A39Ea4db9CF65Cec1EDE;

  // https://www.oklink.com/xlayer/address/0xfC354324B152E2A358A17182d2AF0d3f882c27D2
  address internal constant LLAMARISK_RISK_ORACLE_ROUTER =
    0xfC354324B152E2A358A17182d2AF0d3f882c27D2;

  // https://www.oklink.com/xlayer/address/0xb00251C67dB290D0AD779903bfFeB092DAE76fFa
  address internal constant LLAMARISK_PT_DISCOUNT_RATE_AGENT =
    0xb00251C67dB290D0AD779903bfFeB092DAE76fFa;

  // https://www.oklink.com/xlayer/address/0x19ae7c91dfd35a4515595cEd305d2102C3b1B02D
  address internal constant LLAMARISK_PT_EMODE_AGENT = 0x19ae7c91dfd35a4515595cEd305d2102C3b1B02D;

  /// @dev Listed by the PT-USDG-25FEB2027 onboarding AIP, already executed.
  // https://www.oklink.com/xlayer/address/0x5eA1F184af5Ced57725213D8267B5c4C834557D4
  address internal constant PT_USDG_25FEB2027_UNDERLYING =
    0x5eA1F184af5Ced57725213D8267B5c4C834557D4;

  /// @dev eMode category 9, labelled `PT_USDG_25FEB2027__Stablecoins` by the same AIP.
  uint8 internal constant PT_USDG_25FEB2027__STABLECOINS = 9;
}

/**
 * @title Onboard_PTUSDG25FEB2027_Oracle
 * @author LlamaRisk
 * - Snapshot: direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-upgrade-pt-risk-oracle-to-protocol-owned-infrastructure-on-cre/25119/7
 */
contract AaveV3XLayer_Onboard_PTUSDG25FEB2027_Oracle_20261021 is AgentHubAgentActivationPayload {
  function execute() external {
    AgentHubConfig memory agentHubConfig = AgentHubConfig({
      aclManager: address(AaveV3XLayer.ACL_MANAGER),
      agentHub: XLayerLlamaGuard.AGENT_HUB,
      rangeValidationModule: XLayerLlamaGuard.RANGE_VALIDATION_MODULE,
      agentAdmin: MiscXLayer.PROTOCOL_GUARDIAN,
      riskOracle: XLayerLlamaGuard.LLAMARISK_RISK_ORACLE
    });

    address[] memory ptMarkets = new address[](1);
    ptMarkets[0] = XLayerLlamaGuard.PT_USDG_25FEB2027_UNDERLYING;

    uint256 discountAgentId = _registerAgentAndGrantRole(
      agentHubConfig,
      AgentActivationInput({
        agentAddress: XLayerLlamaGuard.LLAMARISK_PT_DISCOUNT_RATE_AGENT,
        expirationPeriod: AgentHubConfigs.DISCOUNT_EXPIRATION_PERIOD,
        minimumDelay: AgentHubConfigs.DISCOUNT_MINIMUM_DELAY,
        updateType: string.concat(AgentHubConfigs.DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
        agentContext: bytes(''),
        allowedMarkets: ptMarkets
      })
    );

    address[] memory eModeMarkets = new address[](1);
    // The AgentHub represents eMode category ids as address values.
    eModeMarkets[0] = address(uint160(XLayerLlamaGuard.PT_USDG_25FEB2027__STABLECOINS));

    uint256 eModeAgentId = _registerAgentAndGrantRole(
      agentHubConfig,
      AgentActivationInput({
        agentAddress: XLayerLlamaGuard.LLAMARISK_PT_EMODE_AGENT,
        expirationPeriod: AgentHubConfigs.EMODE_EXPIRATION_PERIOD,
        minimumDelay: AgentHubConfigs.EMODE_MINIMUM_DELAY,
        updateType: string.concat(AgentHubConfigs.EMODE_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
        // The eMode agent executes updates through the Aave ConfigEngine.
        agentContext: abi.encode(AaveV3XLayer.CONFIG_ENGINE),
        allowedMarkets: eModeMarkets
      })
    );

    // Fresh agent ids require default ranges before they can inject updates.
    _setDefaultRange(
      agentHubConfig,
      discountAgentId,
      string.concat(AgentHubConfigs.DISCOUNT_UPDATE_TYPE, UPDATE_TYPE_SUFFIX),
      AgentHubConfigs.DISCOUNT_RANGE_ABS
    );
    _setDefaultRange(agentHubConfig, eModeAgentId, 'EModeLTV', AgentHubConfigs.EMODE_RANGE_ABS_BPS);
    _setDefaultRange(
      agentHubConfig,
      eModeAgentId,
      'EModeLiquidationThreshold',
      AgentHubConfigs.EMODE_RANGE_ABS_BPS
    );
    _setDefaultRange(
      agentHubConfig,
      eModeAgentId,
      'EModeLiquidationBonus',
      AgentHubConfigs.EMODE_RANGE_ABS_BPS
    );
  }
}
