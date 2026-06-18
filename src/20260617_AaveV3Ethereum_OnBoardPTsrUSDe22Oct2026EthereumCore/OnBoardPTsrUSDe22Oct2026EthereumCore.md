---
title: "Onboard PT-srUSDe-22OCT2026 to Aave V3 Core"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-strata-srusde-22oct2026-pt-tokens-to-v3-core-instance/25113"
---

## Simple Summary

This proposal seeks to onboard PT-srUSDe-22OCT2026 to the Aave V3 Core Instance on Ethereum.

## Motivation

Given the established adoption of PT-srUSDe collateral on Aave and the upcoming expiry of PT-srUSDe-25JUN2026, this listing provides a natural rollover destination for existing users.

## Specification

The table below illustrates the configured risk parameters for **PT_srUSDe_22OCT2026**

| Parameter                        |                                      Value |
| -------------------------------- | -----------------------------------------: |
| Borrowable                       |                                   DISABLED |
| Collateral Enabled               |                                       true |
| Supply Cap (PT_srUSDe_22OCT2026) |                                 25,000,000 |
| Borrow Cap (PT_srUSDe_22OCT2026) |                                          1 |
| LTV                              |                                        0 % |
| LT                               |                                        0 % |
| Liquidation Bonus                |                                        0 % |
| Liquidation Protocol Fee         |                                       10 % |
| Reserve Factor                   |                                       45 % |
| Base Variable Borrow Rate        |                                        0 % |
| Variable Slope 1                 |                                       10 % |
| Variable Slope 2                 |                                      300 % |
| Uoptimal                         |                                       45 % |
| Flashloanable                    |                                   DISABLED |
| Oracle                           | 0xbd1bc41479d0b58167584980fe57fda913d4fb73 |

**PT-srUSDe Stablecoins E-Mode**

| Asset             | PT-srUSDe-22OCT2026 | sUSDe  | USDC | USDT | USDe |
| ----------------- | ------------------- | ------ | ---- | ---- | ---- |
| Collateral        | Yes                 | Yes    | No   | No   | No   |
| Borrowable        | No                  | No     | Yes  | Yes  | Yes  |
| LTV               | 88.42%              | 88.42% | -    | -    | -    |
| LT                | 90.42%              | 90.42% | -    | -    | -    |
| Liquidation Bonus | 5.68%               | 5.68%  | -    | -    | -    |

**PT-srUSDe USDe E-Mode**

| Asset             | PT-srUSDe-22OCT2026 | sUSDe  | USDe |
| ----------------- | ------------------- | ------ | ---- |
| Collateral        | Yes                 | Yes    | No   |
| Borrowable        | No                  | No     | Yes  |
| LTV               | 91.06%              | 91.06% | -    |
| LT                | 93.06%              | 93.06% | -    |
| Liquidation Bonus | 2.68%               | 2.68%  | -    |

Pricing PT-srUSDe-22OCT2026 is done with a dynamic linear discount rate oracle.

**Linear Discount Rate Oracle**

| Parameter                  | Value  |
| -------------------------- | ------ |
| initialDiscountRatePerYear | 5.31%  |
| maxDiscountRatePerYear     | 10.22% |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/34ca81d91f2aed368169132eec4f312b3c4a9d26/src/20260617_AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore/AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/34ca81d91f2aed368169132eec4f312b3c4a9d26/src/20260617_AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore/AaveV3Ethereum_OnBoardPTsrUSDe22Oct2026EthereumCore_20260617.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-strata-srusde-22oct2026-pt-tokens-to-v3-core-instance/25113)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
