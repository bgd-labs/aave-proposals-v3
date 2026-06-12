---
title: "Aave V4 Caps Increase #7"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/29"
---

## Summary

LlamaRisk recommends a seventh round of Add and Draw Cap increases for Aave V4. Following the broad cap increases in Round 6, deposit growth has concentrated in a subset of collateral assets, particularly across the Core and Prime hubs. This proposal focuses on restoring headroom for those reserves to support continued organic growth.
The proposed adjustments add approximately $38M of additional Add Cap capacity, with roughly $29M allocated to Core and $9M to Prime. Total Add Cap capacity increases from approximately $343M to $381M. Draw Caps on affected assets are scaled proportionally to preserve existing Add/Draw ratios.

## Motivation

Following the previous round of cap increases, deposit growth has been concentrated in a small set of collateral assets, driving utilization materially higher across several reserves. This proposal increases supply caps on the assets seeing the strongest organic inflows to restore headroom for continued growth and prevent cap constraints from limiting new deposits and position formation. On the borrow side, corresponding borrow caps are increased as utilization rises alongside collateral growth.

Following the execution of Round 6 caps, deposits have continued to grow. Total deposits grew from $117,825,486 to $154,978,671 (+32%).

The most notable inflows include frxUSD on the Core Main Spoke (+$9,999,920), USDG on the Core Main Spoke (+$9,925,222), WBTC on the Core Main Spoke (+$6,104,836), WBTC on the Prime Bluechip Spoke (+$3,331,940), wstETH on the Core Main Spoke (+$1,928,832).

Cap Utilization

The Core Hub now holds $135,740,922 in deposits (54% of Add Cap). The Prime Hub holds $18,812,522 (30% of Add Cap), while the Plus Hub remains at $425,227 (1%).

Three reserves across the protocol have exceeded 80% Add Cap utilization:

- **frxUSD** (Core Hub, Main): 100% Add Cap filled (30,000,402/30,000,000, $29,994,681)
- **USDG** (Core Hub, Main): 100% Add Cap filled (29,924,768/30,000,000, $29,924,768)
- **WBTC** (Core Hub, Main): 93% Add Cap filled (224.26/240, $14,195,947)

A further 7 reserves sit in the 50 to 80% range:

- **XAUt** (Core Hub, Gold): 74% filled
- **weETH** (Core Hub, Main): 70% filled
- **USDT** (Core Hub, Main): 61% filled
- **wstETH** (Core Hub, Main): 56% filled
- **WBTC** (Prime Hub, Bluechip): 55% filled
- **weETH** (Core Hub, Etherfi): 53% filled
- **wstETH** (Prime Hub, Bluechip): 51% filled

On the borrow side, several draw lines have reached or are near 100% draw utilization: USDT on Gold (99%), USDG and frxUSD on Forex (100%), and are addressed below.

Note: here the draw cap is a per-spoke borrow limit on a hub's own inventory, so the Gold and Forex lines are intra-Core draw caps. Only the cross-hub lines (Bluechip, Ethena Ecosystem) are credit lines in the strict sense.

## Specification

Round 7 targets approximately $38M in additional Add Cap capacity (Core +$29M, Prime +$9M), led by the WBTC and wstETH collateral increases. USDG and frxUSD on Core Main are held at their current 30M caps.

### Core Hub

| Spoke   | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Etherfi | WETH   | 0               | 0                | 8,500            | 13,000            |
| Etherfi | weETH  | 11,000          | 14,000           | 0                | 0                 |
| Forex   | USDG   | 0               | 0                | 90,000           | 250,000           |
| Forex   | frxUSD | 0               | 0                | 62,500           | 250,000           |
| Gold    | USDG   | 0               | 0                | 500,000          | 1,000,000         |
| Gold    | USDT   | 0               | 0                | 800,000          | 2,000,000         |
| Gold    | XAUt   | 1,000           | 1,800            | 0                | 0                 |
| Gold    | frxUSD | 0               | 0                | 500,000          | 1,000,000         |
| Main    | USDT   | 12,500,000      | 15,000,000       | 12,500,000       | 15,000,000        |
| Main    | WBTC   | 240             | 450              | 21               | 39                |
| Main    | weETH  | 1,500           | 2,200            | 0                | 0                 |
| Main    | wstETH | 4,400           | 6,000            | 0                | 0                 |

### Prime Hub

| Spoke    | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | WBTC   | 185             | 280              | 0                | 0                 |
| Bluechip | wstETH | 4,100           | 5,500            | 0                | 0                 |

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260612_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260612.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260612_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260612.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/29)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
