---
title: "sUSD Risk Parameter Adjustment"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-susd-risk-parameter-adjustment/20793"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x5c744451272991c7fdf8b3830fa2a51fc18dd0e417d95d9c16da765b27f602ff"
---

## Simple Summary

This proposal continues on the proposed steps from [this post](https://governance.aave.com/t/susd-depeg-update-05-16-2024/17719) by recommending the removal of sUSD as collateral on Aave V3’s Optimism. Additionally, we recommend reducing the LT and LTV of the Stablecoin E-Mode on Optimism, which sUSD is part of, and setting sUSD LTV to 0.

## Motivation

This recommendation follows the recent proposal to reduce the supply and borrow cap of sUSD to 10m and 1, respectively; that adjustment follows a period of reduced sUSD DEX liquidity, which dropped to a buy-side low of $2M before recovering after the introduction of token incentives.

During this period, shorting activity on sUSD was observed between January 9th and January 15th. Following the implementation of token incentives on January 16th, as detailed in [this announcement](https://x.com/synthetix_io/status/1878944713446924552), these short positions were closed, and new borrowing demand primarily originated from users farming the newly introduced incentives.

Below, we present a table of the current sUSD borrows on Aave and the associated strategy exposure. The distribution of such strategies seems to be quite dispersed, with the recent incentive structure leading to demand to create perpetual positions on Synthetix coupled with liquidity pool growth rather than short positions.

| User                                       | Action  | Size | Date            |
| ------------------------------------------ | ------- | ---- | --------------- |
| 0xD8b88C185e06eBF8C58B7dc8b7AFf18304CdD888 | Short   | 350k | Jan 9 to Jan 15 |
| 0x49bf093277bf4dde49c48c6aa55a3bda3eedef68 | LP      | 150k | 16th            |
| 0x407cff84eeaacda390fe302c99fa5dd32521bc53 | Holding | 400k | 16th            |
| 0xe31deacee1770dfa56f8849724bcb7f8e5f76ef2 | LP      | 130k | 16th            |
| 0xf7ca1f0ff0995c84fef530f7c74c69fb80331e81 | Perp    | 200k | 16th            |
| 0x9644a6920bd0a1923c2c6c1dddf691b7a42e8a65 | Perp+LP | 750k | 16th            |
| 0xfd81b27d9796a1ba7d7171ea70010c9befb2a62a | Perp    | 380k | 17th            |

### Peg Dynamics and Mechanism Design

An analysis of the peg and utilization dynamics revealed that the price deviation of sUSD can be attributed to a combination of multiple factors, including traders profiting from the Synthetix Perpetual platform, the lack of interest rate on sUSD debt in an environment of heightened rates, and the ongoing migration to Synthetix V3, which reduces demand for sUSD. This created an imbalance as this excess supply was not met with proportional demand, putting downward pressure on the price of sUSD. This conclusion is supported by the increase in sUSD’s market cap, which closely followed the downward price deviation and the growth in interest rates.

While this behavior does not pose a risk to sUSD’s fundamental backing, the exit of sUSD’s price from its concentrated liquidity range reduced buy-side liquidity, thereby increasing Aave’s risk to sUSD positions. This liquidity constraint underpinned the recommendation to reduce caps, aiming to mitigate Aave’s risk.

### Removing sUSD as Collateral

With the recent deterrence of the creation of new sUSD debt on Aave and continued minimized supply exposure, the majority of outstanding debt is fundamentally leveraged to explicitly contribute to the recent sUSD incentive programs by minimizing effective peg exposure. However, while highly overcollateralized, the current economics associated with the soft peg mechanism is fundamentally shaky; minimizing the usage of sUSD as collateral is recommended to be performed as a preventive measure. The current distribution of such sUSD-collateralized stablecoin debt positions is highly conservative, as can be seen below, thereby requiring a significant depeg to start contributing negatively to the Aave protocol, and the expectation is such that exposure will continue to be minimized over time, as has been the case with a 3M reduction in supply on Aave (25%) over the last 7 days.

Moreover, during a swift depeg event 7 months ago, we proposed an immediate LTV0 change due to the deprecation of their spot synths contributing to significant downward pressure, as can be seen [here](https://governance.aave.com/t/susd-depeg-update-05-16-2024/17719). The fundamental characteristics of the asset eventually improved once more through mechanical changes on Synthetix’s side in the redemption process, leading to the unfreezing of the asset, as seen in [this](https://governance.aave.com/t/arfc-chaos-labs-parameter-recommendations-susd-on-v3-optimism-05-23-2024/17779) post. However, we continued to reduce exposure significantly in the form of decreasing caps, coupled with decreasing LTV/LTs in both the general market and E-Mode configuration, leading to a more conservative state. As such, a significant buffer of 6% price movement already exists between the collateral value at the LT and the bad debt threshold of 1/(1+LB) in e-mode itself.

## Recommendation

To further improve this safety buffer and given the conservative distribution of collateralized debt positions throughout the stablecoin E-Mode config on Optimism, we recommend decreasing the LTV/LT in Stablecoins E-Mode while minimizing induced liquidations.

Considering the current positioning within the E-Mode, we estimate the optimal LT reduction to be 87%. While we intend to deprecate the E-Mode and remove sUSD from it progressively, this change poses an initial step in that direction. Chaos Labs will monitor the market and introduce additional Liquid E-Modes if demand for a stablecoin-correlated E-Mode remains.

The change to 87% LT is expected to cause the liquidation of $95K of collateral.

The liquidations caused at the recommended LT are primarily stablecoins with significant liquidity to support the minimal liquidation size, with sUSD liquidations only representing $2.4K, or 3.2%.

Additionally, we recommend setting the LTV of sUSD outside of the Stablecoin Correlated E-Mode to 0; this measure will prevent additional borrowing from being performed using sUSD as collateral, hence limiting the future risk posed by an sUSD downward deviation.

This measure will simultaneously apply to both sUSD parameters within and outside of the E-Mode, hence limiting the opening of new positions.

Following an improvement of the sUSD peg and a reduction in sUSD-denominated collateral, Chaos Labs will reinstate the borrow cap to a defined value determined by our methodology.

## Specification

For the sUSD asset on Aave V3 Optimism instance, we recommend the following:

| Asset | Deployment | Current LTV | Rec. LTV |
| ----- | ---------- | ----------- | -------- |
| sUSD  | Optimism   | 60.00%      | 0.00%    |

For the Stablecoin E-Mode on Aave V3 Optimism instance, we recommend the following:

| Parameter           | Current Value | Rec. Value |
| ------------------- | ------------- | ---------- |
| LTV                 | 90.00%        | 0.01%      |
| LT                  | 93.00%        | 87.00%     |
| Liquidation Penalty | 1.00%         | 1.00%      |

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_AaveV3Optimism_SUSDRiskParameterAdjustment/AaveV3Optimism_SUSDRiskParameterAdjustment_20250220.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250220_AaveV3Optimism_SUSDRiskParameterAdjustment/AaveV3Optimism_SUSDRiskParameterAdjustment_20250220.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x5c744451272991c7fdf8b3830fa2a51fc18dd0e417d95d9c16da765b27f602ff)
- [Discussion](https://governance.aave.com/t/arfc-susd-risk-parameter-adjustment/20793)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
