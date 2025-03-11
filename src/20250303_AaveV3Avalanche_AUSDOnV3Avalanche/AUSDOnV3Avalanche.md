---
title: "AUSD on V3 Avalanche"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameters-update-ausd-on-v3-avalanche/21201"
---

## Simple Summary

Chaos Labs recommends making AUSD into a collateral asset on Aave V3’s Avalanche Deployment.

## Motivation

AUSD is a stablecoin native to Avalanche; in November 2024, we [provided](https://www.notion.so/AUSD-Collateral-1a457ab37ebf8011bb76e35244988b6e?pvs=21) a detailed recommendation for listing for the asset. At the time, we stated that, because “stablecoins on Aave typically show little demand as collateral due to their primary role as borrowable assets, we recommend setting AUSD as non-collateral. This aligns with AUSD’s relatively volatile liquidity profile and limited operational history.”

We now have a greater historical record on which to judge the asset and its suitability as collateral, especially its liquidity profile. The asset’s liquidity has been steadily growing since October 2024, currently pooled against about $10M worth of USDC and USDT.

Additionally, AUSD’s peg stability has improved, with just 1.56% daily annualized volatility over the last 30 days.

### AUSD Usage on Aave

The AUSD market is currently slightly underutilized, with a utilization rate of 61.29%.

Borrows of the asset have fallen slightly from their peak, while the supply has remained relatively stable. Supplying is currently incentivized, with an 8.24% asAVAX APR.

BTC.b has consistently been the most popular collateral asset for AUSD debt, followed by USDC.

Elsewhere on Avalanche, borrow rates for stablecoins have been following. Given the current incentives, allowing AUSD as collateral could increase borrowing of other stablecoins, as users seek to arbitrage their rates.

While AUSD-AUSD looping is possible and has been observed on other protocols, the implementation of [Merit](https://governance.aave.com/t/arfc-merit-a-new-aave-alignment-user-reward-system/16646) provides the protocol with more granular control over rewards, allowing the DAO to limit the incentives that can be obtained through looping.

### LB, LTV, and LT

We recommend a Liquidation Bonus of 6.00% for AUSD, aligning with other, smaller stablecoins like FRAX on Arbitrum. Taking this larger LB into account, we recommend an LT of 72.00% and an LTV of 69.00%.

## Specification

| Parameter             | Value  |
| --------------------- | ------ |
| Asset                 | AUSD   |
| Liquidation Bonus     | 6.00%  |
| LTV                   | 69.00% |
| Liquidation Threshold | 72.00% |

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/a82b6a6b3b4c67766d4cd48ce6a2003e07303f00/src/20250303_AaveV3Avalanche_AUSDOnV3Avalanche/AaveV3Avalanche_AUSDOnV3Avalanche_20250303.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/a82b6a6b3b4c67766d4cd48ce6a2003e07303f00/src/20250303_AaveV3Avalanche_AUSDOnV3Avalanche/AaveV3Avalanche_AUSDOnV3Avalanche_20250303.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameters-update-ausd-on-v3-avalanche/21201)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
