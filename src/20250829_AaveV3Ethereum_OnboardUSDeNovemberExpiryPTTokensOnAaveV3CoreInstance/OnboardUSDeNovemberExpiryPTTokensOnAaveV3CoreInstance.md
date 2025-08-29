---
title: "Onboard USDe November expiry PT tokens on Aave V3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-november-expiry-pt-tokens-on-aave-v3-core-instance/23013"
---

## Simple Summary

This AIP proposes to onboard USDe November expiry PT tokens on Aave V3 Core Instance.

## Motivation

We propose onboarding the 27th November 2025 expiry USDe PT token after successful July and September onboardings. The addition of the November expiry of the same will maintain this TVL and associated revenue by making it easy for users to migrate to the updated expiry and keep Aave as the leading venue for PT collateral. We expect the majority, if not all of the September expiry USDe PT deposits to migrate to the November expiry once onboarded.

## Specification

The table below illustrates the configured risk parameters for **PT_USDe_27NOV2025**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_USDe_27NOV2025) |                                 50,000,000 |
| Borrow Cap (PT_USDe_27NOV2025) |                                          1 |
| Debt Ceiling                   |                                      USD 0 |
| LTV                            |                                     0.05 % |
| LT                             |                                      0.1 % |
| Liquidation Bonus              |                                      7.5 % |
| Liquidation Protocol Fee       |                                       10 % |
| Reserve Factor                 |                                       45 % |
| Base Variable Borrow Rate      |                                        0 % |
| Variable Slope 1               |                                       10 % |
| Variable Slope 2               |                                      300 % |
| Uoptimal                       |                                       45 % |
| Flashloanable                  |                                    ENABLED |
| Siloed Borrowing               |                                   DISABLED |
| Borrowable in Isolation        |                                   DISABLED |

**Pricefeed details**

| Parameter              |                                                                                                                         Value |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------: |
| Oracle                 | [PT Capped USDe USDT/USD linear discount 27NOV2025](https://etherscan.io/address/TODO) |
| Underlying Oracle      |                                   [Capped USDT/USD](https://etherscan.io/address/0x260326c220E469358846b187eE53328303Efe19C) |
| Underlying Oracle      |                                [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Oracle Latest Answer   |                                                                                                   (2025-08-25) USD .TODO     |
| discountRatePerYear    |                                                                                                                        9.51% |
| maxDiscountRatePerYear |                                                                                                                       28.90% |

**PT-USDE Stablecoins E-mode**

| **Asset**         | **PT-USDe-27NOV2025** | **PT-USDe-25SEP2025** | **USDC** | **USDT** | **USDS** | **USDe** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | -------- | -------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | No       | No       | No       | No       | No        |
| Borrowable        | No                     | No                     | Yes      | Yes      | Yes      | Yes      | Yes       |
| LTV               | 87.8%                  | -                      | -        | -        | -        | -        | -         |
| LT                | 89.8%                  | -                      | -        | -        | -        | -        | -         |
| Liquidation Bonus | 4.2%                   | -                      | -        | -        | -        | -        | -         |

**PT-USDE USDe E-mode**

| **Asset**         | **PT-USDe-27NOV2025** | **PT-USDe-25SEP2025** | **USDe** |
| ----------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | Yes      |
| LTV               | 88.6%                  | -                      | -        |
| LT                | 90.6%                  | -                      | -        |
| Liquidation Bonus | 3.2%                   | -                      | -        |

The LTV, LT and LB of the previous emode will be managed by the Edge Risk Oracle.

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_27NOV2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250829_AaveV3Ethereum_OnboardUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250829.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250829_AaveV3Ethereum_OnboardUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250829.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-november-expiry-pt-tokens-on-aave-v3-core-instance/23013)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
