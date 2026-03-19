// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IPool} from 'aave-v3-origin/contracts/interfaces/IPool.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {SafeERC20} from 'openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol';
import {SafeCast} from 'openzeppelin-contracts/contracts/utils/math/SafeCast.sol';
import {ICollector, CollectorUtils} from 'aave-helpers/src/CollectorUtils.sol';

import {IAaveCLRobotOperator} from '../interfaces/IAaveCLRobotOperator.sol';
import {IAgentHub, IAgentConfigurator} from '../interfaces/IAgentHub.sol';

/**
 * @title Base contract for activating risk agents
 * @author BGD Labs (@bgdlabs)
 * @dev Abstract base contract that provides common logic for registering agents,
 *      configuring range validation, granting permissions, and registering automation
 */
abstract contract BaseActivateRiskAgentPayload is IProposalGenericExecutor {
  using CollectorUtils for ICollector;
  using SafeERC20 for IERC20;
  using SafeCast for uint256;

  struct PayloadConfig {
    address admin;
    address riskOracle;
    address agentAddress;
    uint256 expirationPeriod;
    uint256 minimumDelay;
    string updateType;
    bytes agentContext;
    address agentHub;
    address rangeValidationModule;
    address robotOperator;
    address agentHubAutomation;
    address linkToken;
    uint96 linkAmount;
    bool withdrawLinkFromCollector;
    IPool pool;
    ICollector collector;
    string automationName;
  }

  function execute() external {
    PayloadConfig memory config = _getConfig();

    // 1. register agent on the agent-hub
    uint256 agentId = IAgentHub(config.agentHub).registerAgent(
      IAgentConfigurator.AgentRegistrationInput({
        admin: config.admin,
        riskOracle: config.riskOracle,
        isAgentEnabled: true, // default
        isAgentPermissioned: false, // default
        isMarketsFromAgentEnabled: false, // default
        agentAddress: config.agentAddress,
        expirationPeriod: config.expirationPeriod,
        minimumDelay: config.minimumDelay,
        updateType: config.updateType,
        agentContext: config.agentContext,
        allowedMarkets: getAllowedMarkets(),
        restrictedMarkets: new address[](0), // default
        permissionedSenders: new address[](0) // default
      })
    );

    // 2. configure range on the range-validation-module
    _configureRangeValidation(config.rangeValidationModule, config.agentHub, agentId);

    // 3. give permissions to new agent contracts
    _grantRiskAdminPermissions(config.agentAddress);

    // 4. register new automation for the agents
    uint256 linkAmount = _obtainLinkTokens(config);
    IERC20(config.linkToken).forceApprove(config.robotOperator, linkAmount);
    IAaveCLRobotOperator(config.robotOperator).register(
      config.automationName,
      config.agentHubAutomation,
      _encodeAgentIdToBytes(agentId),
      5_000_000,
      linkAmount.toUint96(),
      0,
      ''
    );

    // 5. execute any custom logic if needed
    _postExecute();
  }

  function getAllowedMarkets() public pure virtual returns (address[] memory);

  function _getConfig() internal pure virtual returns (PayloadConfig memory);

  function _configureRangeValidation(
    address rangeValidationModule,
    address agentHub,
    uint256 agentId
  ) internal virtual;

  /**
   * @dev Override this in network-specific contracts to grant risk admin permissions
   * Default implementation grants to single ACL manager, Ethereum overrides for both Core and Lido
   */
  function _grantRiskAdminPermissions(address agentAddress) internal virtual;

  /// @dev to be overridden on the child if any extra logic is needed
  function _postExecute() internal virtual {}

  /**
   * @dev Obtains LINK tokens either from collector or assumes they're already available
   */
  function _obtainLinkTokens(PayloadConfig memory config) internal virtual returns (uint256) {
    if (config.withdrawLinkFromCollector) {
      return
        config.collector.withdrawFromV3(
          CollectorUtils.IOInput({
            pool: address(config.pool),
            underlying: config.linkToken,
            amount: config.linkAmount
          }),
          address(this)
        );
    }
    return config.linkAmount;
  }

  function _encodeAgentIdToBytes(uint256 agentId) internal pure returns (bytes memory) {
    uint256[] memory agentIds = new uint256[](1);
    agentIds[0] = agentId;
    return abi.encode(agentIds);
  }
}
