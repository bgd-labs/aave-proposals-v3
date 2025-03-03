---
title: "sUSDe and USDe Price Feed Update"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-susde-and-usde-price-feed-update/20495"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xd09ac8571db4d8e70b57162d526e2e088295f6372d37eb0f2b68c5dfbf16d316"
---

## Simple Summary

This proposal suggests hardcoding the USDe price to match the USDT price in Aave’s pricing feeds. By linking USDe’s value directly to USDT, we align the sUSDe oracle with USDT pricing, ensuring seamless integration and avoiding disruptions caused by transient price fluctuations in USDe.

_This proposal has been authored by @ChaosLabs in collaboration with @LlamaRisk, whho provided their support and analysis._

## Motivation

Aave’s current pricing oracle for sUSDe integrates Chainlink’s USDe/USD market price feed. This setup exposes the sUSDe-backed positions to USDe’s secondary market price deviations. While the setup adopted by Ethena for USDe makes this volatility unlikely, if it were to happen, it would present liquidation risks for Aave users and the protocol itself.

Modeling indicates that a USDe price deviation of 5% could render approximately $300M of USDe-backed positions eligible for liquidation. However, with market liquidity constrained to support liquidations of only $6M within a 4% price impact (equal to the liquidation bonus), the majority of these liquidations would likely not be executed as unprofitable for liquidators, potentially causing bad debt to Aave.

Historical data suggests that USD redemptions act as a stabilizing force during such depegs, quickly restoring USDe’s peg and reducing liquidatable positions. Despite this stabilizing mechanism, the reliance on USDe’s secondary market price feed introduces unnecessary risk to Aave’s users.

### **Mint and Redeem Functionality**

The minting and redeeming of USDe are facilitated through **EthenaMinting** contracts, which ensure atomic transactions exclusively for whitelisted addresses. These users, businesses or individuals who have passed KYC, interact with Ethena’s API to request a price quote and signature, verifying the validity of each order. The atomic process ensures smooth execution but grants Ethena the ability to deny requests that could harm the asset’s backing or if significant price fluctuations occur before execution. The contracts support a limited selection of assets, including stETH, ETH, WETH, mETH, DAI, USDT, USDC, and wBETH, with USDT dominating minting activity, accounting for over 84% of transactions since July.

The process handles daily outflows of up to $100 million without issues. With its withdraw patterns aligning with downward deviations in USDe’s price. Ethena maintains a withdrawal buffer of $30M USDT in the Mint/Redeem contract, replenished promptly after significant outflows. Over the last 100 instances of the buffer dropping below $28M, the median replenishment time was 36 seconds or 3 blocks. In addition to the quick replenishment, there is currently a 2M$ per block redeem limit. The combination of the two parameters ensures that that the Ethena team has sufficent time to perform market operations and close the short hedges.

During a notable stress test on September 2, 2024, Abraxas Capital Management redeemed $100M USDe in 20 minutes through consecutive maximum-value transactions. This drained the reserves temporarily, but the buffer was restored to $30M within 25 minutes, demonstrating the system’s robustness.

Following the event, we have found Ethena to be proactive to funding rate changes by increasing the share of USDe backing held as USDT available for withdraws. In the following chart, its possible to see the increase in Cash at hand following the drop in funding rate on Binance for ETH and coinciding with an increase in USDe redeems

Fees for minting and redeeming average 0.1% for amounts exceeding $10,000, incentivizing arbitrage when USDe prices deviate below $0.999 or above $1.001.
For assets below a certain threshold, the fee seems to be fixed to a nominal amount, making small redeems inefficient and costly.

The outliers visible after the 100,000$ mark are derived by changes in quote prices rather than fees.

The redeemer whitelist includes 180 addresses, with over 50% of activity attributed to three addresses. Notably, the biggest address frequently conducts arbitrage operations, executing multiple transactions per minute with an average size of $500K USDT. Recently, another address emerged as a key player, averaging $109,640 USDT per redemption via CowSwap whenever USDe dips below $0.999, aligning precisely with arbitrage expectations given fee structures.

### **Funding Rate Dynamics**

Historically, ETH and BTC’s funding rates have displayed a strong positive bias, with only 10.34% of days yielding negative funding when incorporating stETH yields.

Ethena’s Insurance Fund further enhances the safety of this system, stepping in to cover instances of negative funding. While the Insurance Fund does not currently grow from a share of the accrued yield as described in the docs, the current size of $60M is sufficent to witstand over 70 days of the bottom 10 percentile funding rate with the current TVL.

While the negative funding rate poses a risk to USDe backing, it also acts as an incentive for the protocol to remain healthy and automatically adjust its size following the market’s demand for leverage. This is because in scenarios of negative funding, USDe redemptions are triggered, causing a contraction of short positions that pushes funding rates back up. This feedback loop minimizes prolonged negative funding periods and protects the protocol’s reserves.

### **Solution**

To mitigate these risks, Chaos Labs and Llamarisk propose an improved pricing mechanism. The new mechanism would replace the USDe/USD secondary market price feed with a USDT/USD feed. By decoupling sUSDe pricing from USDe’s short-term market fluctuations, this proposal aims to reduce liquidation risks for all sUSDe-backed positions significantly.

To mitigate the risk associated with a USDe depeg event of unnecessary liquidations, we propose hardcoding USDe’s price to USDT. While utilizing a Proof of Reserve oracle would have been preferable to hardcoding, this solution still presents significant advantages without increasing the protocol’s risk.

Thanks to the presence of Ethena’s $60M insurance fund and the need for a prolonged negative funding event to affect USDe backing, Aave is presented with a significant time buffer to mitigate risk following a negative funding event properly.

In the case of persistent negative funding, Aave retains the option to adjust risk parameters, such as reducing LT. This proactive measure will force liquidations, which in turn will weaken the sUSDe peg, which is likely to cause redemptions. As previously explained, significant USDe redemptions increase funding rates and hence stabilize the USDe peg and demand without compromising the protocol’s safety.

The following chart demonstrates the correlation between the sUSDe in the unstaking queue and the sUSDe price deviation. The unstaking process length is 7 days, during which the asset does not earn any yield.

## Specification

**USDe**

To implement this change, the USDe pricing feed should be replaced with USDT’s price feed. The sUSDe oracle should similarly implement it in place of its BASE_TO_USD feed, ensuring consistent pricing across the protocol.

**sUSDe**

To implement the proposed changes, it is required to modify the sUSDe oracle to incorporate the new pricing logic.

The sUSDe price will be determined using the following components:

- **sUSDe/USDe exchange rate**, as currently and enhanced by the CAPO adapter.
- **Chainlink’s USDT/USD price feed** to determine the final USD value of sUSDe.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a718d64453d1fb68993d150761eab83c48860e02/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/a718d64453d1fb68993d150761eab83c48860e02/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3EthereumLido_SUSDeAndUSDePriceFeedUpdate_20250213.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/a718d64453d1fb68993d150761eab83c48860e02/zksync/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/a718d64453d1fb68993d150761eab83c48860e02/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3Ethereum_SUSDeAndUSDePriceFeedUpdate_20250213.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/a718d64453d1fb68993d150761eab83c48860e02/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3EthereumLido_SUSDeAndUSDePriceFeedUpdate_20250213.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/a718d64453d1fb68993d150761eab83c48860e02/zksync/src/20250213_Multi_SUSDeAndUSDePriceFeedUpdate/AaveV3ZkSync_SUSDeAndUSDePriceFeedUpdate_20250213.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xd09ac8571db4d8e70b57162d526e2e088295f6372d37eb0f2b68c5dfbf16d316)
- [Discussion](https://governance.aave.com/t/arfc-susde-and-usde-price-feed-update/20495)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
