// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IAgentConfigurator
 * @author BGD labs
 * @notice Defines the interface for the AgentConfigurator contract
 */
interface IAgentConfigurator {
  /**
   * @notice The caller account is not the owner or agent admin
   */
  error OnlyOwnerOrAgentAdmin(address account);

  /**
   * @notice Cannot set the hub address or agent contract address as agent admin
   */
  error InvalidAgentAdmin(address agentAdmin);

  /**
   * @notice Struct storing the agent registration input when registering the agent
   */
  struct AgentRegistrationInput {
    address admin;
    address riskOracle;
    bool isAgentEnabled;
    bool isAgentPermissioned;
    bool isMarketsFromAgentEnabled;
    address agentAddress;
    uint256 expirationPeriod;
    uint256 minimumDelay;
    string updateType;
    bytes agentContext;
    address[] allowedMarkets;
    address[] restrictedMarkets;
    address[] permissionedSenders;
  }

  /**
   * @notice Struct storing the last injected update for an agent-market pair
   */
  struct LastInjectedUpdate {
    uint48 timestamp;
    uint208 id;
  }

  /**
   * @notice Emitted when an updateId is injected from the risk oracle
   * @param agentId the id of the agent for which the update was injected
   * @param market the market address where update was injected
   * @param updateType the type of the update which was injected
   * @param updateId the id of the update corresponding to the risk oracle
   * @param newValue the new value fetched from the risk oracle which is injected
   */
  event UpdateInjected(
    uint256 indexed agentId,
    address indexed market,
    string indexed updateType,
    uint256 updateId,
    bytes newValue
  );

  /**
   * @notice Emitted when the owner registers a new agent
   * @param agentId the id of the new agent registered
   * @param riskOracle the address of the risk oracle to consume updates
   * @param updateType the string reference of the updates which will be consumed
   */
  event AgentRegistered(
    uint256 indexed agentId,
    address indexed riskOracle,
    string indexed updateType
  );

  /**
   * @notice Emitted when the owner sets agent admin for an agent
   * @param agentId the id of the agent for which new agent admin is set
   * @param admin the address of the new admin set for the agent
   */
  event AgentAdminSet(uint256 indexed agentId, address indexed admin);

  /**
   * @notice Emitted when the owner sets the max batch size
   * @param maxBatchSize the max batch size of updates set for injection across all agent in one `execute()` call
   */
  event MaxBatchSizeSet(uint256 indexed maxBatchSize);

  /**
   * @notice Emitted when the agent admin sets a agent contract for an agent
   * @param agentId the id of the agent for which the agent contract is set
   * @param agentAddress the address of the agent contract set
   */
  event AgentAddressSet(uint256 indexed agentId, address indexed agentAddress);

  /**
   * @notice Emitted when the agent admin sets the permissioned status for the agent
   * @param agentId the id of the agent for which the permissioned status is set
   * @param isAgentPermissioned true if the agent is permissioned, false otherwise
   */
  event AgentPermissionedStatusSet(uint256 indexed agentId, bool indexed isAgentPermissioned);

  /**
   * @notice Emitted when the agent admin adds a permissioned sender
   * @param agentId the id of the agent for which permissioned sender is added
   * @param sender address of the sender which is permissioned for the agent
   */
  event PermissionedSenderAdded(uint256 indexed agentId, address indexed sender);

  /**
   * @notice Emitted when the agent admin removes a permissioned sender
   * @param agentId the id of the agent for which permissioned sender is removed
   * @param sender address of the sender for which permissioned sender is removed for the agent
   */
  event PermissionedSenderRemoved(uint256 indexed agentId, address indexed sender);

  /**
   * @notice Emitted when the agent admin adds a allowed market for the agent
   * @param agentId the id of the agent for which the allowed market is added
   * @param market the address of the allowed market added
   */
  event AllowedMarketAdded(uint256 indexed agentId, address indexed market);

  /**
   * @notice Emitted when the agent admin removes a allowed market for the agent
   * @param agentId the id of the agent for which the allowed market is removed
   * @param market the address of the allowed market removed
   */
  event AllowedMarketRemoved(uint256 indexed agentId, address indexed market);

  /**
   * @notice Emitted when the agent admin adds a restricted market for the agent
   * @param agentId the id of the agent for which the restricted market is added
   * @param market the address of the restricted market added
   */
  event RestrictedMarketAdded(uint256 indexed agentId, address indexed market);

  /**
   * @notice Emitted when the agent admin removes a restricted market for the agent
   * @param agentId the id of the agent for which the restricted market is removed
   * @param market the address of the restricted market removed
   */
  event RestrictedMarketRemoved(uint256 indexed agentId, address indexed market);

  /**
   * @notice Emitted when the agent admin sets the expiration period of the agent
   * @param agentId the id of the agent for which expiration period is set
   * @param expirationPeriod the expiration period set
   */
  event ExpirationPeriodSet(uint256 indexed agentId, uint256 indexed expirationPeriod);

  /**
   * @notice Emitted when the agent admin sets the enable status for the agent
   * @param agentId the id of the agent for which enable status is set
   * @param enable true if the agent is set as enabled, false otherwise
   */
  event AgentEnabledSet(uint256 indexed agentId, bool indexed enable);

  /**
   * @notice Emitted when the agent admin sets the minimum delay of the agent
   * @param agentId the id of the agent for which minimum delay is set
   * @param minimumDelay the minimum delay set
   */
  event MinimumDelaySet(uint256 indexed agentId, uint256 indexed minimumDelay);

  /**
   * @notice Emitted when the agent admin sets the agent context of the agent
   * @param agentId the id of the agent for which agent context is set
   * @param context the context set for the agent in bytes
   */
  event AgentContextSet(uint256 indexed agentId, bytes indexed context);

  /**
   * @notice Emitted when the agent admin sets isMarketsFromAgentEnabled flag
   * @param agentId the id of the agent for which isMarketsFromAgentEnabled flag is set
   * @param enabled true if flag set to fetch markets from the agent contract, false if to fetch from the hub
   */
  event MarketsFromAgentEnabled(uint256 indexed agentId, bool indexed enabled);

  /**
   * @notice method called by the owner to register a new agent
   * @param registrationInput the initial configuration for the agent to register
   * @return agentId the id for the agent registered
   */
  function registerAgent(
    AgentRegistrationInput calldata registrationInput
  ) external returns (uint256);

  /**
   * @notice method called by the admin address to set a new agent admin address
   * @param agentId the id of the agent for which to set the admin address
   * @param admin the address of the new agent admin to set
   */
  function setAgentAdmin(uint256 agentId, address admin) external;

  /**
   * @notice method called by the owner to set the max batch size for injection across all agents in one `execute()` call
   * @param maxBatchSize the max batch size of updates for injection across all agents in one `execute()` call
   * @dev the max batch size is enforced on the `check()` as a soft measure to ensure only the
   *      max batch size number of updates gets injected in one `execute()` call
   *      max batch size of 0 denotes max batch size enforcement is disabled i.e all valid updates will be injected in one `execute()`
   */
  function setMaxBatchSize(uint256 maxBatchSize) external;

  /**
   * @notice method called by the owner to set the agent contract address
   * @param agentId the id of the agent for which the agent contract is set
   * @param agentAddress the address of the agent contract to set which does postValidation and injection
   */
  function setAgentAddress(uint256 agentId, address agentAddress) external;

  /**
   * @notice method called by the agent admin to set if the agent is permissioned or not
   * @param agentId the id of the agent to set the permissioned status
   * @param isAgentPermissioned true if the agent is permissioned, false otherwise
   */
  function setAgentAsPermissioned(uint256 agentId, bool isAgentPermissioned) external;

  /**
   * @notice method called by the agent admin to add permissioned sender
   * @param agentId the id of the agent for which to add permissioned sender
   * @param sender address of the sender to allow calling `execute()` for the agent
   */
  function addPermissionedSender(uint256 agentId, address sender) external;

  /**
   * @notice method called by the agent admin to remove permissioned sender
   * @param agentId the id of the agent for which to remove permissioned sender
   * @param sender address of the sender to remove from calling `execute()` for the agent
   */
  function removePermissionedSender(uint256 agentId, address sender) external;

  /**
   * @notice method called by the agent admin to add allowed market for the agent
   * @param agentId the id of the agent for which to add allowed market
   * @param market the address of the allowed market to add
   * @dev if isMarketsFromAgentEnabled config is false, configured markets for the agent
   *      will be the allowed markets from hub and restricted markets will be ignored.
   */
  function addAllowedMarket(uint256 agentId, address market) external;

  /**
   * @notice method called by the agent admin to remove allowed market for the agent
   * @param agentId the id of the agent for which to remove allowed market
   * @param market the address of the allowed to remove
   * @dev if isMarketsFromAgentEnabled config is false, configured markets for the agent
   *      will be the allowed markets from hub and restricted markets will be ignored.
   */
  function removeAllowedMarket(uint256 agentId, address market) external;

  /**
   * @notice method called by the agent admin to add restricted market for the agent
   * @param agentId the id of the agent for which to add restricted market
   * @param market the address of the restricted market to add
   * @dev if isMarketsFromAgentEnabled config is true, configured markets for that agent
   *      will be fetched from the agent contract and filtered by the restricted markets,
   *      allowed markets in this case will be unused and ignored
   */
  function addRestrictedMarket(uint256 agentId, address market) external;

  /**
   * @notice method called by the agent admin to remove restricted market for the agent
   * @param agentId the id of the agent for which to remove restricted market
   * @param market the address of the restricted market to remove
   * @dev if isMarketsFromAgentEnabled config is true, configured markets for that agent
   *      will be fetched from the agent contract and filtered by the restricted markets,
   *      allowed markets in this case will be unused and ignored
   */
  function removeRestrictedMarket(uint256 agentId, address market) external;

  /**
   * @notice method called by the agent admin to set the expiration period for the agent
   * @param agentId the id of the agent to set expiration period
   * @param expirationPeriod expiration period of the agent to set in seconds
   */
  function setExpirationPeriod(uint256 agentId, uint256 expirationPeriod) external;

  /**
   * @notice method called by the agent admin to set the enabled status for the agent
   * @param agentId the id of the agent to set enabled status
   * @param enable true if the agent is set as enabled, false otherwise
   */
  function setAgentEnabled(uint256 agentId, bool enable) external;

  /**
   * @notice method called by the agent admin to set the minimum delay for the agent
   * @param agentId the id of the agent to set minimum delay
   * @param minimumDelay minimum delay of the agent to set in seconds
   */
  function setMinimumDelay(uint256 agentId, uint256 minimumDelay) external;

  /**
   * @notice method to set the agent context
   *         agent context could be used to store injection/validation configuration which used by the agent contract
   * @param agentId the id of the agent for which to set the agent context
   * @param context the agent context to set for the agent in bytes
   */
  function setAgentContext(uint256 agentId, bytes calldata context) external;

  /**
   * @notice method to set if markets used for injection should be fetched from the agent contract or hub
   * @param agentId the id of the agent for which to set the isMarketsFromAgentEnabled flag
   * @param enabled true if configured markets should be fetched from the agent, false if it should be fetched from the hub
   * @dev if isMarketsFromAgentEnabled is false, the markets to fetch for injection is queried from the hub via allowedMarkets,
   *      if isMarketsFromAgentEnabled is true, the markets to fetch for injection is queried from the agent contract
   *      please note allowedMarkets is only used when isMarketsFromAgentEnabled is set to false, and restrictedMarkets
   *      is only applied when isMarketsFromAgentEnabled is true to filter out the markets from agent
   */
  function setMarketsFromAgentEnabled(uint256 agentId, bool enabled) external;

  /**
   * @notice method to get the admin address for an agent which can configure params
   * @param agentId the id of the agent for which to get the admin address
   * @return address of the agent admin
   */
  function getAgentAdmin(uint256 agentId) external view returns (address);

  /**
   * @notice method to get the max batch size for injection across all agent in one `execute()` call
   * @return the max batch size of updates for injection across all agents in one `execute()` call
   * @dev the max batch size is enforced on the `check()` as a soft measure to ensure only the
   *      max batch size number of updates gets injected in one `execute()` call
   *      max batch size of 0 denotes max batch size enforcement is disabled i.e all valid updates will be injected in one `execute()`
   */
  function getMaxBatchSize() external view returns (uint256);

  /**
   * @notice method to get the configured agent contract address
   * @param agentId the id of the agent to get the configured agent contract
   * @return address of the agent contract
   */
  function getAgentAddress(uint256 agentId) external view returns (address);

  /**
   * @notice method to get if the agent is permissioned or not
   * @param agentId the id of the agent to get the permissioned status
   * @return true if the agent is permissioned, false otherwise
   */
  function isAgentPermissioned(uint256 agentId) external view returns (bool);

  /**
   * @notice method to get the permissioned senders for the agents, only valid if the agent is permissioned
   * @param agentId the id of the agent to get the permissioned senders
   * @return list of addresses of the permissioned senders for the agent
   */
  function getPermissionedSenders(uint256 agentId) external view returns (address[] memory);

  /**
   * @notice method to get if the sender is allowed for the agent, only valid if the agent is permissioned
   * @param agentId the id of the agent to check if the sender is allowed
   * @return true if the sender is allowed, false otherwise
   */
  function isPermissionedSender(uint256 agentId, address sender) external view returns (bool);

  /**
   * @notice method to get the list of allowed markets for the agent
   * @param agentId the id of the agent to get the allowed markets
   * @return list of allowed market addresses for the agent
   * @dev if isMarketsFromAgentEnabled config is false, configured markets for the agent
   *      will be the allowed markets from hub and restricted markets will be ignored.
   */
  function getAllowedMarkets(uint256 agentId) external view returns (address[] memory);

  /**
   * @notice method to get the list of restricted markets for the agent
   * @param agentId the id of the agent to get the restricted markets
   * @return list of restricted market addresses for the agent
   * @dev if isMarketsFromAgentEnabled config is true, configured markets for that agent
   *      will be fetched from the agent contract and filtered by the restricted markets,
   *      allowed markets in this case will be unused and ignored
   */
  function getRestrictedMarkets(uint256 agentId) external view returns (address[] memory);

  /**
   * @notice method to get the expiration period for the agent
   *         expiration period is the time in seconds since update was added on risk oracle
   *         within which update can be injected
   * @param agentId the id of the agent to get expiration period
   * @return expiration period of the agent in seconds
   */
  function getExpirationPeriod(uint256 agentId) external view returns (uint256);

  /**
   * @notice method to get if the agent is enabled or not
   * @param agentId the id of the agent to get enabled status
   * @return true if the agent is enabled, false otherwise
   */
  function isAgentEnabled(uint256 agentId) external view returns (bool);

  /**
   * @notice method to get the minimum delay for the agent
   *         minimum delay is the time in seconds since the lastUpdateTimestamp of an market and updateType
   *         which should pass before an update is allowed to be injected again
   * @param agentId the id of the agent to get minimum delay
   * @return minimum delay of the agent in seconds
   */
  function getMinimumDelay(uint256 agentId) external view returns (uint256);

  /**
   * @notice method to get the agent context
   *         agent context could be used to store injection/validation configuration which used by the agent contract
   * @param agentId the id of the agent for which to set the agent context
   * @return the agent context of the agent in bytes
   */
  function getAgentContext(uint256 agentId) external view returns (bytes memory);

  /**
   * @notice method to get if markets used for injection should be fetched from the agent contract or hub
   * @param agentId the id of the agent for which to get the isMarketsFromAgentEnabled flag
   * @return true if configured markets should be fetched from the agent, false if it should be fetched from the hub
   * @dev if isMarketsFromAgentEnabled is false, the markets to fetch for injection is queried from the hub via allowedMarkets,
   *      if isMarketsFromAgentEnabled is true, the markets to fetch for injection is queried from the agent contract
   *      please note allowedMarkets is only used when isMarketsFromAgentEnabled is set to false, and restrictedMarkets
   *      is only applied when isMarketsFromAgentEnabled is true to filter out the markets from agent
   */
  function isMarketsFromAgentEnabled(uint256 agentId) external view returns (bool);

  /**
   * @notice method to get the update type for the agent
   * @param agentId the id of the agent for which to get the update type
   * @return the update type configured for the agent
   */
  function getUpdateType(uint256 agentId) external view returns (string memory);

  /**
   * @notice method to get the address of chaos risk oracle for the agent
   * @param agentId the id of the agent to get the chaos risk oracle
   * @return address of the chaos risk oracle configured for the agent
   */
  function getRiskOracle(uint256 agentId) external view returns (address);

  /**
   * @notice method to get the total number of agents registered on the agent hub
   * @return the total count of the agents registered
   */
  function getAgentCount() external view returns (uint256);

  /**
   * @notice method to get last updated data for an agent and market pair
   * @param agentId the id of the agent to get the last updated data
   * @param market the address of the market to get the last updated data
   * @return last updated data struct, including the latest updated timestamp and latest updated id
   *         which was injected for the agentId and market pair
   */
  function getLastInjectedUpdate(
    uint256 agentId,
    address market
  ) external view returns (LastInjectedUpdate memory);
}
