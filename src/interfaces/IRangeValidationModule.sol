// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IRangeValidationModule
 * @author BGD labs
 * @notice Defines the interface for the RangeValidationModule, used to validate ranges across agents
 */
interface IRangeValidationModule {
  /**
   * @notice The caller account is not the hub owner or agent admin
   */
  error OnlyHubOwnerOrAgentAdmin(address account);

  /**
   * @notice Relative decrease configured cannot be more than 100%
   */
  error InvalidMaxRelativeDecrease(uint256 maxDecrease);

  /**
   * @notice Emitted when the agent admin of the hub sets the default range config for an agent
   * @param agentHub the address of the agentHub
   * @param agentId the id of the agent
   * @param updateType the type of the update
   * @param config the range config set
   */
  event DefaultRangeConfigSet(
    address indexed agentHub,
    uint256 indexed agentId,
    string indexed updateType,
    RangeConfig config
  );

  /**
   * @notice Emitted when the agent admin of the hub sets the range config for a specific market
   * @param agentHub the address of the agentHub
   * @param agentId the id of the agent
   * @param market the address of the market
   * @param updateType the type of the update
   * @param config the range config set
   */
  event MarketRangeConfigSet(
    address indexed agentHub,
    uint256 indexed agentId,
    address indexed market,
    string updateType,
    RangeConfig config
  );

  /**
   * @notice Struct storing the range configuration for the agent
   */
  struct RangeConfig {
    uint120 maxIncrease; // When increase is relative, maxIncrease should be stored in BPS format. (ex. 5_00 for 5%)
    uint120 maxDecrease; // When decrease is relative, maxDecrease should be stored in BPS format. (ex. 5_00 for 5%)
    bool isIncreaseRelative;
    bool isDecreaseRelative;
  }

  /**
   * @notice Struct storing the params used for validation of the ranges
   */
  struct RangeValidationInput {
    uint256 from;
    uint256 to;
    string updateType;
  }

  /**
   * @notice method called by the agent to validate range
   * @param agentHub address of the agentHub contract of the agent
   * @param agentId id of the agent configured on the agentHub
   * @param market address of the market for parameters to apply
   * @param input values to validate range
   * @return output returning true if validation passes, false otherwise
   */
  function validate(
    address agentHub,
    uint256 agentId,
    address market,
    RangeValidationInput calldata input
  ) external view returns (bool);

  /**
   * @notice method called by the agent to validate range
   * @param agentHub address of the agentHub contract of the agent
   * @param agentId id of the agent configured on the agentHub
   * @param market address of the market for parameters to apply
   * @param input array of values to validate range
   * @return output returning true if validation passes, false otherwise
   */
  function validate(
    address agentHub,
    uint256 agentId,
    address market,
    RangeValidationInput[] calldata input
  ) external view returns (bool);

  /**
   * @notice method to set the default range configuration, can be called only by the agentAdmin
   * @param agentHub address of the agentHub contract of the agent
   * @param agentId id of the agent configured on the agentHub
   * @param updateType type of the update for which to set configuration
   * @param config the range configuration to set
   */
  function setDefaultRangeConfig(
    address agentHub,
    uint256 agentId,
    string calldata updateType,
    RangeConfig calldata config
  ) external;

  /**
   * @notice method to set the range configuration for a specific market, can be called only by the agentAdmin
   * @param agentHub address of the agentHub contract of the agent
   * @param agentId id of the agent configured on the agentHub
   * @param market market address for which to set configuration
   * @param updateType type of the update for which to set configuration
   * @param config the range configuration to set
   */
  function setRangeConfigByMarket(
    address agentHub,
    uint256 agentId,
    address market,
    string calldata updateType,
    RangeConfig calldata config
  ) external;

  /**
   * @notice method to get the default range configuration
   * @param agentHub address of the agentHub contract of the agent
   * @param agentId id of the agent configured on the agentHub
   * @param updateType type of the update for which to get configuration
   * @return the range configuration
   */
  function getDefaultRangeConfig(
    address agentHub,
    uint256 agentId,
    string calldata updateType
  ) external view returns (RangeConfig memory);

  /**
   * @notice method to get the range configuration for a specific market
   * @param agentHub address of the agentHub contract of the agent
   * @param agentId id of the agent configured on the agentHub
   * @param market market address for which to get configuration
   * @param updateType type of the update for which to get configuration
   * @return the range configuration
   */
  function getRangeConfigByMarket(
    address agentHub,
    uint256 agentId,
    address market,
    string calldata updateType
  ) external view returns (RangeConfig memory);
}
