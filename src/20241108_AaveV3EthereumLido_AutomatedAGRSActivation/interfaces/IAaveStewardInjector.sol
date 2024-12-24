// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {AutomationCompatibleInterface} from './AutomationCompatibleInterface.sol';

/**
 * @title IAaveStewardInjector
 * @author BGD Labs
 * @notice Defines the interface for the injector contract to automate actions for Risk Steward.
 **/
interface IAaveStewardInjector is AutomationCompatibleInterface {
  /**
   * @notice Emitted when performUpkeep is called and an update is injected into the risk steward.
   * @param updateId the risk oracle update id injected into the risk steward.
   */
  event ActionSucceeded(uint256 indexed updateId);

  /**
   * @notice Emitted when injection of a updateId is disabled/enabled.
   * @param updateId the risk oracle update id for which automation is disabled/enabled.
   * @param disabled true if updateId is disabled, false otherwise.
   */
  event UpdateDisabled(uint256 indexed updateId, bool indexed disabled);

  /**
   * @notice The following update cannot be injected in the steward injector because the conditions are not met.
   */
  error UpdateCannotBeInjected();

  /**
   * @notice method to check if injection of a updateId on risk steward is disabled.
   * @param updateId updateId from risk oracle to check if disabled.
   * @return bool if updateId is disabled or not.
   **/
  function isDisabled(uint256 updateId) external view returns (bool);

  /**
   * @notice method called by owner to disable/enabled injection of a updateId on risk steward.
   * @param updateId updateId from risk oracle for which we need to disable/enable injection.
   * @param disabled true if updateId should be disabled, false otherwise.
   */
  function disableUpdateById(uint256 updateId, bool disabled) external;

  /**
   * @notice method to check if the updateId from the risk oracle has been executed/injected into the risk steward.
   * @param updateid the updateId from the risk oracle to check if already executed/injected.
   * @return bool true if the updateId is executed/injected, false otherwise.
   */
  function isUpdateIdExecuted(uint256 updateid) external view returns (bool);

  /**
   * @notice method to get the address of the edge risk oracle contract.
   * @return edge risk oracle contract address.
   */
  function RISK_ORACLE() external view returns (address);

  /**
   * @notice method to get the address of the aave risk steward contract.
   * @return aave risk steward contract address.
   */
  function RISK_STEWARD() external view returns (address);

  /**
   * @notice method to get the expiration time for an update from the risk oracle.
   * @return time in seconds of the expiration time.
   */
  function EXPIRATION_PERIOD() external view returns (uint256);

  /**
   * @notice method to get the whitelisted update type for which injection is allowed from the risk oracle into the stewards.
   * @return string for the whitelisted update type - interest rate update.
   */
  function WHITELISTED_UPDATE_TYPE() external view returns (string memory);

  /**
   * @notice method to get the whitelisted asset for which injection is allowed from the risk oracle into the stewards.
   * @return address for the whitelisted asset.
   */
  function WHITELISTED_ASSET() external view returns (address);
}
