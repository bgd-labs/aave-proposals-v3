---
title: "Umbrella Pause"
author: "Aave Labs"
discussions: https://governance.aave.com/t/direct-to-aip-pause-stkwaweth-umbrella-staked-token-on-ethereum-v3/24595
---

## Simple Summary

This proposal pauses the stkwaWETH Umbrella stake token on the Ethereum instance.

## Motivation

The appropriate Umbrella response depends on how the rsETH shortfall is ultimately recognized.

If losses are recognized in a way that impacts Ethereum Core WETH, the WETH Umbrella module becomes a live coverage surface. In that case, allowing the module to remain fully active creates avoidable coordination risk while the situation is still being assessed. A large share of the currently staked aWETH has already entered cooldown, which increases the chance of further exits before the DAO has clarity on whether the module may be needed for coverage.

Pausing the Umbrella stake token places the system into a precautionary safe state while the DAO completes that assessment. In the paused state, deposits, withdrawals, transfers, and slashing are blocked, while rewards distribution continues. This also means the module is no longer treated as slashable for automatic deficit coverage, so any use of those funds would require explicit governance action.

If losses remain isolated outside Ethereum Core, Umbrella may not need to be used. Even in that case, moving the stake tokens into a paused state is a prudent temporary control until the exposure path is fully resolved.

## Specification

The proposal calls `pauseStk(stk)` on the Umbrella contract (`0xD400fc38ED4732893174325693a63C30ee3881a8`) for the `stkwaWETH` stake token. The table below summarizes the resulting state.

| Stake Token | Address                                      | Paused (before) | Paused (after) |
| ----------- | -------------------------------------------- | --------------- | -------------- |
| stkwaWETH   | `0xaAFD07D53A7365D3e9fb6F3a3B09EC19676B73Ce` | false           | true           |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260420_AaveV3Ethereum_UmbrellaPause/AaveV3Ethereum_UmbrellaPause_20260420.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-pause-stkwaweth-umbrella-staked-token-on-ethereum-v3/24595)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
