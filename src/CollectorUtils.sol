// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import {IPool} from 'aave-address-book/AaveV3.sol';
import {ICollector} from 'aave-address-book/common/ICollector.sol';
import {IERC20} from 'solidity-utils/contracts/oz-common/interfaces/IERC20.sol';
import {SafeERC20} from 'solidity-utils/contracts/oz-common/SafeERC20.sol';
import {AaveSwapper} from 'aave-helpers/swaps/AaveSwapper.sol';

library CollectorUtils {
  error InvalidZeroAmount();

  struct CreateStreamInput {
    address underlying;
    address receiver;
    uint256 amount;
    uint256 duration;
  }

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

  function stream(ICollector collector, CreateStreamInput memory input) internal returns (uint256) {
    if (input.amount == 0) {
      revert InvalidZeroAmount();
    }

    uint256 actualAmount = (input.amount / input.duration) * input.duration;
    collector.createStream(
      input.underlying,
      actualAmount,
      input.underlying,
      block.timestamp,
      block.timestamp + input.duration
    );

    return actualAmount;
  }

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
