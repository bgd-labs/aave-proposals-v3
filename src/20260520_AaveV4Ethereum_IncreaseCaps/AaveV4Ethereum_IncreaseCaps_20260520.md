---
title: "Aave V4 Caps Increase #4"
author: "Llama Risk (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/23"
---

## Summary

LlamaRisk recommends a fourth round of Add and Draw Cap increases for Aave V4 across the Core and Prime hubs, bringing the total supply cap ceiling to approximately $180M. Following the execution of Round 3 cap increases, deposits have continued to grow strongly and frxUSD on Core/Main has filled to 100% Add Cap utilization. With incentive programs for both frxUSD and USDG launching this week, this round combines an explicit incentive-driven cap adjustment on those two assets with smaller, utilization-driven bumps on the collateral and stablecoin reserves that support cross-hub borrow demand.

The proposed adjustments add approximately $41M in additional supply cap capacity. The Core Hub receives +$33M, the bulk of which is the frxUSD and USDG step-up to 10M each. The Prime Hub receives +$7M to scale Bluechip collateral capacity that feeds cross-hub borrowing into the new stable caps. Two existing cross-hub credit lines (frxUSD and USDT to Bluechip) are scaled to support the larger stablecoin headroom; USDG is kept on Core/Main only this round so that one utilization cycle is observed before opening cross-hub exposure. The Plus Hub is excluded as current utilization does not warrant adjustment. Draw Caps are scaled proportionally, preserving existing Add/Draw ratios.

## Motivation

This round serves two intersecting demand signals.

1. Incentive programs are launching on frxUSD and USDG. The reward programs are to be rolled out on both stablecoins beginning the week of May 21st. To absorb the expected supply-side inflows without compressing reward APYs into invisibility, the Core/Main caps for both assets are raised in a single tranche to 10,000,000. A single-tranche move gives the rewards program a stable target and avoids mid-incentive cap exhaustion. frxUSD on Core/Main is already at 100% Add Cap utilization independent of the incentive, which directly validates the argument.

2. Collateral capacity to generate borrow demand for the new stable caps. Larger frxUSD/USDG supply only earns yield if there is matched borrow demand. Round 4 also bumps high-utilization collateral on Core/Main (WETH, WBTC, wstETH, weETH, LINK) and on Prime/Bluechip (WBTC, wstETH, WETH, cbBTC) so that depositors of BTC and ETH variants have room to draw frxUSD and/or USDG against their collateral.

The frxUSD and USDG targets are sized against observable DEX liquidity. Approximately $16M of frxUSD can be sold to bluechip stablecoins (USDC, USDT) on Curve and Uniswap V3 with manageable slippage, and approximately $5M of USDG can be sold to bluechip stables on the same venues. Both figures comfortably exceed the proposed 10M caps under nominal flow with the peg stability buffer sitting tight historically for both assets.

## Specification

We target approximately $41M in additional supply cap capacity, allocated to Core (+$33M) and Prime (+$7M). frxUSD and USDG on Core/Main are raised in a single tranche to 10M each to absorb incentive-program inflows. Other tight-cap reserves (>80% filled) receive modest 20–33% bumps rather than the 2–3x increases used in earlier rounds. Cross-hub credit lines for frxUSD and USDT to the Bluechip and Gold spokes are scaled to match the larger stable headroom on Core/Main.

For the EtherFi and Lido spokes, WETH Draw Caps are sized to match the respective collateral Add Caps, supporting full strategy capacity.

### Core Hub

| Spoke   | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| ------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Etherfi | WETH   | 0               | -                | 6,500            | 8,500             |
| Etherfi | weETH  | 6,500           | 8,500            | 0                | -                 |
| Lido    | WETH   | 0               | -                | 4,000            | 4,800             |
| Lido    | wstETH | 4,000           | 4,800            | 0                | -                 |
| Main    | LINK   | 185,000         | 220,000          | 0                | -                 |
| Main    | USDG   | 3,500,000       | 10,000,000       | 2,360,000        | 6,800,000         |
| Main    | USDT   | 7,000,000       | 8,500,000        | 7,000,000        | 8,500,000         |
| Main    | WBTC   | 110             | 170              | 9                | 15                |
| Main    | WETH   | 14,500          | 18,500           | 1,250            | 1,600             |
| Main    | frxUSD | 4,500,000       | 10,000,000       | 3,060,000        | 6,800,000         |
| Main    | weETH  | 800             | 1,000            | 0                | -                 |
| Main    | wstETH | 2,150           | 2,800            | 0                | -                 |

### Prime Hub

| Spoke    | Asset  | Current Add Cap | Proposed Add Cap | Current Draw Cap | Proposed Draw Cap |
| -------- | ------ | --------------- | ---------------- | ---------------- | ----------------- |
| Bluechip | USDC   | 2,500,000       | 3,000,000        | 2,910,000        | 3,500,000         |
| Bluechip | USDT   | 2,500,000       | 3,000,000        | 3,130,000        | 3,750,000         |
| Bluechip | WBTC   | 90              | 120              | 0                | -                 |
| Bluechip | WETH   | 1,700           | 2,200            | 0                | -                 |
| Bluechip | cbBTC  | 45              | 60               | 0                | -                 |
| Bluechip | wstETH | 1,800           | 2,400            | 0                | -                 |

Draw Caps are scaled proportionally to their corresponding Add Caps, preserving existing Add/Draw ratios. For the EtherFi and Lido spokes, WETH Draw Caps are sized to match the respective collateral Add Caps, supporting full strategy capacity. All increases remain well within the equivalent market sizes observed on Aave V3 Core Instance and are sized conservatively against available DEX liquidity for liquidation feasibility.

### Stablecoin Assessment

This round’s stablecoin sizing is driven primarily by the upcoming incentive programs on frxUSD and USDG:

- frxUSD (Core Main): raised from 4,500,000 to 10,000,000 to provide capacity for the launching incentive program. The reserve is already at 100% Add Cap utilization without incentives, so the move addresses an immediate organic constraint as well. Sized against approximately $16M of available DEX exit liquidity to bluechip stablecoins (USDC, USDT) on Curve and Uniswap V3, which comfortably covers the new cap under stressed unwind scenarios.
- USDG (Core Main): raised from 3,500,000 to 10,000,000 on the same incentive basis. Sized against approximately $5M of available DEX exit liquidity to bluechip stablecoins.
- USDT (Core Main): raised modestly from 7,000,000 to 8,500,000 to maintain headroom alongside the frxUSD/USDG expansion.
- USDC and USDT (Prime Bluechip): raised to 3,000,000 each to support cross-hub borrow demand from the new stable caps.

The following stablecoins are left unchanged this round:

- USDC (Core Main): 6,000,000 cap remains adequate at current utilization.
- GHO (Core Main and Prime Bluechip): sufficient capacity in both hubs.
- USDC (Core Forex): small dedicated pool with adequate remaining capacity.

### Credit Lines

To support the larger frxUSD cap on Core/Main and the elevated Bluechip-to-Core borrowing demand observed after Round 3, the Core-to-Bluechip credit lines for frxUSD and USDT are scaled up. The USDT line, which reached full utilization following Round 3, is the most acute constraint. The frxUSD line is sized to scale roughly with the new 10M main cap so that Bluechip collateral borrowers can reach the new stable capacity.

| Origin   | Target Spoke | Asset  | Current Credit Line | Proposed Credit Line | Notes                               |
| -------- | ------------ | ------ | ------------------- | -------------------- | ----------------------------------- |
| Core Hub | Bluechip     | USDT   | 625,000             | 1,250,000            | Was 100% utilized following Round 3 |
| Core Hub | Bluechip     | frxUSD | 300,000             | 1,000,000            | Scaled with 10M main cap            |

No new USDG credit lines are opened this round, USDG remains on Core Hub for the time being before extending cross-hub exposure. The Core-to-Bluechip USDC, EURC, and GHO credit lines and the Core-to-Ethena-Ecosystem credit lines are unchanged, consistent with the exclusion of the Plus Hub and the absence of meaningful borrowing on those reserves.

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260520_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260520.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave/aave-proposals-v3/blob/main/src/20260520_AaveV4Ethereum_IncreaseCaps/AaveV4Ethereum_IncreaseCaps_20260520.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/23)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
