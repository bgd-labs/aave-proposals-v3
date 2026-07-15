---
title: "Aave V4 Caps Increase #9"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/34"
---

## Summary

LlamaRisk recommends a ninth round of Add Cap and Draw Cap increases for Aave V4. Deposits have continued to grow, reaching approximately $240M in total, a ~30% increase since Round 8. Growth has been driven by the newly listed PT-USDG-24SEP2026 on the Global Dollar Hub, which filled its Add Cap to 100%, together with continued USDG and WBTC inflows on the Core Hub. Round 9 expands capacity across all four hubs where utilization indicates additional headroom is warranted.

The proposed adjustments add approximately $89M in additional Add Cap capacity: Core $60M, Prime $5M, Plus $9M and Global Dollar $15M. The total Add Cap ceiling moves from approximately $491M to $580M. Draw Caps on affected assets are scaled proportionally to preserve existing Add/Draw ratios.

## Motivation

Since the previous round, several reserves have exceeded the 80% utilization threshold: PT-USDG-24SEP2026 on the Global Dollar Hub and USDC/USDT on the Plus Hub are fully utilized, USDG on Core sits near its Add Cap, and weETH and cbBTC on Core are in the 80-85% range. On the borrow side, the frxUSD credit lines remain at or near their draw limits. Round 9 increases the relevant Add Caps and Draw Caps to accommodate continued growth while maintaining sufficient headroom for new deposits and borrowing activity.

## Specification

Round 9 targets approximately $89M in additional Add Cap capacity (Core $60M, Prime $5M, Plus $9M, Global Dollar $15M), led by the USDG and frxUSD increases on Core.

### Core Hub

| Spoke   | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Etherfi | weETH  | 14,000          | 18,000           | 0                | -                 |
| Forex   | frxUSD | 0               | -                | 500,000          | 1,000,000         |
| Gold    | XAUt   | 1,800           | 2,500            | 0                | -                 |
| Main    | LINK   | 610,000         | 750,000          | 0                | -                 |
| Main    | USDG   | 40,000,000      | 50,000,000       | 27,200,000       | -                 |
| Main    | WBTC   | 850             | 1,150            | 74               | 100               |
| Main    | cbBTC  | 160             | 220              | 10               | 14                |
| Main    | frxUSD | 40,000,000      | 50,000,000       | 27,200,000       | 34,000,000        |
| Main    | weETH  | 2,200           | 4,000            | 0                | -                 |
| Main    | wstETH | 8,000           | 10,000           | 0                | -                 |

### Plus Hub

| Spoke             | Asset | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----------------- | ----- | --------------- | ---------------- | ---------------- | ----------------- |
| Ethena Ecosystem  | USDC  | 3,000,000       | 6,000,000        | 3,750,000        | 6,375,000         |
| Ethena Ecosystem  | USDT  | 3,000,000       | 6,000,000        | 3,750,000        | 6,375,000         |
| Ethena Ecosystem  | sUSDe | 4,060,000       | 6,000,000        | 0                | -                 |
| Ethena Correlated | USDe  | 5,000,000       | 5,200,000        | 5,200,000        | -                 |
| Ethena Ecosystem  | GHO   | 3,000,000       | 3,450,000        | 3,450,000        | -                 |

### Prime Hub

| Spoke    | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | wstETH | 5,500           | 7,000            | 0                | -                 |
| Bluechip | USDC   | 12,500,000      | 12,590,000       | 14,590,000       | -                 |
| Bluechip | USDT   | 12,500,000      | 13,125,000       | 15,625,000       | -                 |
| Bluechip | GHO    | 7,500,000       | 8,440,000        | 8,440,000        | -                 |

### Global Dollar Hub

| Spoke       | Asset             | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----------- | ----------------- | --------------- | ---------------- | ---------------- | ----------------- |
| USDG Pendle | PT-USDG-24SEP2026 | 15,000,000      | 30,000,000       | 0                | -                 |

### Credit Lines

Three spokes borrow Core Hub liquidity while posting collateral on a different hub, in the absence of local supply: the Bluechip and Ethena Ecosystem spokes draw frxUSD, and the USDG Pendle spoke draws USDG. We increase the frxUSD draw caps to accommodate demand, and reduce the USDG Pendle USDG draw cap to keep it aligned with the PT-USDG Add Cap scope, maintaining credit line exposure at a controlled level relative to the available native supply.

| Spoke            | Asset  | Current Draw Cap | Proposed Draw Cap |
| ---------------- | ------ | ---------------- | ----------------- |
| Bluechip         | frxUSD | 4,000,000        | 5,000,000         |
| Ethena Ecosystem | frxUSD | 300,000          | 500,000           |
| USDG Pendle      | USDG   | 30,000,000       | 15,000,000        |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260702_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260702.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260702_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260702.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/34)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
