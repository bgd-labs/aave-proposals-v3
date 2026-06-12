---
title: "Aave V4 Caps Increase #6"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/27"
---

## Summary

LlamaRisk recommends a sixth round of Add and Draw Cap increases for Aave V4, spanning the Core, Prime and Plus hubs. Following the execution of Round 5, utilization across the major Core/Main reserves and the Prime/Bluechip collateral set has continued to climb, and the Plus Hub is ready to graduate from its bootstrap caps now that the May 2026 Ethena PT markets have matured. This round delivers broad cap increases across all three hubs, offboards the matured PT-USDe-7MAY2026 and PT-sUSDE-7MAY2026 markets by setting their Add Caps to 0, and scales the Core-to-Bluechip credit lines to support the larger stablecoin headroom.

Draw Caps are scaled proportionally to their corresponding Add Caps, preserving existing Add/Draw ratios. All increases remain well within the equivalent market sizes observed on Aave V3 Core Instance and are sized conservatively against available DEX liquidity for liquidation feasibility.

## Motivation

This round responds to several intersecting signals from the post-Round-5 data.

1. Core Hub stablecoin and collateral demand keeps growing. The Core/Main stablecoins (GHO, USDC, USDG, USDT, frxUSD, EURC, RLUSD) and collateral reserves (WETH, WBTC, cbBTC, wstETH, weETH, AAVE, LINK) are scaled to relieve utilization pressure and to provide borrow capacity against the expanded stable caps. The Forex and Gold spokes receive further headroom on their dedicated stablecoin pools.

2. The Prime Hub Bluechip collateral and stablecoin set is scaled materially to support cross-hub borrow demand feeding into the new Core stable caps, with GHO, USDC and USDT each stepping up to absorb the elevated borrowing observed after Round 5.

3. The Plus Hub graduates from bootstrap caps. With the May 2026 Ethena PT markets (PT-USDe-7MAY2026 and PT-sUSDE-7MAY2026) now matured, their Add Caps are set to 0 to wind down new supply, while the underlying USDe and sUSDe markets and the Ethena Ecosystem stablecoins (GHO, USDC, USDT) are scaled up substantially.

## Specification

Add and Draw Caps are updated across the Core, Prime and Plus hubs as detailed below. Draw Caps are scaled proportionally to their corresponding Add Caps, preserving existing Add/Draw ratios. For the EtherFi, Lido and Lombard spokes, collateral Add Caps are raised to support full strategy capacity. The matured Ethena PT markets are offboarded by setting their Add Caps to 0.

### Core Hub

| Spoke   | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Etherfi | weETH  | 8,500           | 11,000           | 0                | -                 |
| Forex   | EURC   | 1,125,000       | 4,300,000        | 1,170,000        | 4,500,000         |
| Forex   | USDC   | 1,500,000       | 10,000,000       | 500,000          | 3,330,000         |
| Forex   | USDT   | 1,500,000       | 10,000,000       | 500,000          | 3,330,000         |
| Gold    | EURC   | 0               | -                | 50,000           | 100,000           |
| Gold    | GHO    | 0               | -                | 62,500           | 125,000           |
| Gold    | RLUSD  | 0               | -                | 62,500           | 125,000           |
| Gold    | USDC   | 0               | -                | 250,000          | 500,000           |
| Gold    | USDG   | 0               | -                | 250,000          | 500,000           |
| Gold    | USDT   | 0               | -                | 400,000          | 800,000           |
| Gold    | XAUt   | 500             | 1,000            | 0                | -                 |
| Gold    | frxUSD | 0               | -                | 250,000          | 500,000           |
| Lido    | wstETH | 4,800           | 5,900            | 0                | -                 |
| Lombard | LBTC   | 9               | 45               | 0                | -                 |
| Main    | AAVE   | 12,000          | 67,000           | 0                | -                 |
| Main    | EURC   | 225,000         | 4,300,000        | 150,000          | 2,900,000         |
| Main    | GHO    | 1,500,000       | 10,000,000       | 1,500,000        | 10,000,000        |
| Main    | LINK   | 430,000         | 610,000          | 0                | -                 |
| Main    | RLUSD  | 500,000         | 5,000,000        | 340,000          | 3,400,000         |
| Main    | USDC   | 6,000,000       | 10,000,000       | 6,000,000        | 10,000,000        |
| Main    | USDG   | 20,000,000      | 30,000,000       | 13,600,000       | 20,400,000        |
| Main    | USDT   | 8,500,000       | 12,500,000       | 8,500,000        | 12,500,000        |
| Main    | WBTC   | 170             | 240              | 15               | 21                |
| Main    | WETH   | 18,500          | 24,000           | 1,600            | 2,050             |
| Main    | cbBTC  | 85              | 115              | 5                | 7                 |
| Main    | frxUSD | 20,000,000      | 30,000,000       | 13,600,000       | 20,400,000        |
| Main    | weETH  | 1,000           | 1,500            | 0                | -                 |
| Main    | wstETH | 2,800           | 4,400            | 0                | -                 |

### Prime Hub

| Spoke    | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | GHO    | 3,000,000       | 7,500,000        | 3,375,000        | 8,440,000         |
| Bluechip | USDC   | 3,000,000       | 12,500,000       | 3,500,000        | 14,590,000        |
| Bluechip | USDT   | 3,000,000       | 12,500,000       | 3,750,000        | 15,625,000        |
| Bluechip | WBTC   | 120             | 185              | 0                | -                 |
| Bluechip | WETH   | 2,200           | 3,200            | 0                | -                 |
| Bluechip | cbBTC  | 60              | 90               | 0                | -                 |
| Bluechip | wstETH | 2,400           | 4,100            | 0                | -                 |

### Plus Hub

| Spoke             | Asset             | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----------------- | ----------------- | --------------- | ---------------- | ---------------- | ----------------- |
| Ethena Correlated | PT-USDe-7MAY2026  | 50,000          | 0                | 0                | -                 |
| Ethena Correlated | PT-sUSDE-7MAY2026 | 400,000         | 0                | 0                | -                 |
| Ethena Correlated | USDe              | 312,500         | 5,000,000        | 325,000          | 5,200,000         |
| Ethena Correlated | sUSDe             | 250,000         | 4,060,000        | 0                | -                 |
| Ethena Ecosystem  | GHO               | 1,000,000       | 3,000,000        | 1,150,000        | 3,450,000         |
| Ethena Ecosystem  | PT-USDe-7MAY2026  | 250,000         | 0                | 0                | -                 |
| Ethena Ecosystem  | PT-sUSDE-7MAY2026 | 2,000,000       | 0                | 0                | -                 |
| Ethena Ecosystem  | USDC              | 500,000         | 3,000,000        | 625,000          | 3,750,000         |
| Ethena Ecosystem  | USDT              | 500,000         | 3,000,000        | 625,000          | 3,750,000         |
| Ethena Ecosystem  | USDe              | 1,000,000       | 5,000,000        | 960,000          | 4,800,000         |
| Ethena Ecosystem  | sUSDe             | 1,000,000       | 4,060,000        | 0                | -                 |

The matured Ethena PT markets (PT-USDe-7MAY2026 and PT-sUSDE-7MAY2026) have their Add Caps set to 0 across both Plus Hub spokes to wind down new supply now that the underlying instruments have reached maturity. Existing positions are unaffected; only new supply is constrained.

### Credit Lines

To support the larger frxUSD, USDC and USDT caps on Core/Main and the elevated Bluechip-to-Core borrowing demand observed after Round 5, the Core-to-Bluechip credit lines are scaled up.

| Origin   | Target Spoke | Asset  | Current Credit Line | Current Draw Util | Proposed Credit Line |
| -------- | ------------ | ------ | ------------------- | ----------------- | -------------------- |
| Core Hub | Bluechip     | frxUSD | 1,000,000           | 96%               | 3,000,000            |
| Core Hub | Bluechip     | USDC   | 375,000             | 74%               | 2,000,000            |
| Core Hub | Bluechip     | USDT   | 1,250,000           | 41%               | 2,500,000            |
| Core Hub | Bluechip     | EURC   | 150,000             | 16%               | 300,000              |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260603_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260603.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260603_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260603.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/27)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
