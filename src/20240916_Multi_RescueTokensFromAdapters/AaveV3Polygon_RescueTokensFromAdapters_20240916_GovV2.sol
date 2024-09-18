// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Polygon, AaveV3PolygonAssets} from 'aave-address-book/AaveV3Polygon.sol';
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
contract AaveV3Polygon_RescueTokensFromAdapters_20240916_GovV2 is IProposalGenericExecutor {
  /// @dev previous versions of the adapters
  address public constant ADAPTER_0 = 0x10D2fA27166d94894d850a9a851EE06870F14b09;

  function execute() external {
    // AaveV3Polygon previous
    IRescuable(ADAPTER_0).rescueTokens(IERC20(AaveV3PolygonAssets.EURA_UNDERLYING));
    IRescuable(ADAPTER_0).rescueTokens(IERC20(AaveV3PolygonAssets.CRV_UNDERLYING));
    IRescuable(ADAPTER_0).rescueTokens(IERC20(AaveV3PolygonAssets.miMATIC_UNDERLYING));
  }
}
