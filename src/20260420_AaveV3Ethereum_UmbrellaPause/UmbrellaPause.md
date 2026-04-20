---
title: "Umbrella Pause"
author: "Aave Labs"
discussions: TODO
snapshot: TODO
---

## Simple Summary

This proposal pauses the `stkwaWETH` Umbrella stake token on the Ethereum instance.

## Motivation

Pausing the WETH stake token places its portion of the Umbrella backstop into a safe state while the DAO assesses the system. While paused, no deposits, withdrawals, or slashing can occur on `stkwaWETH`. Rescue of arbitrary tokens remains available. The stablecoin stake tokens (`stkwaUSDC`, `stkwaUSDT`, `stkGHO`) are left untouched.

## Specification

The proposal calls `pauseStk(stk)` on the Umbrella contract (`0xD400fc38ED4732893174325693a63C30ee3881a8`) for the `stkwaWETH` stake token. The table below summarizes the resulting state.

| Stake Token | Address                                      | Paused (before) | Paused (after) |
| ----------- | -------------------------------------------- | --------------- | -------------- |
| stkwaWETH   | `0xaAFD07D53A7365D3e9fb6F3a3B09EC19676B73Ce` | false           | true           |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
