// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';
import {DepositV3SwapPayload} from 'aave-helpers/swaps/DepositV3SwapPayload.sol';
import {AaveV3Ethereum, AaveV3EthereumAssets} from 'aave-address-book/AaveV3Ethereum.sol';
import {MiscEthereum} from 'aave-address-book/MiscEthereum.sol';

/**
 * @title Treasury Management - GSM Funding & RWA Strategy Preparations (Part 2)
 * @author karpatkey_TokenLogic
 * - Snapshot: https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19
 * - Discussion: https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128
 */
contract AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209 is
  DepositV3SwapPayload
{
  using SafeERC20 for IERC20;

  uint256 public constant USDC_TO_SWAP = 700_000e6;
  AaveSwapper public constant SWAPPER = AaveSwapper(MiscEthereum.AAVE_SWAPPER);
  address public constant MILKMAN = 0x11C76AD590ABDFFCD980afEC9ad951B160F02797;
  address public constant PRICE_CHECKER = 0xe80a1C615F75AFF7Ed8F08c9F21f9d00982D666c;

  function execute() external {
    // Transfer 700k USDC from Collector to Swapper
    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(SWAPPER),
      USDC_TO_SWAP
    );

    // Deposit all remaining USDC from collector into Aave v3.
    uint256 usdcBalance = IERC20(AaveV3EthereumAssets.USDC_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.USDC_UNDERLYING,
      address(this),
      usdcBalance
    );

    _deposit(AaveV3EthereumAssets.USDC_UNDERLYING, usdcBalance);

    // Transfer the whole DAI balance of the collector into the Swapper
    uint256 daiBalance = IERC20(AaveV3EthereumAssets.DAI_UNDERLYING).balanceOf(
      address(AaveV3Ethereum.COLLECTOR)
    );

    AaveV3Ethereum.COLLECTOR.transfer(
      AaveV3EthereumAssets.DAI_UNDERLYING,
      address(SWAPPER),
      daiBalance
    );

    // Swap DAI into USDT with receiver being this contract
    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.DAI_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.DAI_ORACLE,
      AaveV3EthereumAssets.USDT_ORACLE,
      SELF,
      daiBalance,
      50
    );

    // Swap USDC into USDT with receiver being this contract
    SWAPPER.swap(
      MILKMAN,
      PRICE_CHECKER,
      AaveV3EthereumAssets.USDC_UNDERLYING,
      AaveV3EthereumAssets.USDT_UNDERLYING,
      AaveV3EthereumAssets.USDC_ORACLE,
      AaveV3EthereumAssets.USDT_ORACLE,
      SELF,
      USDC_TO_SWAP,
      50
    );
  }

  /**
   * @dev To be used after the async swap takes place to deposit USDT in AAVE v3
   */
  function deposit(address token, uint256 amount) external {
    _deposit(token, amount);
  }
}
