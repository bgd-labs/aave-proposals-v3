// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Avalanche, AaveV3AvalancheAssets} from 'aave-address-book/AaveV3Avalanche.sol';
import {IERC20} from 'aave-v3-core/contracts/dependencies/openzeppelin/contracts/IERC20.sol';

/**
 * @title Minimal IRescuable
 * @notice Defines the minimal basic interface for rescuable tokens mechanism
 **/
interface IRescuable {
  /**
   * @notice Emergency rescue for token stucked on this contract, as failsafe mechanism
   * @dev Funds should never remain in this contract more time than during transactions
   * @dev Only callable by the owner
   * @param token The address of the stucked token to rescue
   */
  function rescueTokens(IERC20 token) external;
}

/**
 * @title RescueTokensFromAdapters
 * @author Aave Labs
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Avalanche_RescueTokensFromAdapters_20240916 is IProposalGenericExecutor {
  /// @dev previous versions of the adapters
  address public constant ADAPTER_0 = 0x49F5B996814fEd1dd39285B92A59CFb2dfd8D4f9;
  function execute() external {
    IRescuable(ADAPTER_0).rescueTokens(IERC20(AaveV3AvalancheAssets.WBTCe_UNDERLYING));
  }
}
