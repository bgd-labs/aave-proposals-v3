// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {IAaveWstethWithdrawer} from 'aave-helpers/asset-manager/interfaces/IAaveWstethWithdrawer.sol';

/**
 * @title May Funding Update
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-may-funding-update/17768
 */
contract AaveV3Ethereum_MayFundingUpdate_20240603 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  IAaveWstethWithdrawer public constant AAVE_STETH_WITHDRAWER =
    IAaveWstethWithdrawer(0x2C4d3C146b002079949d7EecD07f261A39c98c4d);

  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  address public constant DAI_FEED = 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9;
  address public constant LUSD_FEED = 0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0;
  address public constant PYUSD_FEED = 0x8f1dF6D7F2db73eECE86a18b4381F4707b918FB1;
  address public constant USDC_FEED = 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6;
  address public constant DPI_FEED = 0xD2A593BF7594aCE1faD597adb697b5645d5edDB2;
  address public constant USDT_FEED = 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;
  address public constant RETH_FEED = 0x536218f9E9Eb48863970252233c8F271f554C2d0;
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  address public constant FRONTIER_SAFE = 0xCDb4fA6ba08bF1FB7Aa9fDf6002E78EDc431a642;
  uint256 public constant WSTETH_AMOUNT = 350 ether;
  uint256 public constant FRONTIER_ALLOWANCE_AMOUNT = 2493 ether;
  uint256 public constant AETH_USDT_AMOUNT = 2_000_000e6;
  uint256 public constant AETH_USDC_AMOUNT = 1_500_000e6;

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
      address(SWAPPER)
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.DAI_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 daiBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DAI_FEED,
      GHO_USD_FEED,
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
      address(SWAPPER)
    );

    uint256 lusdBalance = IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      LUSD_FEED,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      lusdBalance,
      150
    );

    /// aEthPYUSD
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.PYUSD_A_TOKEN,
      address(this),
      IERC20(AaveV3EthereumAssets.PYUSD_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e6
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 pyusdBalance = IERC20(AaveV3EthereumAssets.PYUSD_UNDERLYING).balanceOf(
      address(SWAPPER)
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.PYUSD_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      PYUSD_FEED,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      pyusdBalance,
      100
    );

    /// aUSDC & aEthUSDC
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV2EthereumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Ethereum.COLLECTOR)) - 1e6
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_A_TOKEN,
      address(this),
      AETH_USDC_AMOUNT
    );

    AaveV2Ethereum.POOL.withdraw(
      AaveV2EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    AaveV3Ethereum.POOL.withdraw(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(SWAPPER)
    );

    uint256 usdcBalance = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      USDC_FEED,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      usdcBalance,
      50
    );

    /// DPI
    uint256 dpiBalance = IERC20(AaveV2EthereumAssets.DPI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV2EthereumAssets.DPI_UNDERLYING,
      address(SWAPPER),
      dpiBalance
    );

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV2EthereumAssets.DPI_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      DPI_FEED,
      GHO_USD_FEED,
      address(AaveV3Ethereum.COLLECTOR),
      dpiBalance,
      500
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
      address(SWAPPER)
    );

    uint256 usdtBalance = IERC20(AaveV3EthereumAssets.USDT_UNDERLYING).balanceOf(address(SWAPPER));

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.GHO_UNDERLYING,
      USDT_FEED,
      GHO_USD_FEED,
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
      address(AAVE_STETH_WITHDRAWER),
      WSTETH_AMOUNT
    );

    uint256[] memory amounts = new uint256[](1);
    amounts[0] = WSTETH_AMOUNT;

    AAVE_STETH_WITHDRAWER.startWithdraw(amounts);

    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.rETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      RETH_FEED,
      AaveV3EthereumAssets.WETH_ORACLE,
      address(AaveV3Ethereum.COLLECTOR),
      rethBalance,
      50
    );
  }

  function _depositAllLink() internal {
    uint256 linkAmount = IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.LINK_UNDERLYING,
      address(this),
      linkAmount
    );

    IERC20(AaveV3EthereumAssets.LINK_UNDERLYING).forceApprove(
      address(AaveV3Ethereum.POOL),
      type(uint256).max
    );

    AaveV3Ethereum.POOL.deposit(
      AaveV3EthereumAssets.LINK_UNDERLYING,
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
