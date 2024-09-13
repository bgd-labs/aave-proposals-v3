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
 * @title AddAdapterAsFlashBorrowerAndRevokePrevious
 * @author Aave Labs
 * - Snapshot: TODO
 * - Discussion: https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821
 */
contract AaveV3Avalanche_AddAdapterAsFlashBorrowerAndRevokePrevious_20240912 is
  IProposalGenericExecutor
{
  address public constant NEW_FLASH_BORROWER = 0x0000000000000000000000000000000000000001;

  function execute() external {
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.USDC_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.USDt_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.WAVAX_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.BTCb_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.WETHe_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.DAIe_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.FRAX_UNDERLYING)
    );
    IRescuable(AaveV3Avalanche.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3AvalancheAssets.LINKe_UNDERLYING)
    );

    AaveV3Avalanche.ACL_MANAGER.removeFlashBorrower(AaveV3Avalanche.DEBT_SWAP_ADAPTER);
    AaveV3Avalanche.ACL_MANAGER.addFlashBorrower(NEW_FLASH_BORROWER);
  }
}
