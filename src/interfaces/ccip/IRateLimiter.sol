// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

interface IRateLimiter {
  struct Config {
    bool isEnabled; // Indication whether the rate limiting should be enabled
    uint128 capacity; // ────╮ Specifies the capacity of the rate limiter
    uint128 rate; //  ───────╯ Specifies the rate of the rate limiter
  }
}
