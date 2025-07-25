---
title: "Onboard USDe September expiry PT tokens on Aave V3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-september-expiry-pt-tokens-on-aave-v3-core-instance/22620"
---

## Simple Summary

This AIP proposes to onboard USDe September expiry PT tokens on Aave V3 Core Instance.

## Motivation

We propose onboarding the 25th September 2025 expiry USDe PT token. The July expiry USDe PT has $166m of collateral on Aave, the addition of the September expiry of the same will maintain this TVL and associated revenue by making it easy for users to migrate to the updated expiry and keep Aave as the leading venue for PT collateral. We expect the majority, if not all of the July expiry USDe PT deposits to migrate to the September expiry once onboarded.

## Specification

The table below illustrates the configured risk parameters for **PT_USDe_25SEP2025**

| Parameter                      |      Value |
| ------------------------------ | ---------: |
| Isolation Mode                 |      false |
| Borrowable                     |   DISABLED |
| Collateral Enabled             |       true |
| Supply Cap (PT_USDe_25SEP2025) | 50,000,000 |
| Borrow Cap (PT_USDe_25SEP2025) |          1 |
| Debt Ceiling                   |      USD 0 |
| LTV                            |     0.05 % |
| LT                             |      0.1 % |
| Liquidation Bonus              |      7.5 % |
| Liquidation Protocol Fee       |       10 % |
| Reserve Factor                 |       25 % |
| Base Variable Borrow Rate      |        0 % |
| Variable Slope 1               |       10 % |
| Variable Slope 2               |      300 % |
| Uoptimal                       |       45 % |
| Flashloanable                  |    ENABLED |
| Siloed Borrowing               |   DISABLED |
| Borrowable in Isolation        |   DISABLED |

**Pricefeed details**

| Parameter              |                                                                                                                        Value |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------: |
| Oracle                 | [PT Capped USDe USDT/USD linear discount 25SEP2025](https://etherscan.io/address/0x8B17C02d22EE7D6B8D6829ceB710A458de41E84a) |
| Underlying Oracle      |                                   [Capped USDT/USD](https://etherscan.io/address/0x260326c220E469358846b187eE53328303Efe19C) |
| Underlying Oracle      |                                [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Oracle Latest Answer   |                                                                                                   (2025-07-22) USD .98343785 |
| discountRatePerYear    |                                                                                                                        9.65% |
| maxDiscountRatePerYear |                                                                                                                       29.10% |

**PT-USDE Stablecoins E-mode**

| **Asset**         | **PT-USDe-25SEP2025** | **PT-eUSDE-14AUG2025** | **PT-USDe-31JUL2025** | **USDC** | **USDT** | **USDS** | **USDe** |
| ----------------- | --------------------- | ---------------------- | --------------------- | -------- | -------- | -------- | -------- |
| Collateral        | Yes                   | Yes                    | Yes                   | No       | No       | No       | Yes      |
| Borrowable        | No                    | No                     | No                    | Yes      | Yes      | Yes      | Yes      |
| LTV               | 90.3%                 | -                      | -                     | -        | -        | -        | -        |
| LT                | 92.3%                 | -                      | -                     | -        | -        | -        | -        |
| Liquidation Bonus | 3.5%                  | -                      | -                     | -        | -        | -        | -        |

**PT-USDE USDe E-mode**

| **Asset**         | **PT-USDe-25SEP2025** | **PT-eUSDE-14AUG2025** | **PT-USDe-31JUL2025** | **USDe** |
| ----------------- | --------------------- | ---------------------- | --------------------- | -------- |
| Collateral        | Yes                   | Yes                    | Yes                   | Yes      |
| Borrowable        | No                    | No                     | No                    | Yes      |
| LTV               | 91.2%                 | -                      | -                     | -        |
| LT                | 93.2%                 | -                      | -                     | -        |
| Liquidation Bonus | 2.5%                  | -                      | -                     | -        |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_25SEP2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8f92ad306700493d416a272997ceb6142c1eb984/src/20250722_AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/8f92ad306700493d416a272997ceb6142c1eb984/src/20250722_AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250722.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-september-expiry-pt-tokens-on-aave-v3-core-instance/22620)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
