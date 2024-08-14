// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IAaveCLRobotOperator
 * @author BGD Labs
 * @notice Defines the interface for the robot operator contract to perform admin actions on the automation keepers.
 **/
interface IAaveCLRobotOperator {
  /**
   * @notice method called by owner to register the automation robot keeper.
   * @param name name of keeper.
   * @param upkeepContract upkeepContract of the keeper.
   * @param upkeepCheckData checkData of the keeper which get passed to the checkUpkeep.
   * @param gasLimit max gasLimit which the chainlink automation node can execute for the automation.
   * @param amountToFund amount of link to fund the keeper with.
   * @param triggerType type of robot keeper to register, 0 for conditional and 1 for event log based.
   * @param triggerConfig encoded trigger config for event log based robots, unused for conditional type robots.
   * @return chainlink id for the registered keeper.
   **/
  function register(
    string calldata name,
    address upkeepContract,
    bytes calldata upkeepCheckData,
    uint32 gasLimit,
    uint96 amountToFund,
    uint8 triggerType,
    bytes calldata triggerConfig
  ) external returns (uint256);

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
}
