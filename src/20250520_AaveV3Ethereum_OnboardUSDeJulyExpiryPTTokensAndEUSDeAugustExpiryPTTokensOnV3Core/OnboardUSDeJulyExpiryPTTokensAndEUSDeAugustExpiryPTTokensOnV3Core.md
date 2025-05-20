---
title: "Onboard USDe July expiry PT tokens and eUSDe August expiry PT tokens on V3 Core"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-usde-july-expiry-pt-tokens-on-aave-v3-core-instance/22041"
---

## Simple Summary

This proposal aims to onboard the USDe July expiry PT tokens and eUSDe August expiry PT tokens on the Aave V3 Core Instance.

## Motivation

Last month listing of various PT tokens where met with massive support from the community and growth for the protocol. To capitalize on this interest we suggest onboard two additional PT tokens to the Core instances. The two PT tokens selected are the smae as previously onboarded with a later expery date.

## Specification

### PT_USDe_31JUL2025

The table below illustrates the configured risk parameters for **PT_USDe_31JUL2025**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_USDe_31JUL2025) |                                 40,000,000 |
| Borrow Cap (PT_USDe_31JUL2025) |                                          1 |
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
| Oracle                         | 0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_31JUL2025 and the corresponding aToken.

**PT-USDe Stablecoins E-mode**

| **Asset**         | **PT-USDe**            | **USDC** | **USDT** | **USDS** |
| ----------------- | ---------------------- | -------- | -------- | -------- |
| Collateral        | Yes                    | No       | No       | No       |
| Borrowable        | No                     | Yes      | Yes      | Yes      |
| LTV               | Subject to Risk Oracle | -        | -        | -        |
| LT                | Subject to Risk Oracle | -        | -        | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        | -        | -        |

**PT-USDe USDe E-mode**

| **Asset**         | **PT-USDe**            | **USDe** |
| ----------------- | ---------------------- | -------- |
| Collateral        | Yes                    | No       |
| Borrowable        | No                     | Yes      |
| LTV               | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        |

**Initial E-mode Risk Oracle**

| Parameter | Value      | Value |
| --------- | ---------- | ----- |
| E-Mode    | Stablecoin | USDe  |
| LTV       | 88.1%      | 90.1% |
| LT        | 91.1%      | 92.1% |
| LB        | 3.9%       | 2.8%  |

### PT_eUSDe_14AUG2025

The table below illustrates the configured risk parameters for **PT_eUSDe_14AUG2025**

| Parameter                       |                                      Value |
| ------------------------------- | -----------------------------------------: |
| Isolation Mode                  |                                      false |
| Borrowable                      |                                   DISABLED |
| Collateral Enabled              |                                       true |
| Supply Cap (PT_eUSDe_14AUG2025) |                                100,000,000 |
| Borrow Cap (PT_eUSDe_14AUG2025) |                                          1 |
| Debt Ceiling                    |                                      USD 0 |
| LTV                             |                                     0.05 % |
| LT                              |                                      0.1 % |
| Liquidation Bonus               |                                      7.5 % |
| Liquidation Protocol Fee        |                                       10 % |
| Reserve Factor                  |                                       45 % |
| Base Variable Borrow Rate       |                                        0 % |
| Variable Slope 1                |                                       10 % |
| Variable Slope 2                |                                      300 % |
| Uoptimal                        |                                       45 % |
| Flashloanable                   |                                    ENABLED |
| Siloed Borrowing                |                                   DISABLED |
| Borrowable in Isolation         |                                   DISABLED |
| Oracle                          | 0x5292AB3292D076271f853Ed8e05e61cc02F0A2C6 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_eUSDe_14AUG2025 and the corresponding aToken.

**PT-eUSDe Stablecoins E-mode**

| **Asset**         | **PT-eUSDe**           | **USDC** | **USDT** | **USDS** |
| ----------------- | ---------------------- | -------- | -------- | -------- |
| Collateral        | Yes                    | No       | No       | No       |
| Borrowable        | No                     | Yes      | Yes      | Yes      |
| LTV               | Subject to Risk Oracle | -        | -        | -        |
| LT                | Subject to Risk Oracle | -        | -        | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        | -        | -        |

**PT-eUSDe USDe E-mode**

| **Asset**         | **PT-eUSDe**           | **USDe** |
| ----------------- | ---------------------- | -------- |
| Collateral        | Yes                    | No       |
| Borrowable        | No                     | Yes      |
| LTV               | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        |

**Initial E-mode Risk Oracle**

| Parameter | Value      | Value |
| --------- | ---------- | ----- |
| E-Mode    | Stablecoin | USDe  |
| LTV       | 87.1%      | 89%   |
| LT        | 90.1%      | 91%   |
| LB        | 4.1%       | 3.1%  |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250520_AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core/AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250520_AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core/AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520.t.sol)
- Snapshot: Direct-to-AIP
- Discussion: [PT-USDe-31JUL2025](https://governance.aave.com/t/arfc-onboard-usde-july-expiry-pt-tokens-on-aave-v3-core-instance/22041), [PT-eUSDe-14AUG2025](https://governance.aave.com/t/arfc-onboard-eusde-august-expiry-pt-tokens-on-aave-v3-core-instance/22076)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
