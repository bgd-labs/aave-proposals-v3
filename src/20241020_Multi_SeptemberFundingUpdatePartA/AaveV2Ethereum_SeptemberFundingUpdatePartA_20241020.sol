// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
/**
 * @title September Funding Update Part A
 * @author @karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant DEBT_SWAP_ADAPTER = 0x6A6FA664D4Fa49a6a780a1D6143f079f8dd7C33d;
  address public constant DEBT_SWAP_ADAPTER_V3 = 0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68;
  address public constant REPAY_WITH_COLLATERAL_ADAPTER =
    0x02e7B8511831B1b02d9018215a0f8f500Ea5c6B3;
  address public constant KARPATKEY = 0x818C277dBE886b934e60aa047250A73529E26A99;

  uint256 public constant GAS_REBATE_AMOUNT = 0.264 ether;

  function execute() external {
    _rescueParaswap();

    // Gas Rebase Karpatkey
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      KARPATKEY,
      GAS_REBATE_AMOUNT
    );
  }

  function _rescueParaswap() internal {
    IRescuable(DEBT_SWAP_ADAPTER).rescueTokens(IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING));
    IRescuable(DEBT_SWAP_ADAPTER).rescueTokens(IERC20(AaveV2EthereumAssets.USDC_UNDERLYING));
    IRescuable(DEBT_SWAP_ADAPTER_V3).rescueTokens(IERC20(AaveV3EthereumAssets.USDT_UNDERLYING));
    IRescuable(DEBT_SWAP_ADAPTER_V3).rescueTokens(IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING));
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING)
    );
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING)
    );
    IRescuable(REPAY_WITH_COLLATERAL_ADAPTER).rescueTokens(
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING)
    );

    IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.sUSD_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV2EthereumAssets.USDC_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.crvUSD_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.GHO_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).transfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.WBTC_UNDERLYING).balanceOf(address(this))
    );
    IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).safeTransfer(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(this))
    );
  }
}

interface IRescuable {
  /**
   * @notice Emergency rescue for token stuck on this contract, as failsafe mechanism
   * @dev Funds should never remain in this contract more time than during transactions
   * @dev Only callable by the owner
   * @param token The address of the stuck token to rescue
   */
  function rescueTokens(IERC20 token) external;
}
