// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
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
contract AaveV3Ethereum_RescueTokensFromAdapters_20240916 is IProposalGenericExecutor {
  /// @dev previous versions of the adapters
  // address public constant REPAY_WITH_COLLATERAL_ADAPTER_0 =
  //   0x1809f186D680f239420B56948C58F8DbbCdf1E18;
  address public constant REPAY_WITH_COLLATERAL_ADAPTER_1 =
    0x02e7B8511831B1b02d9018215a0f8f500Ea5c6B3;

  function execute() external {
    // AaveV2Ethereum current
    IRescuable(AaveV2Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING)
    );
    IRescuable(AaveV2Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING)
    );

    // AaveV3Ethereum current
    IRescuable(AaveV3Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING)
    );
    IRescuable(AaveV3Ethereum.DEBT_SWAP_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING)
    );

    // AaveV3Ethereum previous
    // IRescuable(REPAY_WITH_COLLATERAL_ADAPTER_0).rescueTokens(
    //   IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING)
    // );
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER_1).rescueTokens(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING)
    );
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER_1).rescueTokens(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING)
    );
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER_1).rescueTokens(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING)
    );
  }
}
