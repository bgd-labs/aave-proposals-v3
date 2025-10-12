---
title: "Onboard sUSDe and USDe January expiry PT tokens on Aave V3 Plasma Instance"
author: "Aave_chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-january-expiry-pt-tokens-on-aave-v3-plasma-instance/23196"
---

## Simple Summary

This AIP proposes to onboard sUSDe and USDe January expiry PT tokens on Aave V3 Plasma Instance.

## Motivation

The previous Ethena (sUSDe and USDe) PT tokens that were onboarded have brought significant inflows to Aave, given the success of the Plasma instance launch along with the significant USDe and sUSDe liquidity on this instance we believe that onboarding Ethena PT tokens there is a logical next step.

## Specification

The table below illustrates the configured risk parameters for **PT_USDe_15JAN2026** and **PT_sUSDE_15JAN2026**

| Parameter                 | PT_USDe_15JAN2026 | PT_sUSDE_15JAN2026 |
| ------------------------- | ----------------: | -----------------: |
| Isolation Mode            |             false |              false |
| Borrowable                |          DISABLED |           DISABLED |
| Collateral Enabled        |              true |               true |
| Supply Cap                |       200,000,000 |        200,000,000 |
| Borrow Cap                |                 1 |                  1 |
| Debt Ceiling              |             USD 0 |              USD 0 |
| LTV                       |            0.05 % |             0.05 % |
| LT                        |             0.1 % |              0.1 % |
| Liquidation Bonus         |             7.5 % |              7.5 % |
| Liquidation Protocol Fee  |              10 % |               10 % |
| Reserve Factor            |              45 % |               45 % |
| Base Variable Borrow Rate |               0 % |                0 % |
| Variable Slope 1          |              10 % |               10 % |
| Variable Slope 2          |             300 % |              300 % |
| Uoptimal                  |              45 % |               45 % |
| Flashloanable             |           ENABLED |            ENABLED |
| Siloed Borrowing          |          DISABLED |           DISABLED |
| Borrowable in Isolation   |          DISABLED |           DISABLED |

**Pricefeed details**

| Parameter              |                                                                                                             PT_USDe_15JAN2026 |                                                                                                             PT_sUSDE_15JAN2026 |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------------------------------------: |
| Oracle                 | [PT Capped USDe USDT/USD linear discount 15JAN2026](https://plasmascan.to/address/0x30cb6ff8649Cc02cEa91971D4730EebeD5A8D2F1) | [PT Capped sUSDe USDT/USD linear discount 15JAN2026](https://plasmascan.to/address/0x3eca1c7836eA09DB3dc85be7B5526Ce80E2609a1) |
| Underlying Oracle      |                                   [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) |                                    [Capped USDT/USD](https://plasmascan.to/address/0xdBbB0b5DD13E7AC9C56624834ef193df87b022c3) |
| Underlying Oracle      |                                [Chainlink USDT/USD](https://plasmascan.to/address/0x70b77FcdbE2293423e41AdD2FB599808396807BC) |                                 [Chainlink USDT/USD](https://plasmascan.to/address/0x70b77FcdbE2293423e41AdD2FB599808396807BC) |
| Oracle Latest Answer   |                                                                                                    (2025-10-08) USD .97880894 |                                                                                                     (2025-10-08) USD .97767085 |
| discountRatePerYear    |                                                                                                                         7.96% |                                                                                                                          8.38% |
| maxDiscountRatePerYear |                                                                                                                        33.88% |                                                                                                                         27.90% |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDE_15JAN2026, PT_USDe_15JAN2026 and the corresponding aTokens.

### E-mode

**PT-USDe/Stablecoins E-mode**

| **Asset**         | **PT-USDe-15JAN2026**  | **USDT0** | **USDe** |
| ----------------- | ---------------------- | --------- | -------- |
| Collateral        | Yes                    | No        | No       |
| Borrowable        | No                     | Yes       | Yes      |
| LTV               | Subject to Risk Oracle | -         | -        |
| LT                | Subject to Risk Oracle | -         | -        |
| Liquidation Bonus | Subject to Risk Oracle | -         | -        |

**PT-USDe/USDe E-mode**

| **Asset**         | **PT-USDe-15JAN2026**  | **USDe** |
| ----------------- | ---------------------- | -------- |
| Collateral        | Yes                    | No       |
| Borrowable        | No                     | Yes      |
| LTV               | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        |

**Initial E-mode Risk Oracle for PT-USDe-15JAN2026**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 85.4%       | 86.2%     |
| LT            | 87.4%       | 88.2%     |
| LB            | 4.9%        | 3.9%      |

**PT-sUSDe/Stablecoins E-mode**

| **Asset**         | **PT-sUSDe-15JAN2026** | **USDT0** | **USDe** |
| ----------------- | ---------------------- | --------- | -------- |
| Collateral        | Yes                    | No        | No       |
| Borrowable        | No                     | Yes       | Yes      |
| LTV               | Subject to Risk Oracle | -         | -        |
| LT                | Subject to Risk Oracle | -         | -        |
| Liquidation Bonus | Subject to Risk Oracle | -         | -        |

**PT-sUSDe/USDe E-mode**

| **Asset**         | **PT-sUSDe-15JAN2026** | **USDe** |
| ----------------- | ---------------------- | -------- |
| Collateral        | Yes                    | No       |
| Borrowable        | No                     | Yes      |
| LTV               | Subject to Risk Oracle | -        |
| LT                | Subject to Risk Oracle | -        |
| Liquidation Bonus | Subject to Risk Oracle | -        |

**Initial E-mode Risk Oracle for PT-sUSDe-15JAN2026**

| **Parameter** | **Value**   | **Value** |
| ------------- | ----------- | --------- |
| E-Mode        | Stablecoins | USDe      |
| LTV           | 83.9%       | 84.5%     |
| LT            | 85.9%       | 86.5%     |
| LB            | 6.0%        | 5.2%      |

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251007_AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance/AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251007_AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance/AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-january-expiry-pt-tokens-on-aave-v3-plasma-instance/23196)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
