// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IRootsConsumer
 * @author BGD Labs
 * @notice Defines the interface for the contract to fetch api response to register storage roots.
 **/
interface IRootsConsumer {
  /**
   * @notice method called by owner / robot guardian to set the robot keeper which can request to submit roots.
   * @param robotKeeper new address of the robot keeper to set.
   **/
  function setRobotKeeper(address robotKeeper) external;

  /**
   * @notice method to get the the robot keeper which can request to submit roots.
   * @return address of the robot keeeper contract.
   */
  function getRobotKeeper() external view returns (address);
}
