---
title: "Risk Parameter Updates GNO on V3 Gnosis"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-gno-on-v3-gnosis/17340"
---

## Simple Summary

A proposal to update GNO’s liquidation threshold, LTV, and debt ceiling on V3 Gnosis.

## Motivation

GNO has an average market cap of $445M and a daily trading volume of $3M over the last 180 days. Over this same timeframe, the largest single-day drop was 9.11%, with a daily annualized volatility of 63.75% and a 30-day daily annualized volatility of 94.46%.

GNO is currently listed with relatively conservative parameters: 36% LT and 31% LTV. We recommend an increase to 50% and 45%, respectively. Following observations at these levels and utilizing our simulation platform, these parameters may be further optimized.
Given current market conditions and utilizing our Isolation Mode Methodology we recommend doubling the debt ceiling to $2M.

## Specification

| Asset | Parameter    | Current    | Recommended |
| ----- | ------------ | ---------- | ----------- |
| GNO   | LT           | 36.00%     | 50.00%      |
| GNO   | LTV          | 31.00%     | 45.00%      |
| GNO   | Debt Ceiling | $1,000,000 | $2,000,000  |

## References

- Implementation: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240415_AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis/AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415.sol)
- Tests: [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240415_AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis/AaveV3Gnosis_RiskParameterUpdatesGNOOnV3Gnosis_20240415.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-gno-on-v3-gnosis/17340)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
