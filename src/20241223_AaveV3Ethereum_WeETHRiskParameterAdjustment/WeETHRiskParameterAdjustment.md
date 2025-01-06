---
title: "weETH Risk Parameter Adjustment"
author: "ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-weeth-risk-parameter-adjustment/20167"
---

## Simple Summary

A proposal to adjust weETH’s LTV, LT, and LB on the Ethereum Core instance.

## Motivation

weETH’s collateral parameters are currently set to 72.5%, 75%, and 7.5% for LTV, LT, and LB, respectively, on Ethereum — Core. Following observations of user behavior and on-chain liquidity, we are able to recommend adjusting these parameters to make the asset more efficient as collateral. The vast majority of debt against weETH is WETH, making these positions low-risk due to weETH’s utilization of the ETH/USD oracle augmented with its exchange rate.

Additionally, as displayed above, 96% of borrowing is done in E-Mode, relying on different collateral values.

weETH has remained highly liquid against USDT, the top uncorrelated debt asset on Ethereum, indicating that liquidations of uncorrelated positions could be efficiently liquidated.

Our simulations, which take into account on-chain liquidity and user behavior and distribution, indicate that the protocol can increase LTV and LT for weETH, along with decreasing its LB. We recommend maintaining the 2.5 percentage point buffer between LTV and LT.

When reducing LB, it is also critical to note that the asset has not experienced significant depegs from its exchange rate value relative to ETH; its average discount over the last three months was just 5.6 bps. Large discounts can reduce the effective LB and prevent liquidations from being processed.

## Specification

| Asset | Network  | Instance | Current LTV | Recommended LTV | Current LT | Recommended LT | Current LB | Recommended LB |
| ----- | -------- | -------- | ----------- | --------------- | ---------- | -------------- | ---------- | -------------- |
| weETH | Ethereum | Core     | 72.5%       | 77.5%           | 75%        | 80%            | 7.5%       | 7%             |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/18db65171fa37d4e0de8bcb7c3477cfde4f4ba36/src/20241223_AaveV3Ethereum_WeETHRiskParameterAdjustment/AaveV3Ethereum_WeETHRiskParameterAdjustment_20241223.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/18db65171fa37d4e0de8bcb7c3477cfde4f4ba36/src/20241223_AaveV3Ethereum_WeETHRiskParameterAdjustment/AaveV3Ethereum_WeETHRiskParameterAdjustment_20241223.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-weeth-risk-parameter-adjustment/20167)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
