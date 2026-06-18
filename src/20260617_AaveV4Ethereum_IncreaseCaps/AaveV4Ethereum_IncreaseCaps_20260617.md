---
title: "Aave V4 Caps Increase #8"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/32"
---

## Summary

LlamaRisk recommends an eighth round of Add Cap and Draw Cap increases for Aave V4. Deposits have continued to grow, reaching approximately $185M in total, with inflows remaining concentrated in BTC and ETH collateral on the Core Hub. Notably, WBTC on Core Main has already refilled the capacity added in the previous round and has returned to full Add Cap utilization, reflecting continued depositor demand. Round 8 expands capacity where utilization indicates additional headroom is warranted.

The proposed adjustments add approximately $75M in additional Add Cap capacity: Core $64M and Prime $11M. The total Add Cap ceiling moves from approximately $392M to $467M. Draw Caps on affected assets are scaled proportionally to preserve existing Add/Draw ratios.

## Motivation

Since the previous round, deposit growth has remained concentrated in a small number of Core Hub collateral assets. On the borrow side, several credit lines have once again reached or approached their draw limits, reflecting sustained borrowing demand. Round 8 increases the relevant Add Caps and Draw Caps to accommodate continued growth while maintaining sufficient headroom for new deposits and borrowing activity.

## Specification

Round 8 targets approximately $75M in additional Add Cap capacity (Core $64M, Prime $11M), led by the USDG/frxUSD 10M extensions and the WBTC increase.

### Core Hub

| Spoke | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Forex | GHO    | 0               | -                | 12,500           | 50,000            |
| Forex | USDG   | 0               | -                | 250,000          | 500,000           |
| Forex | frxUSD | 0               | -                | 250,000          | 500,000           |
| Main  | AAVE   | 67,000          | 100,000          | 0                | -                 |
| Main  | USDC   | 10,000,000      | 12,500,000       | 10,000,000       | 12,500,000        |
| Main  | USDG   | 30,000,000      | 40,000,000       | 20,400,000       | 27,200,000        |
| Main  | USDT   | 15,000,000      | 20,000,000       | 15,000,000       | 20,000,000        |
| Main  | WBTC   | 450             | 850              | 39               | 74                |
| Main  | cbBTC  | 115             | 160              | 7                | 10                |
| Main  | frxUSD | 30,000,000      | 40,000,000       | 20,400,000       | 27,200,000        |
| Main  | wstETH | 6,000           | 8,000            | 0                | -                 |

### Prime Hub

| Spoke    | Asset | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ----- | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | WBTC  | 280             | 400              | 0                | -                 |
| Bluechip | cbBTC | 90              | 130              | 0                | -                 |

### Credit Lines

Two spokes borrow Core frxUSD liquidity while posting collateral on a different hub. The Bluechip and Ethena Ecosystem spokes draw frxUSD from the Core Hub in the absence of local supply. Both frxUSD credit lines are currently at 100% draw cap utilization. We propose a measured increase to these draw caps to accommodate demand while maintaining credit line exposure at a controlled level relative to the available native frxUSD supply.

| Spoke            | Asset  | Current Draw Cap | Current Draw Util | Proposed Draw Cap |
| ---------------- | ------ | ---------------- | ----------------- | ----------------- |
| Bluechip         | frxUSD | 3,000,000        | 100%              | 4,000,000         |
| Ethena Ecosystem | frxUSD | 200,000          | 100%              | 300,000           |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260617_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260617.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260617_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260617.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/32)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
