// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

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
}
