---
title: "sUSDe Base Onboarding"
author: "sreno"
discussions: "https://governance.aave.com/t/arfc-add-susde-to-aave-v3-base-instance/20842"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x75caa290c8eefe042d8d3959da08c0f6ebbd6a98e45bbbb9a991531f26bd9899"
---

## Simple Summary

This publication presents the community an opportunity to expand sUSDE integration on the AAVE platform by adding sUSDE collateral option to Base.

sUSDE is an innovative stable-coin derivative producing real yield through perpetual arbitrage and ETH backing yield.

## Motivation

Expanding sUSDE integration into Base would allow any size L2 participant to access sUSDE yields while avoiding the expensive gas fees incurred from ETH main-net.
-Adding sUSDE to Base V3 market would allow Base sUSDE to be used productively through lending. This would facilitate the same ‘Borrow USDC/USDT then stake/swap for sUSDE’ arbitrage which happens within the ETH V3 main market, but on Base.
Ethena lacks strong foundations on Base L2 for their native yieldbearing stable-coin, sUSDE. The addition of sUSDE to Base V3 AAVE market would facilitate this expansion to the untapped L2 market for Ethena.

Base has seen expansion in its TVL now surpassing Arbitrum by ~15%. Base chain is a small but significant part of total Defi TVL (all chains) of 3%.
Source: https://defillama.com/chains

## Specification

The table below illustrates the configured risk parameters for **sUSDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (sUSDe)        |                                  1,200,000 |
| Borrow Cap (sUSDe)        |                                          0 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       70 % |
| LT                        |                                       73 % |
| Liquidation Bonus         |                                      8.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        7 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                        1 % |
| Flashloanable             |                                   DISABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x211Cc4DD073734dA055fbF44a2b4667d5E5fE5d2 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://basescan.org/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for sUSDe and the corresponding aToken.

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250226_AaveV3Base_SUSDeBaseOnboarding/AaveV3Base_SUSDeBaseOnboarding_20250226.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250226_AaveV3Base_SUSDeBaseOnboarding/AaveV3Base_SUSDeBaseOnboarding_20250226.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x75caa290c8eefe042d8d3959da08c0f6ebbd6a98e45bbbb9a991531f26bd9899)
- [Discussion](https://governance.aave.com/t/arfc-add-susde-to-aave-v3-base-instance/20842)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
