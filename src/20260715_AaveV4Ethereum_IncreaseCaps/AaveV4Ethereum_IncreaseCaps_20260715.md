---
title: "Aave V4 Caps Increase #10"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/36"
---

## Summary

LlamaRisk recommends a tenth round of Add Cap and Draw Cap increases for Aave V4. Total deposits across the four hubs have reached approximately $262M, led by the Core Hub at $207M. Round 10 adds approximately $29M in additional Add Cap capacity (Core $24M, Prime $3M, Plus $2M), moving the total Add Cap ceiling from approximately $588M to approximately $618M. Draw Caps on affected assets are scaled to preserve existing Add/Draw ratios.

## Motivation

Utilization on several reserves supports additional headroom: USDC and WETH on the Core Main spoke, cbBTC on Core, sUSDe on the Plus Ethena Ecosystem spoke, and WETH on the Prime Bluechip spoke. On the borrow side, the USDG credit line drawn by the USDG Pendle spoke is fully utilized. Round 10 raises the relevant Add Caps and Draw Caps to accommodate continued growth while maintaining sufficient headroom.

## Specification

Round 10 targets approximately $29M in additional Add Cap capacity (Core $24M, Prime $3M, Plus $2M).

### Core Hub

| Spoke | Asset | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ----- | ----- | --------------- | ---------------- | ---------------- | ----------------- |
| Main  | USDC  | 12,500,000      | 15,000,000       | 12,500,000       | 15,000,000        |
| Main  | WETH  | 24,000          | 30,000           | 2,050            | 2,600             |
| Main  | cbBTC | 220             | 400              | 14               | 26                |

### Plus Hub

| Spoke            | Asset | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ---------------- | ----- | --------------- | ---------------- | ---------------- | ----------------- |
| Ethena Ecosystem | sUSDe | 6,000,000       | 8,000,000        | 0                | -                 |

### Prime Hub

| Spoke    | Asset | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ----- | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | WETH  | 3,200           | 5,000            | 0                | -                 |

### Credit Lines

The USDG Pendle spoke borrows Core Hub USDG liquidity while posting collateral on the Global Dollar Hub, in the absence of local supply. The draw is fully utilized, so we increase the USDG draw cap to accommodate demand while keeping credit line exposure at a controlled level relative to the available native supply.

| Spoke       | Asset | Current Draw Cap | Proposed Draw Cap |
| ----------- | ----- | ---------------- | ----------------- |
| USDG Pendle | USDG  | 15,000,000       | 20,000,000        |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260715_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260715.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260715_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260715.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/36)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
