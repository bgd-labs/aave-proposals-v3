---
title: "Onboard PT-sUSDe-22OCT2026 to Aave v3 Plasma"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-pt-susde-22oct2026-to-aave-v3-plasma/25129"
---

## Simple Summary

This proposal seeks to onboard PT-sUSDe-22OCT2026 to the Aave V3 Plasma Instance.

## Motivation

Given the established adoption of PT-sUSDe collateral on Aave and the upcoming expiry of PT-sUSDe-18JUN2026, this listing provides a natural rollover destination for existing users.

## Specification

The table below illustrates the configured risk parameters for **PT-sUSDE-22OCT2026**

| Parameter                       |                                      Value |
| ------------------------------- | -----------------------------------------: |
| Borrowable                      |                                   DISABLED |
| Collateral Enabled              |                                       true |
| Supply Cap (PT-sUSDE-22OCT2026) |                                150,000,000 |
| Borrow Cap (PT-sUSDE-22OCT2026) |                                          1 |
| LTV                             |                                        0 % |
| LT                              |                                        0 % |
| Liquidation Bonus               |                                        0 % |
| Liquidation Protocol Fee        |                                       10 % |
| Reserve Factor                  |                                       45 % |
| Base Variable Borrow Rate       |                                        0 % |
| Variable Slope 1                |                                       10 % |
| Variable Slope 2                |                                      300 % |
| Uoptimal                        |                                       45 % |
| Flashloanable                   |                                   DISABLED |
| Oracle                          | 0x9c823f4e19ef68347810a9c139619273b8282b7e |

**PT-sUSDe Stablecoins E-Mode**

| Asset             | PT-sUSDe-22OCT2026 | sUSDe  | USDT0 | USDe | GHO |
| ----------------- | ------------------ | ------ | ----- | ---- | --- |
| Collateral        | Yes                | Yes    | No    | No   | No  |
| Borrowable        | No                 | No     | Yes   | Yes  | Yes |
| LTV               | 87.71%             | 87.71% | -     | -    | -   |
| LT                | 89.71%             | 89.71% | -     | -    | -   |
| Liquidation Bonus | 4.87%              | 4.87%  | -     | -    | -   |

**PT-sUSDe USDe E-Mode**

| Asset             | PT-sUSDe-22OCT2026 | sUSDe  | USDe |
| ----------------- | ------------------ | ------ | ---- |
| Collateral        | Yes                | Yes    | No   |
| Borrowable        | No                 | No     | Yes  |
| LTV               | 90.35%             | 90.35% | -    |
| LT                | 92.35%             | 92.35% | -    |
| Liquidation Bonus | 1.87%              | 1.87%  | -    |

Pricing PT-sUSDe-22OCT2026 is done with the same dynamic linear discount rate oracle already used for the other sUSDe maturities on Plasma.

**Linear Discount Rate Oracle**

| Parameter                  | Value  |
| -------------------------- | ------ |
| initialDiscountRatePerYear | 4.37%  |
| maxDiscountRatePerYear     | 12.27% |

## References

- Implementation: [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/dec5abfb09b459c15b6f08221895cad99e09129f/src/20260615_AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma/AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615.sol)
- Tests: [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/dec5abfb09b459c15b6f08221895cad99e09129f/src/20260615_AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma/AaveV3Plasma_OnboardPTSUSDe22OCT2026ToAaveV3Plasma_20260615.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-pt-susde-22oct2026-to-aave-v3-plasma/25129)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
