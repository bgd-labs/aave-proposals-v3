---
title: "Umbrella Deficit Updates"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-revenue-indexed-deficit-offsets-for-umbrella/24000"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xfcd429c8fcb5fc44a0bea9bf078726ef48b1c76ca1039a8c6c9dff23f4547e30"
---

## Simple Summary

Umbrella makes deficit handling explicit and mechanically enforceable. Once a reserve deficit is realized on-chain, the protocol applies a senior, DAO-backed first-loss layer (the deficitOffset) before any impairment is passed through to Umbrella stakers. Conceptually, the deficitOffset is the protocol’s equity buffer: it is the amount of realized loss the DAO is willing to absorb in that reserve before invoking the backstop.

The core issue is not the existence of this equity layer, but its calibration. Today, deficitOffset is not systematically linked to the protocol’s own realized upside from the same liquidation machinery that occasionally generates deficits. This disconnect is notable because liquidation recapture has never been intended as “free revenue” in isolation. Protocol liquidation fees and, more recently, SVR, have always served a dual purpose: they are mechanisms through which the protocol internalizes part of the liquidation surplus, not only to align incentives, but also to strengthen the system’s ability to absorb future losses. In other words, liquidation-linked profitability has always been conceptually part of the protocol’s security and coverage loop; an earnings stream meant to reinforce resilience over time.

This proposal increases the Umbrella Deficit Offset on USDC, USDT, WETH, GHO and covers existing deficit on CRV, ENS, USDC, USDT and WETH.

## Motivation

Aave liquidations are often discussed as a pure solvency mechanism, but economically, they function as a decentralized execution engine. The protocol effectively delegates liquidation execution to third parties through a liquidation bonus, and in return, the system obtains two meaningful forms of realized value: protocol-level liquidation fees and value recaptured through SVR. In aggregate, liquidation activity therefore exhibits a familiar risk-return structure: frequent, generally positive cash flows punctuated by rare tail losses when liquidation is incomplete, delayed, or occurs under adverse microstructure.

Umbrella changes the allocation of those tail outcomes. Deficits, once realized, can immediately translate into slashing unless buffered by deficitOffset. Meanwhile, the positive cash flows generated during the same regimes accrue to the DAO treasury. Over time, this can create a skewed payoff profile: the treasury retains most of the “upside” from liquidation activity, while Umbrella participants are positioned as the primary absorbers of the downside from the liquidation tail.

The deficitOffset layer is intended to mitigate exactly this problem by placing an equity buffer ahead of the stakers. But if deficitOffset is not responsive to realized earnings from liquidation activity, it may understate the DAO’s effective capacity to absorb moderate losses, leading to slashing in regimes where the protocol is net-profitable and where a more coherent risk-sharing arrangement would have funded the loss through retained liquidation earnings.

## Specification

Independent of the long-run oracle policy, current conditions argue for a near-term normalization of deficit offsets on the largest stablecoin debt reserves. Since Umbrella went live, USDC and USDT have been material contributors to protocol revenue through liquidation-linked activity, accounting for 95% of such revenue. Yet the currently configured deficit offsets on these reserves remain relatively low compared to (i) the scale of liquidation-linked revenues they have generated and (ii) the practical role the offset is meant to play as the DAO’s first-loss layer ahead of stakers. In that context, the present configuration risks forcing Umbrella to absorb losses on deficits that are economically small relative to the surplus the protocol has already accumulated from the same liquidation engine.

A pragmatic step is therefore to increase deficit offsets to a higher, more representative level, such that the equity layer meaningfully reflects current protocol earnings capacity and reduces the likelihood of repeated “small-to-mid” slashing episodes in liquidation-heavy regimes. This does not remove slashing as a backstop for severe tail outcomes; it simply ensures that the system’s senior buffer is sized commensurate with the reserve’s demonstrated profitability and the DAO’s balance-sheet intent. Under the revenue quantifications outlined above, that maps naturally to the following concrete offset targets.

| Reserve |   Instance    | Current Deficit Offset | Recommended Deficit Offset |
| :------ | :-----------: | :--------------------: | :------------------------: |
| USDC    | Ethereum Core |        100,000         |         1,300,000          |
| USDT    | Ethereum Core |        100,000         |         1,600,000          |
| WETH    | Ethereum Core |           50           |             77             |
| GHO     | Ethereum Core |        100,000         |          115,000           |

In parallel, the DAO should clear the currently outstanding deficits through the offset path via the steward, so that the reserves return to a clean baseline before the oracle-driven regime is introduced. Concretely, this entails covering the following realized deficits:

| Reserve |   Instance    | Current Deficit | Current Deficit ($) |
| :------ | :-----------: | :-------------: | :-----------------: |
| USDT    | Ethereum Core |     10,134      |       10,134        |
| USDC    | Ethereum Core |     51,185      |       51,185        |
| WETH    | Ethereum Core |       8.1       |       18,320        |
| CRV     | Ethereum Core |     394,356     |       111,980       |
| ENS     | Ethereum Core |      5,768      |       39,400        |

## Implementation design

The proposal is split into two payloads. The first payload can be executed independently under normal conditions. The second payload assumes that the required tokens (CRV/ENS) will be acquired and transferred to the Collector address in parallel. It is separated to account for scenarios where the token acquisition may be delayed or unsuccessful. This ensures that the first payload can be executed on its own, without being blocked by the second, allowing for independent execution at different times.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/b9ad1a1e6922ca930e2d5b033744d75627886287/src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/AaveV3Ethereum_UmbrellaDeficitUpdates_20260313.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/b9ad1a1e6922ca930e2d5b033744d75627886287/src/20260313_AaveV3Ethereum_UmbrellaDeficitUpdates/AaveV3Ethereum_UmbrellaDeficitUpdates_20260313.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xfcd429c8fcb5fc44a0bea9bf078726ef48b1c76ca1039a8c6c9dff23f4547e30)
- [Discussion](https://governance.aave.com/t/arfc-revenue-indexed-deficit-offsets-for-umbrella/24000)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
