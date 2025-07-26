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
 * - Snapshot Orbit: https://snapshot.box/#/s:aavedao.eth/proposal/0x2b497f613d426aa0f641fcd445132148b4faa81ad0c9c054e1062be886f45cdd
 * - Discussion Orbit: https://governance.aave.com/t/arfc-orbit-program-renewal-q2-2025/22497/1
 */
contract AaveV3Ethereum_July2025FundingUpdate_20250721 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  /// https://etherscan.io/address/0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e
  address public constant AHAB_SAFE = 0xAA2461f0f0A3dE5fEAF3273eAe16DEF861cf594e;
  uint256 public constant AHAB_ALLOWANCE_USDC_USDT = 250_000e6;
  uint256 public constant AHAB_ALLOWANCE_USDS_GHO = 250_000 ether;

  /// AAVE Buybacks allowance
  uint256 public constant AFC_USDC_ALLOWANCE = 2_000_000e6;
  uint256 public constant AFC_USDT_ALLOWANCE = 2_000_000e6;

  /// https://etherscan.io/address/0x060373D064d0168931dE2AB8DDA7410923d06E88
  address public constant MILKMAN = 0x060373D064d0168931dE2AB8DDA7410923d06E88;

  /// https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  /// https://etherscan.io/address/0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89
  address public constant MIGRATION_ACTIONS = 0xf86141a5657Cf52AEB3E30eBccA5Ad3a8f714B89;

  /// Orbit Renewal
  uint256 public constant STREAM_DURATION = 90 days;
  uint256 public constant STREAM_AMOUNT = 15_000 ether; // Total Budget is 45,000 GHO

  address public constant EZREAL = 0x8659D0BB123Da6D16D9394C7838BA286c2207d0E;
  address public constant STABLE_LABS = 0xECC2a9240268BC7a26386ecB49E1Befca2706AC9;
  address public constant IGNAS_DEFI = 0x3DDC7d25c7a1dc381443e491Bbf1Caa8928A05B0;

  uint256 public constant ACI_REFUND_AMOUNT = 0.4561 ether;

  function execute() external {
    _allowances();
    _swaps();
    _orbitRenewal();

    // ACI Refund
    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.WETH_UNDERLYING),
      MiscEthereum.MASIV_SAFE,
      ACI_REFUND_AMOUNT
    );
  }

  function _swaps() internal {
    // DAI Swap
    uint256 daiAmount = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING),
      address(this),
      daiAmount
    );

    IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).approve(MIGRATION_ACTIONS, daiAmount);
    IMigrationActions(MIGRATION_ACTIONS).migrateDAIToUSDS(
      address(AaveV3Ethereum.COLLECTOR),
      daiAmount
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

    // AFC aEthUSDC Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDC_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      AFC_USDC_ALLOWANCE
    );

    // AFC aEthUSDT Approval
    AaveV3Ethereum.COLLECTOR.approve(
      IERC20(AaveV3EthereumAssets.USDT_A_TOKEN),
      MiscEthereum.AFC_SAFE,
      AFC_USDT_ALLOWANCE
    );
  }

  function _orbitRenewal() internal {
    address[] memory streamAddresses = new address[](3);
    streamAddresses[0] = EZREAL;
    streamAddresses[1] = STABLE_LABS;
    streamAddresses[2] = IGNAS_DEFI;

    for (uint256 i = 0; i < 3; i++) {
      CollectorUtils.stream(
        AaveV3Ethereum.COLLECTOR,
        CollectorUtils.CreateStreamInput({
          underlying: AaveV3EthereumLidoAssets.GHO_A_TOKEN,
          receiver: streamAddresses[i],
          amount: STREAM_AMOUNT,
          start: block.timestamp,
          duration: STREAM_DURATION
        })
      );
    }
  }
}
