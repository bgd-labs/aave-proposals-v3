---
title: "Onboard ezETH to Lido Instance"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x7ef22a28cb6729ea4a978b02332ff1af8ed924a726915f9a6debf835d8bf8048"
---

## Simple Summary

The proposal aims to onboard Renzo Protocol's [ezETH](https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110) on Aave v3 Lido Instance.

## Motivation

Liquid Restaking tokens (LRTs) have proven to be popular collateral assets on Aave. ezETH is an LRT reward-bearing token, exchange-rate based, where users can deposit native ETH and LSTs (currently stETH) in exchange for ezETH.

Given LRTs high correlation to ETH, they are commonly used as collateral to borrow ETH and engage in yield leveraged staking, with several communities having built products that automate such strategies on top of Aave. The inclusion of ezETH in E-Mode enables these strategies to maximize the yield potential of the recursive strategy. The onboarding of ezETH will consequently create increased ezETH demand and increased revenues for both Aave and Renzo Protocol, whilst also bolstering the liquidity and peg stability of ezETH.

The risk parameters have been provided by Chaos Labs, and positive technical evaluation of ezETH is done by BGD Labs, all of which including LlamaRisk's qualitative assessment, can be found on the [forum](https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504).

## Specification

The table below illustrates the configured risk parameters for **[ezETH](https://etherscan.io/address/0xbf5495Efe5DB9ce00f80364C8B423567e58d2110)**

| Parameter                 |                                                                                                                 Value |
| ------------------------- | --------------------------------------------------------------------------------------------------------------------: |
| Collateral Enabled        |                                                                                                                  true |
| Borrowable                |                                                                                                                 false |
| Supply Cap (ezETH)        |                                                                                                                15,000 |
| Borrow Cap (ezETH)        |                                                                                                                   100 |
| Debt Ceiling              |                                                                                                                 USD 0 |
| LTV                       |                                                                                                                0.05 % |
| LT                        |                                                                                                                 0.1 % |
| Liquidation Bonus         |                                                                                                                 7.5 % |
| Liquidation Protocol Fee  |                                                                                                                  10 % |
| Reserve Factor            |                                                                                                                  15 % |
| Base Variable Borrow Rate |                                                                                                                   0 % |
| Variable Slope 1          |                                                                                                                   7 % |
| Variable Slope 2          |                                                                                                                 300 % |
| Uoptimal                  |                                                                                                                  45 % |
| Flashloanable             |                                                                                                                 false |
| Siloed Borrowing          |                                                                                                                 false |
| Isolation Mode            |                                                                                                                 false |
| Borrowable in Isolation   |                                                                                                                 false |
| Oracle                    | [0xcbc95f18d2d9019aae596c82094e724fa2213224](https://etherscan.io/address/0xcbc95f18d2d9019aae596c82094e724fa2213224) |
| E-Modes                   |                                                                                 LRT Stablecoins main, LRT wstETH main |

_Please Note: Low LTV, LT values have been configured to only allow for collateral use of ezETH on E-Modes._

With liquid eModes live on all instances, we now configure two new E-Mode categories: LRT Stablecoins main, LRT wstETH main and add the respective assets to these categories.

#### E-mode Category: LRT Stablecoins main

| Parameter             | Value | Value |
| --------------------- | ----: | ----: |
| Category Id           |     2 |     2 |
| Asset                 | ezETH |  USDS |
| Collateral            |   Yes |    No |
| Borrowable            |    No |   Yes |
| LTV                   |   75% |   75% |
| Liquidation Threshold |   78% |   78% |
| Liquidation Penalty   |  7.5% |  7.5% |

#### E-mode Category: LRT wstETH main

| Parameter             | Value |  Value |
| --------------------- | ----: | -----: |
| Category Id           |     3 |      3 |
| Asset                 | ezETH | wstETH |
| Collateral            |   Yes |     No |
| Borrowable            |    No |    Yes |
| LTV                   |   93% |    93% |
| Liquidation Threshold |   95% |    95% |
| Liquidation Penalty   |    1% |     1% |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for ezETH and the corresponding aToken.

## References

- Implementation: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241021_AaveV3EthereumLido_OnboardEzETHToLidoInstance/AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.sol)
- Tests: [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241021_AaveV3EthereumLido_OnboardEzETHToLidoInstance/AaveV3EthereumLido_OnboardEzETHToLidoInstance_20241021.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7ef22a28cb6729ea4a978b02332ff1af8ed924a726915f9a6debf835d8bf8048)
- [Discussion](https://governance.aave.com/t/arfc-onboard-ezeth-to-aave-v3-lido-instance/18504/11)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
