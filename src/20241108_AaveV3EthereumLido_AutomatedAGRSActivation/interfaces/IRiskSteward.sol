// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title IRiskSteward
 * @author BGD labs
 * @notice Defines the interface for the contract to manage the risk params updates on aave v3 pool
 */
interface IRiskSteward {
  /**
   * @notice The safe controlling the steward
   */
  function RISK_COUNCIL() external view returns (address);
}
