---
title: "[Direct to AIP] XAUt Supply Cap and Debt Ceiling Adjustment on Aave V3 Core Instance"
author: "Chaos Labs (implemented by ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-xaut-supply-cap-and-debt-ceiling-adjustment-on-aave-v3-core-instance/23466"
---

## Simple Summary

Chaos Labs proposes increasing the XAUt debt ceiling and supply cap following strong utilization and demand. Thanks to strong liquidity, improved market efficiency and safe user behaviour, the growth of the asset does not introduce additional risk. Below is our analysis and recommendation.

## XAUt

XAUt has now reached its \$3M debt ceiling, placing the market effectively at full borrowing demand capacity. While debt expanded sharply over the past week, including a roughly \$1M increase in a single day, signaling clear user interest, incremental demand is thus currently being forced to the sidelines by the binding cap. In practice, this means observed borrow growth is supply-constrained rather than demand-exhausted, and any further uptake is deferred until additional headroom is made available.

![Screenshot 2025-11-25 at 12.58.32 PM|2000x222](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/c/ce2caf47c1263fb4baa9e2b19ae99fdd2367ac13.png)

![Screenshot 2025-11-25 at 1.20.45 PM|2000x691](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/3/3d8e1f873fcae730aa68a63b8d61fc92805886c6.png)

Since listing on Aave, XAUt’s total supply on Ethereum has grown from 246K three months ago to [522K](https://etherscan.io/token/0x68749665ff8d2d112fa859aa293f07a622782f38) today. In market-cap terms, this reflects an increase from \$822M at the time of listing to \$2.1B today (28% of which is controlled by Tether), representing approximately 156% growth and suggesting that the asset itself is becoming more established and developed over time.

![Screenshot 2025-11-26 at 1.13.50 PM|2000x1174](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/c/cfe2719597570c34acbf436eb1370bdb891ad7ca.png)

At the time of listing, the initial $3M debt ceiling was set conservatively to observe early market behavior. Based on the evidence above, XAUt has not only shown rapid fundamental growth, but has also exhibited strong utilization on Aave. Together, these factors provide a solid rationale for increasing the debt ceiling to improve user capital efficiency. In the following sections, we further show, through analyses of liquidity, market efficiency, and supply distribution, that raising the debt ceiling does not introduce any material risk.

## Liquidity

XAUt’s on-chain liquidity is distributed across several venues, including the [XAUt/USDT Uniswap V3 pool](https://app.uniswap.org/explore/pools/ethereum/0x6546055f46e866a4B9a4A13e81273e3152BAE5dA) with \$7M in TVL, the [XAUt/WBTC Uniswap V3 pool](https://app.uniswap.org/explore/pools/ethereum/0xE8a1F39C16EEA2844E98f951D711Bb4Bb31557aD) with \$8.4M, the [XAUt/PAXG Fluid pool](https://etherscan.io/address/0x218C659b6BBb73d47C7926Fc90D9893342534B84) with \$5.6M, and the [XAUt/PAXG Curve pool](https://www.curve.finance/dex/ethereum/pools/factory-stable-ng-397/deposit) with \$3.6M. As shown below, XAUt’s on-chain liquidity has remained stable over the past month, allowing consistently around 1.5K XAUt (about \$6M) to be sold into USDT with less than 3% slippage.

![Screenshot 2025-11-25 at 2.51.39 PM|2000x1327](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/e/e960914c03833b876f479e223c221df0321920f5.png)

In addition to on-chain liquidity, XAUt is also listed on several centralized exchanges, where it has solid liquidity. For example, on Bybit XAUt records around \$51M in 24h trading volume, with ±2% order book depth of roughly \$500K.

![Screenshot 2025-11-25 at 3.22.13 PM|1999x355](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/1/17c91e74ad5b39f765e6cd655d8f5f97d882e8a2.png)

### XAUt Top 5 CEX

This ample and stable liquidity across both on-chain venues and centralized exchanges provides a strong buffer against price impact, supporting an increase in the debt ceiling without introducing material risk.

## Market Efficiency

As part of this analysis, we also examine XAUt’s market efficiency, with a focus on how reliably on-chain prices track the underlying gold market. Because the primary price discovery venues for gold operate on limited schedules and are closed during weekends and certain holidays, pricing XAUt in an on-chain environment presents structural challenges. This makes a high degree of market efficiency and robust arbitrage activity particularly important for the asset’s integration into Aave.

To evaluate this, we compare DEX prices from the Uniswap V3 XAUt/USDT pool with XAU/USD prices from a reliable reference feed and measure the resulting dislocations over time. The observed dislocation data indicate a clear improvement in market efficiency: both the magnitude and frequency of deviations have declined since the end of October, and notably, no material dislocations exceeding 100 basis points have been recorded in November.

![image|2000x995](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/c/c6d46ce6a7f9cb6751426308554adbffd7bc6d34.png)

While some dislocations remain, they are largely concentrated around periods when traditional markets are closed. On weekdays, the average absolute dislocation is ~6 basis points, compared with ~17 basis points over the weekends, indicating some friction in pricing the asset during off-exchange hours.

| Statistic | Mon-Fri | Sat-Sun |
| --------- | ------- | ------- |
| Count     | 27703   | 9360    |
| Mean      | 0.06%   | 0.17%   |
| Std       | 0.32%   | 0.30%   |

In summary, XAUt’s market has become more efficient over time, aligned with increasing adoption of the asset; specifically, we have observed tighter and less frequent dislocations. This improvement in pricing behavior reduces the risks associated with low market efficiency and supports an increase in the XAUt debt ceiling.

## Supply Distribution

In terms of supply distribution, none of the suppliers who have deposited XAUt and borrowed stablecoins show any signs of liquidation risk. All top suppliers maintain high health scores, ranging from 1.15 to 6.83, which significantly reduces the likelihood of liquidation. Given this robust collateral profile, raising the debt ceiling further remains well within acceptable risk limits.

![Screenshot 2025-11-25 at 12.55.36 PM|2000x844](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/7/79c3bee2aa2cc7c8cb89ffc7467e1f5dce335938.png)

## Recommendation

Based on the strong user demand and the continued growth of the asset, we propose increasing the XAUt debt ceiling and supply cap. From the risk perspective, liquidity conditions, supply distribution, and market efficiency all provide supportive signals: XAUt maintains ample on-chain and CEX liquidity, top suppliers exhibit healthy collateral profiles with no observable liquidation risk, and market efficiency has improved with reduced pricing dislocations. Together, these factors indicate no material risk associated with expansion, supporting a safe increase to both the debt ceiling and supply cap.

## Specification

| **Asset** | **Current Debt Ceiling** | **Recommended Debt Ceiling** | **Current Supply Cap** | **Recommended Supply Cap** |
| --------- | ------------------------ | ---------------------------- | ---------------------- | -------------------------- |
| XAUt      | $3,000,000               | $25,000,000                  | 5,000                  | 10,000                     |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_AaveV3Ethereum_XAUtCapAdjustment/AaveV3Ethereum_XAUtCapAdjustment_20251201.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_AaveV3Ethereum_XAUtCapAdjustment/AaveV3Ethereum_XAUtCapAdjustment_20251201.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-xaut-supply-cap-and-debt-ceiling-adjustment-on-aave-v3-core-instance/23466)

## Disclaimer

Chaos Labs has not been compensated by any third party for publishing this recommendation.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
