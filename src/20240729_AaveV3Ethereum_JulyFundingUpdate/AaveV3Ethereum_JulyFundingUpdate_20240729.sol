// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/core/contracts/interfaces/IScaledBalanceToken.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveSwapper} from 'aave-helpers/src/swaps/AaveSwapper.sol';

/**
 * @title July Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-july-funding-update/18447
 */
contract AaveV3Ethereum_JulyFundingUpdate_20240729 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  address public constant COLLECTOR = address(AaveV3Ethereum.COLLECTOR);

  address public constant MERIT_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant USDE_FEED = 0xa569d910839Ae8865Da8F8e70FfFb0cBA869F961;
  address public constant USDT_FEED = 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;
  address public constant FRAX_FEED = 0xB9E1E3A9feFf48998E45Fa90847ed4D467E8BcfD;
  address public constant DPI_FEED = 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2;

  uint256 public constant USDT_AMOUNT = 500_000e6;
  uint256 public constant GHO_AMOUNT = 3_000_000e18;
  uint256 public constant WETH_AMOUNT = 645 ether;

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);

  function execute() external {
    /// ALLOWANCES
    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.GHO_UNDERLYING, MERIT_SAFE, GHO_AMOUNT);

    AaveV3Ethereum.COLLECTOR.approve(AaveV3EthereumAssets.WETH_A_TOKEN, MERIT_SAFE, WETH_AMOUNT);

    /// SWAPS
    /// aEthUSDe
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDe_A_TOKEN,
      address(this),
      IScaledBalanceToken(AaveV3EthereumAssets.USDe_A_TOKEN).scaledBalanceOf(COLLECTOR) - 1e18
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.USDe_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 usdeBalance = IERC20(AaveV3EthereumAssets.USDe_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDe_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      USDE_FEED,
      GHO_USD_FEED,
      COLLECTOR,
      usdeBalance,
      50
    );

    /// aUSDT
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDT_A_TOKEN,
      address(this),
      USDT_AMOUNT
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 usdtBalance = IERC20(AaveV2EthereumAssets.USDT_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      USDT_FEED,
      GHO_USD_FEED,
      COLLECTOR,
      usdtBalance,
      50
    );

    /// aFRAX & aEthFRAX
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.FRAX_A_TOKEN,
      address(this),
      IScaledBalanceToken(AaveV2EthereumAssets.FRAX_A_TOKEN).scaledBalanceOf(COLLECTOR) - 1e18
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.FRAX_A_TOKEN,
      address(this),
      IScaledBalanceToken(AaveV3EthereumAssets.FRAX_A_TOKEN).scaledBalanceOf(COLLECTOR) - 1e18
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.FRAX_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 fraxBalance = IERC20(AaveV3EthereumAssets.FRAX_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.FRAX_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      FRAX_FEED,
      GHO_USD_FEED,
      COLLECTOR,
      fraxBalance,
      100
    );

    /// aDPI
    AaveV2Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.DPI_A_TOKEN,
      address(this),
      IScaledBalanceToken(AaveV2EthereumAssets.DPI_A_TOKEN).scaledBalanceOf(COLLECTOR) - 1e18
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 dpiBalance = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DPI_FEED,
      GHO_USD_FEED,
      COLLECTOR,
      dpiBalance,
      500
    );
  }
}
