---
title: " WBTC Reserve Factor and UOptimal Increase "
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-reserve-factor-and-uoptimal-increase-10-25-24/19596"
snapshot: "Direct-to-AIP"
---

## Simple Summary

Chaos Labs recommends adjusting WBTC’s parameters on all Aave V3 instances to increase the Aave DAO revenue while optimizing to meet the demand from yield-bearing BTC collateral assets. In this proposal, we recommend the following changes to WBTC:

- Increasing the Reserve Factor
- Increasing the UOptimal

## Motivation

The incoming addition of BTC correlated E-Modes with the launch of Aave v3.2 Liquid E-Modes, and the increasing popularity of staked, yield-bearing BTC assets is expected to boost the demand for borrowing non-yield-bearing assets like WBTC.

Given WBTC’s historical use mainly as a collateral asset and its supply being largely unaffected by changes in the supply rate, we see this as an opportunity to significantly boost DAO revenue without adversely impacting WBTC deposits.

The adjustments to the Reserve Factor and UOptimal are designed to manage this increased demand while ensuring the protocol’s stability and attractiveness.

### Reserve Factor

WBTC has historically been an asset predominantly used as collateral, as evidenced by the borrow distribution, where stablecoins represent over 87% of the borrows against WBTC collateral. Additionally, more than 99% of the current WBTC supply is enabled as collateral, further supporting its primary use case within the market.

As illustrated in the plot below, previous increases in the supply rate for WBTC have not significantly boosted deposits. While the protocol attracted over $2.5B in WBTC, the supply rate never exceeded 0.15%, a minimal and inconsequential yield. This indicates that most WBTC suppliers are largely indifferent to supply rates, using WBTC primarily as collateral rather than for yield generation.

Given the minimal impact of WBTC’s supply rate on its supply behavior, we propose raising WBTC’s Reserve Factor from 20% to 50%. A similar change was done for weETH shortly after the launch of incentives and it had a positive effect on aligning the users with the market’s main goal.

This substantial increase is also expected to significantly boost revenue for the Aave protocol, with additional revenue growth anticipated as the introduction of BTC/BTC E-Modes drives further borrow demand for WBTC.

Chaos Labs will closely monitor the market and user’s behavior and will recommend further adjustments to the Reserve Factor accordingly.

### UOptimal

We recommend increasing UOptimal from 45% to 80%. This adjustment will accommodate a higher utilization rate, enabling the market to meet an increase in borrow demand. The current Kink set at 45% is optimal for assets that either lack significant borrow demand or are yield-bearing. However, with the emergence and growth of liquid-staked BTC assets, WBTC transitions from a category of limited borrow demand to one with substantial borrow demand. This shift necessitates the recommended change in UOptimal to better align with the new market dynamics.

While this adjustment will lead to a further reduction in the supply rate, we anticipate it will not negatively impact WBTC supply.

### Revenue

Given the current market’s minimal borrow demand and low supply rates, these changes are unlikely to negatively impact existing users and suppliers. Following the adjustments, the APY for supplying WBTC on Ethereum is expected to decrease from 0.0414% to 0.0146%. In turn, we anticipate that the DAO’s annual revenue from all the WBTC markets will increase by over 40% before the addition of new BTC/BTC E-Modes.

## Specification

By implementing these recommendations, Aave adapts itself to the evolving market while improving the DAO’s revenue. As always, Chaos Labs will continue monitoring market conditions closely and recommend additional adjustments to ensure Aave’s safety and efficiency.

| **Parameter**  | **Current Value** | Recommended Value |
| -------------- | ----------------- | ----------------- |
| Reserve Factor | 20%               | 50%               |
| UOptimal       | 45%               | 80%               |

We recommend applying the changes to the following V3 deployments:

- Ethereum - Main
- Optimism
- Arbitrum
- Polygon

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Ethereum_WBTCReserveFactorAndUOptimalIncrease_20241120.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Polygon_WBTCReserveFactorAndUOptimalIncrease_20241120.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Optimism_WBTCReserveFactorAndUOptimalIncrease_20241120.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Arbitrum_WBTCReserveFactorAndUOptimalIncrease_20241120.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Ethereum_WBTCReserveFactorAndUOptimalIncrease_20241120.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Polygon_WBTCReserveFactorAndUOptimalIncrease_20241120.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Optimism_WBTCReserveFactorAndUOptimalIncrease_20241120.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/bc6cb8c2474e2ca9a09e757e07269139f2295eb6/src/20241120_Multi_WBTCReserveFactorAndUOptimalIncrease/AaveV3Arbitrum_WBTCReserveFactorAndUOptimalIncrease_20241120.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-reserve-factor-and-uoptimal-increase-10-25-24/19596)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
