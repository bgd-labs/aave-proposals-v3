---
title: "Umbrella Pause"
author: "Aave Labs"
discussions: TODO
snapshot: TODO
---

## Simple Summary

This proposal pauses all Umbrella stake tokens on the Ethereum instance: `stkwaUSDC`, `stkwaUSDT`, `stkwaWETH` and `stkGHO`.

## Motivation

Pausing each stake token places Umbrella into a safe state while the DAO assesses the system. While paused, no deposits, withdrawals, or slashing can occur. Rescue of arbitrary tokens remains available.

## Specification

The proposal calls `pauseStk(stk)` on the Umbrella contract (`0xD400fc38ED4732893174325693a63C30ee3881a8`) for each of the four Ethereum Umbrella stake tokens. The table below summarizes the resulting state.

| Stake Token | Address                                      | Paused (before) | Paused (after) |
| ----------- | -------------------------------------------- | --------------- | -------------- |
| stkwaUSDC   | `0x6bf183243FdD1e306ad2C4450BC7dcf6f0bf8Aa6` | false           | true           |
| stkwaUSDT   | `0xA484Ab92fe32B143AEE7019fC1502b1dAA522D31` | false           | true           |
| stkwaWETH   | `0xaAFD07D53A7365D3e9fb6F3a3B09EC19676B73Ce` | false           | true           |
| stkGHO      | `0x4f827A63755855cDf3e8f3bcD20265C833f15033` | false           | true           |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
