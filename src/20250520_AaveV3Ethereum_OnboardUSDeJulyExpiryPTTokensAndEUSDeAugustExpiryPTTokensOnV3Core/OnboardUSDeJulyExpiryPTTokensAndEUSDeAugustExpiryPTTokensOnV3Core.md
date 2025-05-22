---
title: "Onboard eUSDe and eUSDe based PT token to Aave V3 Core"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-usde-july-expiry-pt-tokens-on-aave-v3-core-instance/22041"
---

## Simple Summary

This proposal aims to onboard the eUSDe token as well as the USDe July expiry PT tokens and eUSDe August expiry PT tokens on the Aave V3 Core Instance.

## Motivation

Last month listing of various PT tokens where met with massive support from the community and growth for the protocol. To capitalize on this interest we suggest onboard two additional PT tokens to the Core instances. The two PT tokens selected are the same as previously onboarded with a later expiry date.

## Specification

### eUSDe

The table below illustrates the configured risk parameters for **eUSDe**

| Parameter                 |       Value |
| ------------------------- | ----------: |
| Isolation Mode            |       false |
| Borrowable                |    DISABLED |
| Collateral Enabled        |        true |
| Supply Cap (eUSDe)        | 550,000,000 |
| Borrow Cap (eUSDe)        |           1 |
| Debt Ceiling              |       USD 0 |
| LTV                       |      0.05 % |
| LT                        |       0.1 % |
| Liquidation Bonus         |       7.5 % |
| Liquidation Protocol Fee  |        10 % |
| Reserve Factor            |        45 % |
| Base Variable Borrow Rate |         0 % |
| Variable Slope 1          |        10 % |
| Variable Slope 2          |       300 % |
| Uoptimal                  |        45 % |
| Flashloanable             |     ENABLED |
| Siloed Borrowing          |    DISABLED |
| Borrowable in Isolation   |    DISABLED |

**Pricefeed details**

| Parameter            |                                                                                                 Value |
| -------------------- | ----------------------------------------------------------------------------------------------------: |
| Oracle               | [Capped eUSDe / USDe / USD ](https://etherscan.io/address/0xc7Ad695ac0ae38Ae308640897E51468977A862a2) |
| BASE/USD Oracle      |         [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Ratio Provider       |                      [eUSDe](https://etherscan.io/address/0x90D2af7d622ca3141efA4d8f1F24d86E5974Cc8F) |
| Oracle Latest Answer |                                                                               (2025-05-20) USD 1.0002 |
| min snapshot         |                                                                                                 1 day |
| max yearly growth    |                                                                                                    0% |

**eUSDe/Stablecoin E-Mode(id:15)**

| Asset             | eUSDe | USDC | USDT | USDS |
| ----------------- | ----- | ---- | ---- | ---- |
| Collateral        | Yes   | No   | No   | No   |
| Borrowable        | No    | Yes  | Yes  | Yes  |
| LTV               | 90%   | -    | -    | -    |
| LT                | 93%   | -    | -    | -    |
| Liquidation Bonus | 2%    | -    | -    | -    |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for eUSDe and the corresponding aToken.

### PT_USDe_31JUL2025

The table below illustrates the configured risk parameters for **PT_USDe_31JUL2025**

| Parameter                      |      Value |
| ------------------------------ | ---------: |
| Isolation Mode                 |      false |
| Borrowable                     |   DISABLED |
| Collateral Enabled             |       true |
| Supply Cap (PT_USDe_31JUL2025) | 40,000,000 |
| Borrow Cap (PT_USDe_31JUL2025) |          1 |
| Debt Ceiling                   |      USD 0 |
| LTV                            |     0.05 % |
| LT                             |      0.1 % |
| Liquidation Bonus              |      7.5 % |
| Liquidation Protocol Fee       |       10 % |
| Reserve Factor                 |       45 % |
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
| Oracle                 | [PT Capped USDe USDT/USD linear discount 31JUL2025](https://etherscan.io/address/0x6b99e86b48fee533b7bee602e7959f024051eca0) |
| Underlying Oracle      |                                   [Capped USDT/USD](https://etherscan.io/address/0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8) |
| Underlying Oracle      |                                [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Oracle Latest Answer   |                                                                                                   (2025-05-21) USD .98398009 |
| discountRatePerYear    |                                                                                                                        8.47% |
| maxDiscountRatePerYear |                                                                                                                       29.21% |

**PT-USDe Stablecoins E-mode(id:10)**

| **Asset**         | **PT-USDe**            | **USDe** | **USDC** | **USDT** | **USDS** |
| ----------------- | ---------------------- | -------- | -------- | -------- | -------- |
| Collateral        | Yes                    | Yes      | No       | No       | No       |
| Borrowable        | No                     | No       | Yes      | Yes      | Yes      |
| LTV               | Subject to Risk Oracle | -        | -        | -        | -        |
| LT                | Subject to Risk Oracle | -        | -        | -        | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        | -        | -        | -        |

**PT-USDe USDe E-mode(id:12)**

| **Asset**         | **PT-USDe**            | **USDe** |
| ----------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes      |
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

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_31JUL2025 and the corresponding aToken.

### PT_eUSDe_14AUG2025

The table below illustrates the configured risk parameters for **PT_eUSDe_14AUG2025**

| Parameter                       |       Value |
| ------------------------------- | ----------: |
| Isolation Mode                  |       false |
| Borrowable                      |    DISABLED |
| Collateral Enabled              |        true |
| Supply Cap (PT_eUSDe_14AUG2025) | 100,000,000 |
| Borrow Cap (PT_eUSDe_14AUG2025) |           1 |
| Debt Ceiling                    |       USD 0 |
| LTV                             |      0.05 % |
| LT                              |       0.1 % |
| Liquidation Bonus               |       7.5 % |
| Liquidation Protocol Fee        |        10 % |
| Reserve Factor                  |        45 % |
| Base Variable Borrow Rate       |         0 % |
| Variable Slope 1                |        10 % |
| Variable Slope 2                |       300 % |
| Uoptimal                        |        45 % |
| Flashloanable                   |     ENABLED |
| Siloed Borrowing                |    DISABLED |
| Borrowable in Isolation         |    DISABLED |

**Pricefeed details**

| Parameter              |                                                                                                                         Value |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------: |
| Oracle                 | [PT Capped eUSDe USDT/USD linear discount 14AUG2025](https://etherscan.io/address/0x03f9ba9a897241985c1f12bce97fac1b0bd4a7a7) |
| Underlying Oracle      |                                    [Capped USDT/USD](https://etherscan.io/address/0xC26D4a1c46d884cfF6dE9800B6aE7A8Cf48B4Ff8) |
| Underlying Oracle      |                                 [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Oracle Latest Answer   |                                                                                                    (2025-05-21) USD .97942094 |
| discountRatePerYear    |                                                                                                                        9.037% |
| maxDiscountRatePerYear |                                                                                                                       29.781% |

**PT-eUSDe Stablecoins E-mode(id:13)**

| **Asset**         | **PT-eUSDe**           | **eUSDe** | **USDC** | **USDT** | **USDS** |
| ----------------- | ---------------------- | --------- | -------- | -------- | -------- |
| Collateral        | Yes                    | Yes       | No       | No       | No       |
| Borrowable        | No                     | No        | Yes      | Yes      | Yes      |
| LTV               | Subject to Risk Oracle | -         | -        | -        | -        |
| LT                | Subject to Risk Oracle | -         | -        | -        | -        |
| Liquidation Bonus | Subject to Risk Oracle | -         | -        | -        | -        |

**PT-eUSDe USDe E-mode(id:14)**

| **Asset**         | **PT-eUSDe**           | **eUSDe** | **USDe** |
| ----------------- | ---------------------- | --------- | -------- |
| Collateral        | Yes                    | Yes       | No       |
| Borrowable        | No                     | No        | Yes      |
| LTV               | Subject to Risk Oracle | -         | -        |
| LT                | Subject to Risk Oracle | -         | -        |
| Liquidation Bonus | Subject to Risk Oracle | -         | -        |

**Initial E-mode Risk Oracle**

| Parameter | Value      | Value |
| --------- | ---------- | ----- |
| E-Mode    | Stablecoin | USDe  |
| LTV       | 87.1%      | 89%   |
| LT        | 90.1%      | 91%   |
| LB        | 4.1%       | 3.1%  |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_eUSDe_14AUG2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250520_AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core/AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250520_AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core/AaveV3Ethereum_OnboardUSDeJulyExpiryPTTokensAndEUSDeAugustExpiryPTTokensOnV3Core_20250520.t.sol)
- Snapshot: Direct-to-AIP
- Discussion: [eUSDe](https://governance.aave.com/t/arfc-onboard-eusde-to-aave-v3-core-instance/21766), [PT-USDe-31JUL2025](https://governance.aave.com/t/arfc-onboard-usde-july-expiry-pt-tokens-on-aave-v3-core-instance/22041), [PT-eUSDe-14AUG2025](https://governance.aave.com/t/arfc-onboard-eusde-august-expiry-pt-tokens-on-aave-v3-core-instance/22076), [EMODE for PT Collateral](https://governance.aave.com/t/arfc-addendum-modify-e-modes-for-pt-token-collateral/22128)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
