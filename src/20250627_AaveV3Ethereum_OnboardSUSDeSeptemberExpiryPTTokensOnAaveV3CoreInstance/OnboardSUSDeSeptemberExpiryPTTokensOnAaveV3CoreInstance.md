---
title: "Onboard sUSDe September expiry PT tokens on Aave V3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-susde-september-expiry-pt-tokens-on-aave-v3-core-instance/22313"
---

## Simple Summary

This AIP proposes to onboard sUSDe September expiry PT tokens on Aave V3 Core Instance.

## Motivation

The previous sUSDe PT token that was onboarded brought significant inflows to Aave, in preparation for the expiry and rollover we propose to onboard the next expiry of this PT token.

We propose onboarding the 25th September 2025 expiry PT token:

- PT-sUSDE-25SEP2025

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDe_25SEP2025**

| Parameter                       |       Value |
| ------------------------------- | ----------: |
| Isolation Mode                  |       false |
| Borrowable                      |    DISABLED |
| Collateral Enabled              |        true |
| Supply Cap (PT_sUSDe_25SEP2025) | 200,000,000 |
| Borrow Cap (PT_sUSDe_25SEP2025) |           1 |
| Debt Ceiling                    |       USD 0 |
| LTV                             |      0.05 % |
| LT                              |       0.1 % |
| Liquidation Bonus               |       7.5 % |
| Liquidation Protocol Fee        |        10 % |
| Reserve Factor                  |        10 % |
| Base Variable Borrow Rate       |         0 % |
| Variable Slope 1                |         6 % |
| Variable Slope 2                |        50 % |
| Uoptimal                        |        90 % |
| Flashloanable                   |     ENABLED |
| Siloed Borrowing                |    DISABLED |
| Borrowable in Isolation         |    DISABLED |

**Pricefeed details**

| Parameter              |                                                                                                                         Value |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------: |
| Oracle                 | [PT Capped sUSDe USDT/USD linear discount 25SEP2025](https://etherscan.io/address/0x7585693910f39df4959912b27d09eaeef06c1a93) |
| Underlying Oracle      |                                    [Capped USDT/USD](https://etherscan.io/address/0x260326c220E469358846b187eE53328303Efe19C) |
| Underlying Oracle      |                                 [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Oracle Latest Answer   |                                                                                                    (2025-06-08) USD .98358934 |
| discountRatePerYear    |                                                                                                                         7.69% |
| maxDiscountRatePerYear |                                                                                                                        31.11% |

**PT-sUSDE Stablecoins E-mode**

| Asset             | PT-sUSDe | USDC | USDT | USDS | USDe |
| ----------------- | -------- | ---- | ---- | ---- | ---- |
| Collateral        | Yes      | No   | No   | No   | No   |
| Borrowable        | No       | Yes  | Yes  | Yes  | Yes  |
| LTV               | 87.7%    | -    | -    | -    | -    |
| LT                | 89.7%    | -    | -    | -    | -    |
| Liquidation Bonus | 5%       | -    | -    | -    | -    |

**PT-sUSDE USDe E-mode**

| Asset             | PT-sUSDe | USDe |
| ----------------- | -------- | ---- |
| Collateral        | Yes      | No   |
| Borrowable        | No       | Yes  |
| LTV               | 89.1%    | -    |
| LT                | 91.1%    | -    |
| Liquidation Bonus | 3%       | -    |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDe_25SEP2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1ff65984a45b94b1b93e44d8467f871d4963548a/src/20250627_AaveV3Ethereum_OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250627.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/1ff65984a45b94b1b93e44d8467f871d4963548a/src/20250627_AaveV3Ethereum_OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeSeptemberExpiryPTTokensOnAaveV3CoreInstance_20250627.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-susde-september-expiry-pt-tokens-on-aave-v3-core-instance/22313)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
