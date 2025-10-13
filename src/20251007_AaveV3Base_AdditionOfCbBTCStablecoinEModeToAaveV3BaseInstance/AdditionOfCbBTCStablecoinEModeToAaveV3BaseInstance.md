---
title: "Addition of cbBTC/Stablecoin E-Mode to Aave V3 Base Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-addition-of-cbbtc-stablecoin-e-mode-to-aave-v3-base-instance/23174"
---

## Simple Summary

Chaos Labs proposes introducing a tailored cbBTC Stablecoin E-Mode to the Base instance of Aave v3. Given the competitive cbBTC-collateral market and relatively low asset risk, combined with deep on-chain liquidity, the introduction of the E-Mode will increase the asset’s capital efficiency, making USDC and GHO borrowing more competitive.

## Motivation

At the time of writing, aggregate USDC borrowing demand from cbBTC collateral on Aave is approximately $100 million, while competitors have captured a significant share of the market. The gap is driven both by differences in capital efficiency and by ongoing incentive programs in competing markets. Aave v3 currently supports a 78% liquidation threshold for cbBTC, whereas competitors extend this to as high as 86%, enabling borrowers to access substantially more debt. As a result, Aave has an opportunity to expand its share of cbBTC growth on Base, where supply is expanding rapidly.

Introducing a cbBTC Stablecoin E-Mode addresses this imbalance directly. By offering higher efficiency parameters in a controlled setting, Aave can compete more effectively for USDC borrowing demand, deepen utilization of cbBTC collateral, and translate the asset’s adoption into incremental protocol revenue.

### Isolating Risk

Historically, E-Modes have been introduced for correlated assets like LSTs/LRTs in pairs with each other or WETH, or the recently successful PT Stablecoin and PT USDe E-Modes, which have facilitated significant revenue for the protocol by elevating stablecoin borrowing demand. Given the current high maturity of some of the dominant assets like cbBTC, with its inclusion in ETFs, substantial and growing institutional adoption, and decreased volatility profile, an adjustment to the risk parameters can be prompted to better reflect decreased asset-specific risk.

Traditionally, the base loan-to-value and liquidation threshold would have to be configured; however, increasing these parameters would result in more volatility exposure for cbBTC-backed positions, as borrowers will be able to utilize higher risk parameters to potentially facilitate debt in volatile assets. Hence, in order to constrain potential pair volatility along with reducing liquidation risk, we propose to introduce a cbBTC Stablecoin E-Mode on the Base instance of Aave v3, which will enhance the capital efficiency of cbBTC as collateral in the market that shows the highest demand, while minimizing the corresponding risks as the E-Mode will isolate them to USDC and GHO loans, which will effectively result in reduced pair volatility.

### cbBTC Performance

cbBTC is Coinbase’s wrapped Bitcoin product, backed 1:1 by BTC custodied at Coinbase. This structure reduces idiosyncratic risks relative to synthetic wrappers and provides institutional-grade custody standards. On-chain, cbBTC has grown to become the dominant form of BTC on Base and is actively growing on Ethereum. To assess cbBTC’s suitability as collateral for a dedicated E-Mode, we analyze its market behavior across price alignment, volatility, and liquidity.

Dislocation analysis of cbBTC’s DEX pool price and the BTC/USD oracle shows that pricing discrepancies remain consistently centered near zero, with more than 95% of observations within ±1%. This indicates tight alignment between on-chain pricing and the oracle feed, reducing the risk of oracle mispricing and minimizing the chance of forced liquidations triggered by technical deviations rather than price discovery.

To further examine whether cbBTC pricing is overly dependent on Coinbase order books, one-minute cbBTC/USDC DEX prices were tested against both Coinbase BTC/USD and Binance BTC/USDT close prices. While occasional deviations occur, they are infrequent and rarely exceed ±1 percent, even at high-frequency intervals. This shows that cbBTC markets track not only Coinbase but also global BTC pricing with high efficiency. In practice, cbBTC is redeemable for BTC through Coinbase. During market stress periods, arbitrageurs purchase discounted cbBTC on DEXs, redeem it for BTC, and sell into deeper centralized markets; if cbBTC trades at a premium, they deposit BTC to mint cbBTC and sell it on-chain. These flows ensure pricing dislocations close quickly, limiting inefficiencies from reliance on Coinbase and reinforcing that cbBTC inherits BTC dynamics while minimizing wrapper-specific risks.

Volatility analysis reinforces this: 30-Day annuallized volatility for cbBTC/USDC on Aerodrome closely follows the BTC/USD oracle, indicating no wrapper-specific noise.

The distribution of one-hour returns before and after March 2025 highlights increased stability in the latter period. While the center of the distribution becomes slightly denser, the post-March profile (red) reflects a lower absolute frequency of large price changes, suggesting increased market stability for cbBTC pools on Base and, consequently, thinner tails.

Liquidity conditions also reinforce cbBTC’s suitability as collateral. On Base, DEX liquidity has exhibited a stable growing trajectory, as, at the moment, it is sufficient to limit slippage on a 200-cbBTC sell order to ~1.5%. Given the overall market size, this depth is adequate to accommodate a significant volume of liquidations, thereby limiting the risk of delayed or failed liquidations.

As Coinbase is the primary redemption and pricing venue for cbBTC, we also assess centralized-exchange liquidity to fully evaluate potential price-impact levels. Coinbase BTC/USD orderbook shows roughly 1,100 BTC depth within 5% of the mid-price, split about 40/60 between bids and asks. This implies that it would take over $50 million in aggressive order flow to move the price by ~5%. Such depth, combined with rapid conversion between cbBTC and BTC, ensures consistent alignment of prices across CEX and DEX venues.

Taken together, these findings demonstrate that cbBTC has matured into a more stable and liquid collateral asset. The consistent alignment of oracle and on-chain pricing and deep liquidity, point to a lower asset-specific risk compared to earlier stages of adoption, when the initial parameters were set. This dynamic provides a strong basis for introducing a dedicated cbBTC Stablecoin E-Mode, facilitating higher capital efficiency and additional revenue growth.

### Aave Market Context

The cbBTC supply on the Base instance has grown substantially since July. Over 500 tokens have been added in the past two months, reaching 2,500 cbBTC, which is valued at approximately $300 million at the time of writing.

While the supply has seen a significant increase, cbBTC borrowing continuously represents a minor share of the asset’s volume, as less than 15% of the supply is utilized in borrowing.

The majority of the supply, however, is used to collateralize debt positions, as the cumulative cbBTC-backed borrowing stands at ~$130 million. USDC is the dominant debt asset, representing 84% of total debt.

Additionally, the majority of top users who have cbBTC-backed USDC loans have moderate health scores in the 1.15—1.68 range, significantly limiting the risk of large-scale liquidations.

The dynamic signals that the rapid growth of cbBTC supply on Base is creating substantial demand for USDC borrowing, with collateral use consistently translating into sizable and growing borrowing activity.

### Parameter Adjustments

Given the maturity of cbBTC and its established position in the Base ecosystem, we propose introducing a cbBTC Stablecoin E-Mode with tailored LTV, LT, and LB parameters that better reflect the asset’s current risk–return profile, without altering the asset’s base settings.

cbBTC has consistently demonstrated efficient pricing relative to BTC, with mean hourly dislocations at -0.02% and more than 95% of deviations falling within ±1%, alongside a lower relative volatility profile. This alignment, combined with rapid redemption pathways into BTC, indicates robust market efficiency. Our simulation results show that the proposed LT and LTV of 80% and 83% respectively reflect an optimal balance between protocol utility and implied Value-at-Risk. The 5% uplift is therefore well supported both by cbBTC’s observed stability and by the significant market opportunity available to Aave.

We also propose reducing the liquidation bonus to 4.0% within the cbBTC Stablecoin E-Mode. Both liquidity depth and recent liquidation outcomes support this change. On-chain, a 200-cbBTC unwind results in only ~1.5 percent slippage, while Coinbase orderbooks can absorb over $50 million of sell orders within 5% of the mid-price. These liquidity levels ensure liquidations can clear efficiently without requiring elevated incentives.

At the same time, SVR liquidations data shows that the recaptured rate historically is likely to exceed 50% for BTC-based assets on the Ethereum Core market. The recapture rate represents a substantial share of the current liquidation bonus, indicating that liquidators are already prepared to operate with thinner profit margins. As a result, the data supports a reduction of the LB within the cbBTC Stablecoin E-Mode, as liquidations can perform reliably at slightly lower incentives.

## Specification

| **Parameter**         | **Value** | **Value** | **Value** |
| --------------------- | --------- | --------- | --------- |
| Asset                 | cbBTC     | USDC      | GHO       |
| Collateral            | Yes       | No        | No        |
| Borrowable            | No        | Yes       | Yes       |
| Max LTV               | 80%       | -         | -         |
| Liquidation Threshold | 83%       | -         | -         |
| Liquidation Bonus     | 4.0%      | -         | -         |

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/4fc1c4e302e911bbadfec5f8c46910d2ef83facd/src/20251007_AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance/AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/4fc1c4e302e911bbadfec5f8c46910d2ef83facd/src/20251007_AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance/AaveV3Base_AdditionOfCbBTCStablecoinEModeToAaveV3BaseInstance_20251007.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-addition-of-cbbtc-stablecoin-e-mode-to-aave-v3-base-instance/23174)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
