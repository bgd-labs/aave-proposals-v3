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
  struct Balance {
    uint256 sUSD;
    uint256 USDC;
    uint256 USDT;
    uint256 crvUSD;
    uint256 GHO;
    uint256 rETH;
    uint256 WBTC;
  }

  function execute() external {
    Balance memory balanceToRescue = Balance({
      sUSD: IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(
        AaveV2Ethereum.DEBT_SWAP_ADAPTER
      ),
      USDC: IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(
        AaveV2Ethereum.DEBT_SWAP_ADAPTER
      ),
      USDT: IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
        AaveV3Ethereum.DEBT_SWAP_ADAPTER
      ),
      crvUSD: IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(
        AaveV3Ethereum.DEBT_SWAP_ADAPTER
      ),
      GHO: IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(
        AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
      ),
      rETH: IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
        AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
      ),
      WBTC: IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(
        AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER
      )
    });

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
    IRescuable(AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING)
    );
    IRescuable(AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING)
    );
    IRescuable(AaveV3Ethereum.REPAY_WITH_COLLATERAL_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING)
    );

    // Transfer to COLLECTOR
    IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      balanceToRescue.sUSD
    );
    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      balanceToRescue.USDC
    );
    // IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).transfer(
    //   address(AaveV3Ethereum.COLLECTOR),
    //   balanceToRescue.USDT
    // );
    IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      balanceToRescue.crvUSD
    );
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      balanceToRescue.GHO
    );
    IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      balanceToRescue.rETH
    );
    IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      balanceToRescue.WBTC
    );
  }
}
