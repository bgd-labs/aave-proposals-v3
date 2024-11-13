// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IProposalGenericExecutor} from 'aave-helpers/src/interfaces/IProposalGenericExecutor.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveV3Arbitrum, AaveV3ArbitrumAssets} from 'aave-address-book/AaveV3Arbitrum.sol';
import {AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';

interface IAaveArbEthERC20Bridge {
  function bridge(address token, address l1token, address gateway, uint256 amount) external;
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

/**
 * @title September Funding Update - Part A
 * @author karpatkey_TokenLogic
 * - Snapshot: Direct-to-AIP
 * - Discussion: https://governance.aave.com/t/arfc-september-funding-update/19162
 */
contract AaveV3Arbitrum_SeptemberFundingUpdatePartA_20241113 is IProposalGenericExecutor {
  using SafeERC20 for IERC20;

  IAaveArbEthERC20Bridge public constant BRIDGE =
    IAaveArbEthERC20Bridge(0x0335ffa9af5CE05590d6C9A75B645470e07744a9);
  address public constant USDC_GATEWAY = 0x096760F208390250649E3e8763348E783AEF5562;
  address public constant LUSD_GATEWAY = 0x09e9222E96E7B4AE2a407B98d48e330053351EEe;

  address public constant REPAY_WITH_COLLATERAL_ADAPTER =
    0xB0526BFb4047aE1147DC7caAF3F1653904C2D568;

  function execute() external {
    _bridge();
    _rescueTokens();
  }

  function _bridge() internal {
    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      address(BRIDGE),
      IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR))
    );

    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.USDC_A_TOKEN,
      address(this),
      IERC20(AaveV3ArbitrumAssets.USDC_A_TOKEN).balanceOf(address(AaveV3Arbitrum.COLLECTOR)) - 1
    );

    AaveV3Arbitrum.POOL.withdraw(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      type(uint256).max,
      address(BRIDGE)
    );

    uint256 usdcBalance = IERC20(AaveV3ArbitrumAssets.USDC_UNDERLYING).balanceOf(address(BRIDGE));

    BRIDGE.bridge(
      AaveV3ArbitrumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      USDC_GATEWAY,
      usdcBalance
    );

    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      address(BRIDGE),
      IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING).balanceOf(address(AaveV3Arbitrum.COLLECTOR))
    );

    AaveV3Arbitrum.COLLECTOR.transfer(
      AaveV3ArbitrumAssets.LUSD_A_TOKEN,
      address(this),
      IERC20(AaveV3ArbitrumAssets.LUSD_A_TOKEN).balanceOf(address(AaveV3Arbitrum.COLLECTOR)) - 1
    );

    AaveV3Arbitrum.POOL.withdraw(
      AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      type(uint256).max,
      address(BRIDGE)
    );

    uint256 lusdBalance = IERC20(AaveV3ArbitrumAssets.LUSD_UNDERLYING).balanceOf(address(BRIDGE));

    BRIDGE.bridge(
      AaveV3ArbitrumAssets.LUSD_UNDERLYING,
      AaveV3EthereumAssets.LUSD_UNDERLYING,
      LUSD_GATEWAY,
      lusdBalance
    );

    // AaveV3Arbitrum.COLLECTOR.transfer(
    //   AaveV3ArbitrumAssets.FRAX_A_TOKEN,
    //   address(this),
    //   IERC20(AaveV3ArbitrumAssets.FRAX_A_TOKEN).balanceOf(address(AaveV3Arbitrum.COLLECTOR)) - 1
    // );

    // AaveV3Arbitrum.POOL.withdraw(
    //   AaveV3ArbitrumAssets.FRAX_UNDERLYING,
    //   type(uint256).max,
    //   address(this)
    // );

    // BRIDGE.bridge(
    //   AaveV3ArbitrumAssets.FRAX_UNDERLYING,
    //   AaveV3EthereumAssets.FRAX_UNDERLYING,
    //   LUSD_GATEWAY,
    //   fraxBalance
    // );
  }
}
