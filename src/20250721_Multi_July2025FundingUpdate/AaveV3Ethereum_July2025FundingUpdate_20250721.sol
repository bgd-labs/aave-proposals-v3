// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV3EthereumLidoAssets} from 'aave-address-book/AaveV3EthereumLido.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';

// https://etherscan.io/address/0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89#code#F1#L63
interface IMigrationActions {
  /**
   * @notice Migrate `assetsIn` of `DAI` to `USDS`.
   * @param  receiver The receiver of `USDS`.
   * @param  assetsIn The amount of `DAI` to migrate.
   */
  function migrateDAIToUSDS(address receiver, uint256 assetsIn) external;
}

/**
 * @title July 2025 - Funding Update
 * @author @TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/direct-to-aip-july-2025-funding-update/22555
 */
contract AaveV3Ethereum_July2025FundingUpdate_20250721 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  /// https://etherscan.io/address/0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e
  address public constant AHAB_SAFE = 0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e;
  uint256 public constant AHAB_ALLOWANCE_USDC_USDT = 250_000e6;
  uint256 public constant AHAB_ALLOWANCE_USDS_GHO = 250_000 ether;

  /// https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;

  /// https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  /// https://etherscan.io/address/0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89
  address public constant MIGRATION_ACTIONS = 0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89;

  function execute() external {
    _allowances();
    // _swaps();

    IMigrationActions(MIGRATION_ACTIONS).migrateDAIToUSDS(
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
  }

  function _swaps() internal {
    // DAI Swap
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.DAI_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        amount: IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ),
        slippage: 100
      })
    );

    // LUSD Swap
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.LUSD_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.LUSD_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        amount: IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ),
        slippage: 500
      })
    );

    // PyUSD Swap
    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.PYUSD_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        fromUnderlyingPriceFeed: AaveV3EthereumAssets.PYUSD_ORACLE,
        toUnderlyingPriceFeed: AaveV3EthereumAssets.USDC_ORACLE,
        amount: IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(
          address(AaveV3Ethereum.COLLECTOR)
        ),
        slippage: 200
      })
    );
  }

  function _allowances() internal {
    // Ahab aEthUSDT Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      AHAB_SAFE,
      AHAB_ALLOWANCE_USDC_USDT
    );

    // Ahab aEthUSDC Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      AHAB_SAFE,
      AHAB_ALLOWANCE_USDC_USDT
    );

    // Ahab aEthUSDS Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.USDS_A_TOKEN),
      AHAB_SAFE,
      AHAB_ALLOWANCE_USDS_GHO
    );

    // Ahab aEthGHO Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumLidoAssets.GHO_A_TOKEN),
      AHAB_SAFE,
      AHAB_ALLOWANCE_USDS_GHO
    );
  }
}
