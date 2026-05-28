---
title: "Aave V4 Caps Increase #5"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/25"
---

## Summary

LlamaRisk recommends a fifth round of Add and Draw Cap increases for Aave V4, focused on the Core Hub, bringing the total supply cap ceiling to approximately $208M. Following the execution of Round 4 cap increases, both frxUSD and USDG on Core/Main have filled to 100% Add Cap utilization under the live incentive program. This round delivers a second tranche on those two assets, doubling each from 10M to 20M, and applies $2–3M USD-equivalent bumps to the remaining high-utilization reserves on Core. Credit lines are unchanged this round.

The proposed adjustments add approximately $29M in additional supply cap capacity, all on the Core Hub. The bulk is the frxUSD/USDG step-up to 20M each; the remainder funds high-utilization Main collateral (cbBTC), the LINK reserve approaching the 80% threshold, and the smaller dedicated Forex and Gold spokes that have pressed against their caps. Round 4 caps still have headroom on Prime, and Plus remains in early bootstrap.

## Motivation

This round responds to two distinct utilization signals from the post-Round-4 data.

1. The frxUSD and USDG incentive programs filled their Round 4 caps. Both reserves are at 100% Add Cap utilization on Core/Main following the incentive rollout. To extend reward capacity through the next cycle without halting deposits, the Core/Main caps for both assets are raised in a single tranche to 20,000,000 each.

2. Other Core/Main and small-spoke reserves have approached their Round 4 caps. cbBTC on Core/Main sits at ~90% Add Cap utilization, the Core/Forex USDC and USDT pools are near 100%, and the Core/Gold XAUt pool is above 80%. These receive USD-equivalent bumps in the $1–3M range, sized to relieve the immediate constraint while staying conservative against observed DEX liquidity. LINK on Core/Main at 78% utilization receives a preemptive bump to avoid hitting the cap before the next monitoring cycle.

## Specification

We target approximately $29M in additional supply cap capacity, all on the Core Hub. frxUSD and USDG on Core/Main are doubled in a single tranche to 20M each to support the ongoing incentive program. Other tight-cap reserves receive $1–3M USD-equivalent bumps sized to their pool scale: cbBTC on Core/Main (+~$2.65M), LINK on Core/Main (+~$2M preemptive), the Forex USDC, USDT and EURC pools (~3.75x each), and Gold XAUt (+~$1.1M).

### Core Hub

| Spoke | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Forex | EURC   | 300,000         | 1,125,000        | 312,500          | 1,170,000         |
| Forex | USDC   | 400,000         | 1,500,000        | 135,000          | 500,000           |
| Forex | USDT   | 400,000         | 1,500,000        | 135,000          | 500,000           |
| Gold  | USDC   | 0               | -                | 125,000          | 250,000           |
| Gold  | USDG   | 0               | -                | 62,500           | 250,000           |
| Gold  | USDT   | 0               | -                | 200,000          | 400,000           |
| Gold  | XAUt   | 250             | 500              | 0                | -                 |
| Gold  | frxUSD | 0               | -                | 100,000          | 250,000           |
| Main  | LINK   | 220,000         | 430,000          | 0                | -                 |
| Main  | USDG   | 10,000,000      | 20,000,000       | 6,800,000        | 13,600,000        |
| Main  | cbBTC  | 50              | 85               | 3                | 5                 |
| Main  | frxUSD | 10,000,000      | 20,000,000       | 6,800,000        | 13,600,000        |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260527_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260527.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260527_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260527.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/25)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
