// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool, DataTypes} from 'aave-address-book/AaveV3.sol';
import {ICollector} from 'aave-address-book/common/ICollector.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';

/**
 * @title CollectorUtils
 * @author BGD Labs
 * @notice Wraps up routine operations of the AaveCollector
 */
library CollectorUtils {
  error InvalidZeroAmount();

  /**
   * @notice object with stream parameters
   * @param underlying ERC20 compatible asset
   * @param receiver receiver of the stream
   * @param amount streamed amount in wei
   * @param start of the stream in seconds
   * @param duration duration of the stream in seconds
   */
  struct CreateStreamInput {
    address underlying;
    address receiver;
    uint256 amount;
    uint256 start;
    uint256 duration;
  }

  /**
   * @notice object with stream parameters
   * @param fromUnderlying input asset, ERC20 compatible
   * @param toUnderlying output asset, ERC20 compatible
   * @param fromUnderlyingPriceFeed price feed for the input asset
   * @param toUnderlyingPriceFeed price feed for the output asset
   * @param amount amount of input asset to swap, in wei
   * @param slippage maximal swap slippage, where 100_00 is equal to 100%
   */
  struct SwapInput {
    address milkman;
    address priceChecker;
    address fromUnderlying;
    address toUnderlying;
    address fromUnderlyingPriceFeed;
    address toUnderlyingPriceFeed;
    uint256 amount;
    uint256 slippage;
  }
  using SafeERC20 for IERC20;

  /**
   * @notice Deposit funds of the collector to the Aave v3
   * @param collector aave collector
   * @param pool Aave v3 pool
   * @param underlying ERC20 compatible asset, listed on the corresponding Aave v3 pool
   * @param amount to be deposited
   */
  function depositToV3(
    ICollector collector,
    IPool pool,
    address underlying,
    uint256 amount
  ) internal {
    if (amount == 0) {
      revert InvalidZeroAmount();
    }

    if (amount == type(uint256).max) {
      amount = IERC20(underlying).balanceOf(address(collector));
    }
    collector.transfer(underlying, address(this), amount);
    IERC20(underlying).forceApprove(address(pool), amount);
    pool.deposit(underlying, amount, address(collector), 0);
  }

  function withdrawFromV3(
    ICollector collector,
    IPool pool,
    address underlying,
    uint256 amount
  ) internal {
    if (amount == 0) {
      revert InvalidZeroAmount();
    }
    DataTypes.ReserveData memory reserveData = pool.getReserveData(underlying);

    if (amount == type(uint256).max) {
      amount = IERC20(reserveData.aTokenAddress).balanceOf(address(collector));
    }
    collector.transfer(reserveData.aTokenAddress, address(this), amount);

    // in case of imprecision during the aTokenTransfer withdraw a bit less
    uint256 balanceAfterTransfer = IERC20(reserveData.aTokenAddress).balanceOf(address(this));
    amount = balanceAfterTransfer >= amount ? amount : balanceAfterTransfer;

    pool.withdraw(underlying, amount, address(collector));
  }

  /**
   * @notice Open a funds stream to the receiver
   * @param collector aave collector
   * @param input stream creation parameters wrapped as CreateStreamInput
   * @return the actual stream amount
   */
  function stream(ICollector collector, CreateStreamInput memory input) internal returns (uint256) {
    if (input.amount == 0) {
      revert InvalidZeroAmount();
    }

    uint256 actualAmount = (input.amount / input.duration) * input.duration;
    collector.createStream(
      input.underlying,
      actualAmount,
      input.underlying,
      input.start,
      input.start + input.duration
    );

    return actualAmount;
  }

  /**
   * @notice Open a swap order on AaveSwapper, to swap collector funds fromUnderlying to toUnderlying
   * @param collector aave collector
   * @param swapper AaveSwapper
   * @param input swap parameters wrapped as SwapInput
   */
  function swap(ICollector collector, AaveSwapper swapper, SwapInput memory input) internal {
    if (input.amount == 0) {
      revert InvalidZeroAmount();
    }

    if (input.amount == type(uint256).max) {
      input.amount = IERC20(input.fromUnderlying).balanceOf(address(collector));
    }

    collector.transfer(input.fromUnderlying, address(swapper), input.amount);

    swapper.swap(
      input.milkman,
      input.priceChecker,
      input.fromUnderlying,
      input.toUnderlying,
      input.fromUnderlyingPriceFeed,
      input.toUnderlyingPriceFeed,
      address(collector),
      IERC20(input.fromUnderlying).balanceOf(address(swapper)), // TODO: ?? maybe exact amount
      input.slippage
    );
  }
}
