---
title: "Risk Parameter Updates - OP on V3 Optimism"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-op-on-v3-optimism/17326"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xbaaf99c1e738da5755166fc6b1429265243507fdb9638a31ca177dd81a8b7313"
---

## Simple Summary

A proposal to increase OP’s liquidation threshold and LTV on Aave V3 Optimism.

## Motivation

OP is currently configured with a liquidation threshold (LT) of 40% and max loan-to-value (LTV) of 30%. These parameters were intentionally set conservatively and in isolation mode, when the asset was first listed to ensure mechanisms were working as intended. In October 2023, OP was removed from isolation mode. Following our observations, we believe it prudent to increase the LT and LTV for OP.

OP’s average market cap over the past 180 days is $1.78BN, and its daily average volume is $192M.
It has registered a daily annualized volatility of 98.53%, a 30-day annualized volatility of 92.6%, and its largest single-day price drop was 17.7%.
3.7M of the 7.4M OP supplied is supplied by a single user, who also maintains large positions on Arbitrum and Ethereum. Their last deposit on Optimism was 252K OP on March 12; they repaid $1M USDT on April 6 and currently hold a health score of 2.02.
In general, supply has been trending steadily upwards.
The majority of assets borrowed against OP collateral are stablecoins. That puts these positions at risk of liquidation in the event OP’s price moves falls.
However, collateral at risk does not exceed $100K until OP’s price falls to $2.13, a 35% drop from current levels.

Given these observations, we recommend first aligning OP’s parameters with ARB’s on Arbitrum (50% LTV and 60% LT), an asset with a similar supply distribution and liquidity profile. Following observations at these levels and utilizing our simulation platform, these parameters may be further optimized.

## Specification

| Chain    | Asset | Current LTV | Recommended LTV | Current LT | Recommended LT |
| -------- | ----- | ----------- | --------------- | ---------- | -------------- |
| Optimism | OP    | 30.00%      | 50.00%          | 40.00%     | 60.00%         |

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240415_AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism/AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240415_AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism/AaveV3Optimism_RiskParameterUpdatesOPOnV3Optimism_20240415.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xbaaf99c1e738da5755166fc6b1429265243507fdb9638a31ca177dd81a8b7313)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-op-on-v3-optimism/17326)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
