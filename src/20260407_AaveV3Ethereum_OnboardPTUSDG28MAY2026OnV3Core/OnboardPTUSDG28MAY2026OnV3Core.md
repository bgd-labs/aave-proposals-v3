---
title: "Onboard PT-USDG 28MAY2026 on V3 Core"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-onboard-pt-usdg-28may2026-to-aave-v3-core-instance/24345/4"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xaa29094accbcccd70088fb77dfd2800a4488319a0942b226c5699ea35d1c9e19"
---

## Simple Summary

This AIP proposes to onboard PT-USDG-28MAY2026 to the Aave V3 Core Instance on Ethereum.

## Motivation

We propose onboarding PT-USDG-28MAY2026 to the Aave V3 Core Instance.

This PT token is attractive because the underlying asset is USDG, issued by Paxos, a highly regulated financial institution. This gives the market a dollar-denominated base asset with a straightforward reference point. A listing would allow users holding this Pendle maturity to access borrowing liquidity on Aave against that position, extending the utility of an already live market on Ethereum.

The relevant Pendle market is already live, which allows the asset to be evaluated against observable market activity rather than hypothetical demand. Where demand scales, onboarding can allow Aave to capture additional collateral usage and related borrowing activity around this maturity.

The underlying yield of PT-USDG has three components: a NIM rate pass-through, Paxos-denominated incentives, and PENDLE incentives. As a GDN member, Paxos passes yield to Pendle, which distributes it to YT holders via the Pendle Dashboard. PT holders capture this yield implicitly through the fixed discount at which PT is acquired, redeemable at par upon maturity.

## Specification

**PT-USDG-28MAY2026**: https://etherscan.io/address/0x9db38D74a0D29380899aD354121DfB521aDb0548

The table below illustrates the configured risk parameters for **PT_USDG_28MAY2026**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_USDG_28MAY2026) |                                 80,000,000 |
| Borrow Cap (PT_USDG_28MAY2026) |                                          1 |
| Debt Ceiling                   |                                      USD 0 |
| LTV                            |                                        0 % |
| LT                             |                                        0 % |
| Liquidation Bonus              |                                        0 % |
| Liquidation Protocol Fee       |                                       10 % |
| Reserve Factor                 |                                       45 % |
| Base Variable Borrow Rate      |                                        0 % |
| Variable Slope 1               |                                       10 % |
| Variable Slope 2               |                                      300 % |
| Uoptimal                       |                                       45 % |
| Flashloanable                  |                                   DISABLED |
| Siloed Borrowing               |                                   DISABLED |
| Borrowable in Isolation        |                                   DISABLED |
| Oracle                         | 0x90498d4334259FA769830ccA9114D8bcF3745F6c |

**PT-USDG Stablecoins E-mode**

| Asset             | PT-USDG-28MAY2026 | USDT | USDe | USDC | USDG |
| ----------------- | ----------------- | ---- | ---- | ---- | ---- |
| Collateral        | Yes               | No   | No   | No   | No   |
| Borrowable        | No                | Yes  | Yes  | Yes  | Yes  |
| LTV               | 93.5%             | -    | -    | -    | -    |
| LT                | 95.5%             | -    | -    | -    | -    |
| Liquidation Bonus | 2.0%              | -    | -    | -    | -    |

**Linear Discount Rate Oracle**

| Parameter                  | Value                                      |
| -------------------------- | ------------------------------------------ |
| initialDiscountRatePerYear | 5.12%                                      |
| maxDiscountRatePerYear     | 18.82%                                     |
| Oracle                     | 0x90498d4334259FA769830ccA9114D8bcF3745F6c |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDG_28MAY2026 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260407_AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core/AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260407_AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core/AaveV3Ethereum_OnboardPTUSDG28MAY2026OnV3Core_20260407.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xaa29094accbcccd70088fb77dfd2800a4488319a0942b226c5699ea35d1c9e19)
- [Discussion](https://governance.aave.com/t/arfc-onboard-pt-usdg-28may2026-to-aave-v3-core-instance/24345/4)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
