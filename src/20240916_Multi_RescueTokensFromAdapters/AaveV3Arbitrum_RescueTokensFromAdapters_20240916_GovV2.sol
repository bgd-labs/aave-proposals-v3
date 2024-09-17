// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
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
contract AaveV3Arbitrum_RescueTokensFromAdapters_20240916_GovV2 is IProposalGenericExecutor {
  /// @dev previous versions of the adapters
  address public constant REPAY_WITH_COLLATERAL_ADAPTER_0 =
    0xB0526BFb4047aE1147DC7caAF3F1653904C2D568;

  function execute() external {
    // AaveV3Arbitrum previous
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER_0).rescueTokens(
      IERC20(AaveV3ArbitrumAssets.MAI_UNDERLYING)
    );
  }
}
