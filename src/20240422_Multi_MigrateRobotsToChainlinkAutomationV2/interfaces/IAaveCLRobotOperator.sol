// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IAaveCLRobotOperator
 * @author BGD Labs
 * @notice Defines the interface for the robot operator contract to perform admin actions on the automation keepers.
 **/
interface IAaveCLRobotOperator {
  /**
   * @dev Emitted when a keeper is registered using the operator contract.
   * @param id id of the keeper registered.
   * @param upkeep address of the keeper contract.
   * @param amount amount of link the keeper has been registered with.
   */
  event KeeperRegistered(uint256 indexed id, address indexed upkeep, uint96 indexed amount);

  /**
   * @dev Emitted when a keeper is cancelled using the operator contract.
   * @param id id of the keeper cancelled.
   * @param upkeep address of the keeper contract.
   */
  event KeeperCancelled(uint256 indexed id, address indexed upkeep);

  /**
   * @dev Emitted when a keeper is already cancelled, and link is being withdrawn using the operator contract.
   * @param id id of the keeper to withdraw link from.
   * @param upkeep address of the keeper contract.
   * @param to address where link needs to be withdrawn to.
   */
  event LinkWithdrawn(uint256 indexed id, address indexed upkeep, address indexed to);

  /**
   * @dev Emitted when a keeper is refilled using the operator contract.
   * @param id id of the keeper which has been refilled.
   * @param from address which refilled the keeper.
   * @param amount amount of link which has been refilled for the keeper.
   */
  event KeeperRefilled(uint256 indexed id, address indexed from, uint96 indexed amount);

  /**
   * @dev Emitted when a keeper is paused using the operator contract.
   * @param id id of the keeper which has been paused.
   */
  event KeeperPaused(uint256 indexed id);

  /**
   * @dev Emitted when a keeper is unpaused using the operator contract.
   * @param id id of the keeper which has been unpaused.
   */
  event KeeperUnpaused(uint256 indexed id);

  /**
   * @dev Emitted when the link withdraw address has been changed of the keeper.
   * @param newWithdrawAddress address of the new withdraw address where link will be withdrawn to.
   */
  event WithdrawAddressSet(address indexed newWithdrawAddress);

  /**
   * @dev Emitted when gas limit is configured using the operator contract.
   * @param id id of the keeper for which gas limit has been configured.
   * @param upkeep address of the keeper contract.
   * @param gasLimit max gas limit which has been configured for the keeper.
   */
  event GasLimitSet(uint256 indexed id, address indexed upkeep, uint32 indexed gasLimit);

  /**
   * @dev Emitted when trigger config is configured for a log type robot using the operator contract.
   * @param id id of the keeper for which trigger config has been configured.
   */
  event TriggerConfigSet(uint256 indexed id);

  /**
   * @dev Emitted when a new chainlink keeper registry is set on the operator contract.
   * @param newKeeperRegistry address of the new chainlink keeper registry contract.
   */
  event KeeperRegistrySet(address indexed newKeeperRegistry);

  /**
   * @dev Emitted when a new chainlink keeper registrar is set on the operator contract.
   * @param newKeeperRegistrar address of the new chainlink keeper registrar contract.
   */
  event KeeperRegistrarSet(address indexed newKeeperRegistrar);

  /**
   * @dev Emitted when a the keepers are migrated to a new chainlink keeper registry contract.
   * @param ids array of ids all the chainlink keepers to migrate.
   * @param newKeeperRegistry address of the new chainlink keeper registry contract to migrate to.
   * @param newKeeperRegistrar address of the new chainlink keeper registrar contract associated with the registry.
   */
  event KeepersMigrated(
    uint256[] indexed ids,
    address indexed newKeeperRegistry,
    address indexed newKeeperRegistrar
  );

  /**
   * @notice holds the keeper info registered via the operator.
   * @param upkeep address of the keeper contract registered.
   * @param name name of the registered keeper.
   */
  struct KeeperInfo {
    address upkeep;
    string name;
  }

  /**
   * @notice method called by owner to register the automation robot keeper.
   * @param name name of keeper.
   * @param upkeepContract upkeepContract of the keeper.
   * @param gasLimit max gasLimit which the chainlink automation node can execute for the automation.
   * @param amountToFund amount of link to fund the keeper with.
   * @param triggerType type of robot keeper to register, 0 for conditional and 1 for event log based.
   * @param triggerConfig encoded trigger config for event log based robots, unused for conditional type robots.
   * @return chainlink id for the registered keeper.
   **/
  function register(
    string memory name,
    address upkeepContract,
    uint32 gasLimit,
    uint96 amountToFund,
    uint8 triggerType,
    bytes memory triggerConfig
  ) external returns (uint256);

  /**
   * @notice method called to refill the keeper.
   * @param id - id of the chainlink registered keeper to refill.
   * @param amount - amount of LINK to refill the keeper with.
   **/
  function refillKeeper(uint256 id, uint96 amount) external;

  /**
   * @notice method called by the owner to cancel the automation robot keeper.
   * @param id - id of the chainlink registered keeper to cancel.
   **/
  function cancel(uint256 id) external;

  /**
   * @notice method called permissionlessly to withdraw link of automation robot keeper to the withdraw address.
   *         this method should only be called after the automation robot keeper is cancelled.
   * @param id - id of the chainlink registered keeper to withdraw funds of.
   **/
  function withdrawLink(uint256 id) external;

  /**
   * @notice method called by the owner to migrate the keepers to a newer version of chainlink automation.
   * @param newRegistry address of the new chainlink registry to migrate the keepers to.
   * @param newRegistrar address of the new associated chainlink registrar of the new registry.
   **/
  function migrate(address newRegistry, address newRegistrar) external;

  /**
   * @notice method called by owner / robot guardian to pause the upkeep robot keeper.
   * @param id - id of the chainlink registered keeper to pause.
   **/
  function pause(uint256 id) external;

  /**
   * @notice method called by owner / robot guardian to unpause the upkeep robot keeper.
   * @param id - id of the chainlink registered keeper to unpause.
   **/
  function unpause(uint256 id) external;

  /**
   * @notice method to check if the keeper is paused or not.
   * @param id - id of the chainlink registered keeper to check.
   * @return true if the keeper is paused, false otherwise.
   **/
  function isPaused(uint256 id) external returns (bool);

  /**
   * @notice method called by owner / robot guardian to set the max gasLimit of upkeep robot keeper.
   * @param id - id of the chainlink registered keeper to set the gasLimit.
   * @param gasLimit max gasLimit which the chainlink automation node can execute.
   **/
  function setGasLimit(uint256 id, uint32 gasLimit) external;

  /**
   * @notice method called by owner to set the withdraw address when withdrawing excess link from the automation robot keeeper.
   * @param withdrawAddress withdraw address to withdaw link to.
   **/
  function setWithdrawAddress(address withdrawAddress) external;

  /**
   * @notice method called by owner / guardian to set the trigger configuration for event log type robots.
   * @param id - id of the chainlink registered keeper to set the trigger config.
   * @param triggerConfig encoded data containing the configuration
   *        Ex:
   *        abi.encode(
   *          address contractAddress, (address that will be emitting the log)
   *          uint8 filterSelector, (denoting which topics apply to filter ex 000, 101, 111...only last 3 bits apply)
   *          bytes32 topic0, (signature of the emitted event)
   *          bytes32 topic1, (filter on indexed topic 1)
   *          bytes32 topic2, (filter on indexed topic 2)
   *          bytes32 topic3 (filter on indexed topic 3)
   *        );
   **/
  function setTriggerConfig(uint256 id, bytes calldata triggerConfig) external;

  /**
   * @notice method called by owner to set the address of chainlink keeper registry contract.
   * @param newRegistry address of the new chainlink keeper registry contract to set.
   */
  function setRegistry(address newRegistry) external;

  /**
   * @notice method called by owner to set the address of chainlink keeper registrar contract.
   * @param newRegistrar address of the new chainlink keeper registrar contract to set.
   */
  function setRegistrar(address newRegistrar) external;

  /**
   * @notice method to get the withdraw address for the robot operator contract.
   * @return withdraw address to send excess link to.
   **/
  function getWithdrawAddress() external view returns (address);

  /**
   * @notice method to get the keeper information registered via the operator.
   * @param id - id of the chainlink registered keeper.
   * @return Struct containing the following information about the keeper:
   *         - uint256 chainlink id of the registered keeper.
   *         - string name of the registered keeper.
   **/
  function getKeeperInfo(uint256 id) external view returns (KeeperInfo memory);

  /**
   * @notice method to get the address of chainlink keeper registry contract.
   * @return keeper registry address.
   */
  function getRegistry() external returns (address);

  /**
   * @notice method to get the address of chainlink keeper registrar contract.
   * @return keeper registrar address.
   */
  function getRegistrar() external returns (address);

  /**
   * @notice method to get the address of ERC-677 link token.
   * @return link token address.
   */
  function getLinkToken() external returns (address);

  /**
   * @notice method to get of all the ids of keepers registered by the robot operator which have not been cancelled.
   * @return array of registered keeper ids.
   */
  function getKeepersList() external returns (uint256[] memory);
}
