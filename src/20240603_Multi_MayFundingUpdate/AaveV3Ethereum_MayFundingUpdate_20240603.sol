// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';

/**
 * @title May Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768
 */
contract AaveV3Ethereum_MayFundingUpdate_20240603 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);

  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant FRONTIER_SAFE = 0xCDb4fA6ba08bF1FB7Aa9fDf6002E78EDc431a642;
  uint256 public constant WSTETH_AMOUNT = 350 ether;
  uint256 public constant FRONTIER_ALLOWANCE_AMOUNT = 2493 ether;
  uint256 public constant AETH_USDT_AMOUNT = 1_000_000e6;

  function execute() external {
    _withdrawAndSwapForGHO();
    _migrateWeth();
    _depositAllLink();
    _unwrapLsts();

    /// FRONTIER allowance
    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.WETH_UNDERLYING,
      FRONTIER_SAFE,
      FRONTIER_ALLOWANCE_AMOUNT
    );
  }

  function _withdrawAndSwapForGHO() internal {
    /// aEthDAI & aDAI
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_A_TOKEN,
      address(this),
      IERC20(AaveV3EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e18
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.DAI_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.DAI_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e18
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 daiBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).transfer(address(SWAPPER), daiBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      daiBalance,
      50
    );

    /// aEthLUSD
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LUSD_A_TOKEN,
      address(this),
      IERC20(AaveV3EthereumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e18
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 lusdBalance = IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).transfer(address(SWAPPER), lusdBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.LUSD_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      lusdBalance,
      50
    );

    /// aEthPYUSD
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.PYUSD_A_TOKEN,
      address(this),
      IERC20(AaveV3EthereumAssets.PYUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e18
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 pyusdBalance = IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).transfer(address(SWAPPER), pyusdBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.PYUSD_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      pyusdBalance,
      50
    );

    /// aUSDC
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e18
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 usdcBalance = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).transfer(address(SWAPPER), usdcBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      usdcBalance,
      50
    );

    /// DPI

    uint256 dpiBalance = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).transfer(address(SWAPPER), dpiBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV2EthereumAssets.DPI_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      dpiBalance,
      50
    );

    /// aEthUSDT

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDT_A_TOKEN,
      address(this),
      AETH_USDT_AMOUNT
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.USDT_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 usdtBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).transfer(address(SWAPPER), usdtBalance);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      AaveV3EthereumAssets.USDT_ORACLE,
      AaveV3EthereumAssets.GHO_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      usdtBalance,
      50
    );
  }

  function _unwrapLsts() internal {
    uint256 rethBalance = IERC20(AaveV3EthereumAssets.rETH_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.rETH_UNDERLYING,
      address(SWAPPER),
      rethBalance
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      address(SWAPPER),
      WSTETH_AMOUNT
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.rETH_ORACLE,
      AaveV3EthereumAssets.WETH_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      rethBalance,
      50
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.wstETH_ORACLE,
      AaveV3EthereumAssets.WETH_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      WSTETH_AMOUNT,
      50
    );
  }

  function _depositAllLink() internal {
    uint256 linkAmount = IERC20(AaveV2EthereumAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      address(this),
      linkAmount
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV2EthereumAssets.LINK_UNDERLYING,
      linkAmount,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }

  function _migrateWeth() internal {
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.WETH_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.WETH_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e18
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      type(uint256).max,
      address(this)
    );

    uint256 wethAmount = IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).balanceOf(address(this));
    IERC20(AaveV2EthereumAssets.WETH_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      wethAmount
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV2EthereumAssets.WETH_UNDERLYING,
      wethAmount,
      address(AaveV3Ethereum.COLLECTOR),
      0
    );
  }
}
