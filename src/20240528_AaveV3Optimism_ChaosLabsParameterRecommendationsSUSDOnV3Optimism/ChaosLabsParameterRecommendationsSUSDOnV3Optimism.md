---
title: "Chaos Labs Parameter Recommendations sUSD on V3 Optimism"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-parameter-recommendations-susd-on-v3-optimism-05-232024/17779"
---

## Simple Summary

Following sUSD’s depeg, after which the market was frozen on V3 Optimism, we provide an update and recommend future actions.

## Motivation

sUSD depegged on May 16, 2024, with its price reaching a low of 0.915 relative to USDC. As it was depegging, we provided a full analysis of the cause and a recommendation to freeze its Optimism market; sUSD has since repegged.

Market Response to Freezing

Following the market being frozen on May 16, we observed gradual withdrawals over the next four days, with about 1M sUSD withdrawn. However, starting May 20, withdrawals accelerated, and there are currently 5.16M sUSD deposited in the market.

On the other hand, the sUSD borrowed has been relatively stable, decreasing from 4.3M sUSD at the time of the freeze to 4.17M sUSD now. This is despite sUSD remaining depegged until May 21, incentivizing users who borrowed the asset to repay their debt.

Synthetix has also announced its transition plan for V3, which details how it will scale sUSD. These updates include expanding the collateral assets for sUSD from SNX alone to SNX, ETH, USDC, and other yield-generating collateral and governance-approved tokens. Additionally, the protocol has incentivized sUSD liquidity providers on Velodrome (Optimism; 10,000 OP tokens per week in the sUSD/USDC pool) and Curve (Ethereum; 20,000 SNX tokens per week in the sUSD/USDC/DAI/USDT pool); liquidity has begun to improve as a result of these incentives.

sUSD Exposure on Aave

sUSD is listed on Aave V3 Optimism as a frozen collateral asset and Aave V2 Ethereum as a frozen, non-collateral asset. Since the freeze on Optimism, we have observed a sharp decrease in value borrowed against sUSD, as well as the amount borrowed against sUSD in E-Mode. The reduction in E-Mode borrowed against is especially important, given the high LT afforded in this market.

Recommendations

Reduce Supply and Borrow Caps on Aave V3, Optimism: Given that the market’s size has decreased, as well as a decrease in on-chain supply — from 31M pre-freeze to 23.6M now — we recommend decreasing the supply and borrow caps ahead of unfreezing the asset. This will ensure that any future growth in the market is controlled and risk is minimized.

We recommend setting the caps according to our initial listing methodology, in which we determine the amount of an asset that can be liquidated with slippage lower than the LB, set at 1% in the stablecoin E-mode, and recommend the supply cap be double that amount. This leads us to a recommendation of a 7M sUSD supply cap and a borrow cap set at 80% of the supply cap at 5.6M sUSD.
Reduce Stablecoin E-Mode LT and LTV: We recommend reducing E-Mode LT and LTV for stablecoins in Optimism’s Stablecoin E-Mode. Reducing LTs will make the protocol more resilient to any potential depegs in the future, ensuring that there is larger buffer in the event a stablecoin’s price falls and liquidations occur. Additionally, lowering LTV will slightly reduce users’ stablecoin-stablecoin borrowing power, again reducing risk in these markets.

A 2% LT reduction on the Optimism V3 stablecoin E-mode category will make 18 accounts eligible for liquidation, potentially inducing $25K in new liquidations.
Adjust sUSD’s LTV and LT: Following the freeze of sUSD, its non-E-Mode LTV was dropped to 0%. Its current LT is 75%. Increasing the LTV will allow users to borrow non-stablecoin assets against their collateral, while adjusting the LT downwards will ensure the protocol has a larger buffer in the event of liquidations, whether from a depeg or from appreciation of borrowed assets.

We recommend increasing sUSD’s non-E-Mode LTV to 60% and reducing its non-E-Mode LT to 70%. At this time, this would lead to a negligible $8 in liquidation across 4 accounts.
Unfreeze the sUSD market on Optimism: While sUSD has repegged, we note that the ongoing deprecation of synth assets may continue to cause peg volatility. The discount rate, which dictates the value synth asset holders can receive when they redeem, will continue to be lowered in an effort to deprecate these markets. Synth asset holders may request a redemption at parity, which, in the future, may carry some time-based conditions (i.e., sUSD is sent to the redeeming user over the course of weeks or months) to reduce the potential impact on sUSD’s peg. While the Synthetix Council has an incentive to ensure redemptions of synth assets with minimal price impacts, whether to the synth assets or sUSD, these time-based conditions are not codified.

Given this, as well as the reduced supply/borrow caps and E-Mode LT/LTV, we recommend unfreezing the market.
We would like to thank @kaleb and the Synthetix team for their collaboration, insights on the situation, and guidance on the protocol and governance mechanisms to stabilize the peg.

## Specification

| Asset | Parameter  | Current    | Rec       |
| ----- | ---------- | ---------- | --------- |
| sUSD  | Supply cap | 20,000,000 | 7,000,000 |
| sUSD  | Borrow cap | 13,000,000 | 5,600,000 |
| sUSD  | LT         | 75%        | 70%       |
| sUSD  | LTV        | 0.0%       | 60%       |

Stablecoin E-Mode Specifications

| Parameter | Current | Rec |
| --------- | ------- | --- |
| LT        | 95%     | 93% |
| LTV       | 93%     | 90% |

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/ad5c895c51906be7b3ab7d2e61e6570644f3cbf5/src/20240528_AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism/AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/ad5c895c51906be7b3ab7d2e61e6570644f3cbf5/src/20240528_AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism/AaveV3Optimism_ChaosLabsParameterRecommendationsSUSDOnV3Optimism_20240528.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xa66afef5e247d9369831e874a60d022ce6b12645b41d9a244077a3a279ef24f3)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-parameter-recommendations-susd-on-v3-optimism-05-232024/17779)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
