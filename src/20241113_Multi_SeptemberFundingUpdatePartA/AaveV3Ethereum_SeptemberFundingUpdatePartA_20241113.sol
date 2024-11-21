// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV2Ethereum, AaveV2EthereumAssets} from 'aave-address-book/AaveV2Ethereum.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';
import {AaveSwapper} from 'aave-helpers/src/swaps/AaveSwapper.sol';
import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IScaledBalanceToken} from 'aave-v3-origin/contracts/interfaces/IScaledBalanceToken.sol';

interface IRescuable {
  /**
   * @notice Emergency rescue for token stuck on this contract, as failsafe mechanism
   * @dev Funds should never remain in this contract more time than during transactions
   * @dev Only callable by the owner
   * @param token The address of the stuck token to rescue
   */
  function rescueTokens(IERC20 token) external;
}

/**
 * @title September Funding Update - Part A
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Ethereum_SeptemberFundingUpdatePartA_20241113 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;
  using CollectorUtils for ICollector;

  // https://etherscan.io/address/0x6A6FA664D4Fa49a6a780a1D6143f079f8dd7C33d
  address public constant DEBT_SWAP_ADAPTER = 0x6A6FA664D4Fa49a6a780a1D6143f079f8dd7C33d;
  // https://etherscan.io/address/0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68
  address public constant DEBT_SWAP_ADAPTER_V3 = 0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68;
  // https://etherscan.io/address/0x02e7B8511831B1b02d9018215a0f8f500Ea5c6B3
  address public constant REPAY_WITH_COLLATERAL_ADAPTER =
    0x02e7B8511831B1b02d9018215a0f8f500Ea5c6B3;

  // https://etherscan.io/address/0x818C277dBE886b934e60aa047250A73529E26A99
  address public constant KARPATKEY = 0x818C277dBE886b934e60aa047250A73529E26A99;
  uint256 public constant GAS_REBATE_AMOUNT = 0.264 ether;

  // https://etherscan.io/address/0xdeadD8aB03075b7FBA81864202a2f59EE25B312b
  address public constant MERIT_SAFE = 0xdeadD8aB03075b7FBA81864202a2f59EE25B312b;
  uint256 public constant GHO_ALLOWANCE = 3_000_000 ether;
  uint256 public constant WETH_A_ALLOWANCE = 800 ether;

  // todo updated this address
  // https://etherscan.io/address/0x11C76AD590ABDFFCD980afEC9ad951B160F02797
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;

  // https://etherscan.io/address/0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;
  // https://etherscan.io/address/0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC
  address public constant GHO_USD_FEED = 0x3f12643D3f6f874d39C2a4c9f2Cd6f2DbAC877FC;
  // https://etherscan.io/address/0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6
  address public constant USDC_FEED = 0x8fFfFfd4AfB6115b954Bd326cbe7B4BA576818f6;
  // https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D
  address public constant USDT_FEED = 0x3E7d1eAB13ad0104d2750B8863b489D65364e32D;
  // https://etherscan.io/address/0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9
  address public constant DAI_FEED = 0xAed0c38402a5d19df6E4c03F4E2DceD6e29c1ee9;
  // https://etherscan.io/address/0x45D270263BBee500CF8adcf2AbC0aC227097b036
  address public constant FRAX_FEED = 0x45D270263BBee500CF8adcf2AbC0aC227097b036;
  // https://etherscan.io/address/0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0
  address public constant LUSD_FEED = 0x3D7aE7E594f2f2091Ad8798313450130d0Aba3a0;
  uint256 public constant USDC_A_AMOUNT = 1_250_000e6;
  uint256 public constant USDT_A_AMOUNT = 1_250_000e6;
  uint256 public constant DAI_A_AMOUNT = 500_000e18;

  function execute() external override {
    _withdrawAndSwapForGHO();
    _rescueParaswap();

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      KARPATKEY,
      GAS_REBATE_AMOUNT
    );

    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.GHO_UNDERLYING,
      MERIT_SAFE,
      GHO_ALLOWANCE
    );
    AaveV3Ethereum.COLLECTOR.approve(
      AaveV3EthereumAssets.WETH_A_TOKEN,
      MERIT_SAFE,
      WETH_A_ALLOWANCE
    );
  }

  function _withdrawAndSwapForGHO() internal {
    // usdc
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        amount: USDC_A_AMOUNT
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDC_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: USDC_FEED,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: type(uint256).max,
        slippage: 50
      })
    );

    // usdt
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        amount: USDT_A_AMOUNT
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.USDT_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: USDT_FEED,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: type(uint256).max,
        slippage: 50
      })
    );

    // dai
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    // aDai
    AaveV2Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.DAI_UNDERLYING,
        amount: IScaledBalanceToken(AaveV2EthereumAssets.DAI_A_TOKEN).scaledBalanceOf(
          address(AaveV2Ethereum.COLLECTOR)
        ) - 1e18
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );
    // aEthDai
    AaveV3Ethereum.COLLECTOR.withdrawFromV3(
      CollectorUtils.IOInput({
        pool: address(AaveV3Ethereum.POOL),
        underlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        amount: DAI_A_AMOUNT
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.DAI_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: DAI_FEED,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: type(uint256).max,
        slippage: 100
      })
    );

    // lusd
    AaveV3Ethereum.COLLECTOR.transfer(
      address(AaveV3EthereumAssets.LUSD_UNDERLYING),
      address(AaveV3Ethereum.COLLECTOR),
      IERC20(AaveV3EthereumAssets.LUSD_UNDERLYING).balanceOf(address(AaveV3Ethereum.COLLECTOR))
    );
    // aLusd
    uint256 aLusdAvailableBalance = IERC20(AaveV2EthereumAssets.LUSD_UNDERLYING).balanceOf(
      AaveV2EthereumAssets.LUSD_A_TOKEN
    );
    uint256 aLusdBalance = IScaledBalanceToken(AaveV2EthereumAssets.LUSD_A_TOKEN).scaledBalanceOf(
      address(AaveV2Ethereum.COLLECTOR)
    );
    AaveV2Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.LUSD_UNDERLYING,
        amount: (aLusdBalance > aLusdAvailableBalance ? aLusdAvailableBalance : aLusdBalance) - 1e18
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.LUSD_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: LUSD_FEED,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: type(uint256).max,
        slippage: 300
      })
    );

    // aFrax
    AaveV2Ethereum.COLLECTOR.withdrawFromV2(
      CollectorUtils.IOInput({
        pool: address(AaveV2Ethereum.POOL),
        underlying: AaveV2EthereumAssets.FRAX_UNDERLYING,
        amount: IScaledBalanceToken(AaveV2EthereumAssets.FRAX_A_TOKEN).scaledBalanceOf(
          address(AaveV2Ethereum.COLLECTOR)
        ) - 1e18
      }),
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.swap(
      MiscEthereum.AAVE_SWAPPER,
      CollectorUtils.SwapInput({
        milkman: MILKMAN,
        priceChecker: PRICE_CHECKER,
        fromUnderlying: AaveV3EthereumAssets.FRAX_UNDERLYING,
        toUnderlying: AaveV3EthereumAssets.GHO_UNDERLYING,
        fromUnderlyingPriceFeed: FRAX_FEED,
        toUnderlyingPriceFeed: GHO_USD_FEED,
        amount: type(uint256).max,
        slippage: 500
      })
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
