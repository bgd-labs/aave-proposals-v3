// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscArbitrum} from 'aave-address-book/MiscArbitrum.sol';
import {CollectorUtils, ICollector} from 'aave-helpers/src/CollectorUtils.sol';
import {IAaveArbEthERC20Bridge} from 'aave-helpers/src/bridges/arbitrum/IAaveArbEthERC20Bridge.sol';
import {IERC20} from 'openzeppelin-contracts/contracts/token/ERC20/IERC20.sol';
/**
 * @title May Funding Update
 * @author TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: TODO
 */
contract AaveV3Arbitrum_MayFundingUpdate_20250426 is IProposalGenericExecutor {
  using CollectorUtils for ICollector;

  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;
  address public constant WETH_GATEWAY = 0x6c411aD3E74De3E7Bd422b94A27770f5B86C623B;
  address public constant WSTETH_GATEWAY = 0x07D4692291B9E30E326fd31706f686f83f331B82;
  address public constant USDT_GATEWAY = 0x14E4A1B13bf7F943c8ff7C51fb60FA964A298D92;
  address public constant WBTC_GATEAY = 0x09e9222E96E7B4AE2a407B98d48e330053351EEe;
  address public constant WEETH_GATEWAY = 0x09e9222E96E7B4AE2a407B98d48e330053351EEe;

  function execute() external {
    /// USDC
    uint256 usdcAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Arbitrum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.USDC_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        )
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      usdcAmountWithdrawn
    );

    /// WETH
    uint256 wethAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Arbitrum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.WETH_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.WETH_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        )
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.WETH_UNDERLYING,
      AaveV3EthereumAssets.WETH_UNDERLYING,
      WETH_GATEWAY,
      wethAmountWithdrawn
    );

    /// WSTETH https://github.com/bgd-labs/aave-helpers/blob/main/src/bridges/arbitrum/README.md
    /// docs say this cant be done?
    uint256 wsethAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Arbitrum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.wstETH_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.wstETH_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        )
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.wstETH_UNDERLYING,
      AaveV3EthereumAssets.wstETH_UNDERLYING,
      WSTETH_GATEWAY,
      wsethAmountWithdrawn
    );

    /// USDT
    uint256 usdtAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Arbitrum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.USDT_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.USDT_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        )
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      USDT_GATEWAY,
      usdtAmountWithdrawn
    );

    /// WBTC
    uint256 wbtcAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Arbitrum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.WBTC_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.WBTC_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        )
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.WBTC_UNDERLYING,
      AaveV3EthereumAssets.WBTC_UNDERLYING,
      WBTC_GATEWAY,
      wbtcAmountWithdrawn
    );

    /// WEETH
    uint256 weethAmountWithdrawn = CollectorUtils.withdrawFromV3(
      AaveV3Arbitrum.COLLECTOR,
      CollectorUtils.IOInput({
        pool: address(AaveV3Arbitrum.POOL),
        underlying: AaveV3ArbitrumAssets.weETH_UNDERLYING,
        amount: IERC20(AaveV3ArbitrumAssets.weETH_A_TOKEN).balanceOf(
          address(AaveV3Arbitrum.COLLECTOR)
        )
      }),
      MiscArbitrum.AAVE_ARB_ETH_BRIDGE
    );
    IAaveArbEthERC20Bridge(MiscArbitrum.AAVE_ARB_ETH_BRIDGE).bridge(
      AaveV3ArbitrumAssets.weETH_UNDERLYING,
      AaveV3EthereumAssets.weETH_UNDERLYING,
      WEETH_GATEWAY,
      weethAmountWithdrawn
    );
  }
}
