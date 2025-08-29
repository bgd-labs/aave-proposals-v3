---
title: "Onboard sUSDe November expiry PT tokens on Aave V3 Core Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-susde-november-expiry-pt-tokens-on-aave-v3-core-instance/22894"
---

## Simple Summary

This AIP proposes to onboard sUSDe November expiry PT tokens on Aave V3 Core Instance.

## Motivation

The previous sUSDe PT tokens that were onboarded have brought significant inflows to Aave, in preparation for the expiry and rollover we propose to onboard the next expiry of this PT token. We expect at a minimum that deposits will match those in the September expiry PT token, with sidelined demand

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDe_27NOV2025**

| Parameter                       |      Value |
| ------------------------------- | ---------: |
| Isolation Mode                  |      false |
| Borrowable                      |   DISABLED |
| Collateral Enabled              |       true |
| Supply Cap (PT_sUSDe_27NOV2025) | 75,000,000 |
| Borrow Cap (PT_sUSDe_27NOV2025) |          1 |
| Debt Ceiling                    |      USD 0 |
| LTV                             |     0.05 % |
| LT                              |      0.1 % |
| Liquidation Bonus               |      7.5 % |
| Liquidation Protocol Fee        |       10 % |
| Reserve Factor                  |       45 % |
| Base Variable Borrow Rate       |        0 % |
| Variable Slope 1                |       10 % |
| Variable Slope 2                |      300 % |
| Uoptimal                        |       45 % |
| Flashloanable                   |    ENABLED |
| Siloed Borrowing                |   DISABLED |
| Borrowable in Isolation         |   DISABLED |

**Pricefeed details**

| Parameter              |                                                                                                                         Value |
| ---------------------- | ----------------------------------------------------------------------------------------------------------------------------: |
| Oracle                 | [PT Capped sUSDe USDT/USD linear discount 27NOV2025](https://etherscan.io/address/0x8B8B73598a2c4b1de6d3b075618434CfC4826632) |
| Underlying Oracle      |                                    [Capped USDT/USD](https://etherscan.io/address/0x260326c220E469358846b187eE53328303Efe19C) |
| Underlying Oracle      |                                 [Chainlink USDT/USD](https://etherscan.io/address/0x3E7d1eAB13ad0104d2750B8863b489D65364e32D) |
| Oracle Latest Answer   |                                                                                                    (2025-08-25) USD .97795595 |
| discountRatePerYear    |                                                                                                                         8.52% |
| maxDiscountRatePerYear |                                                                                                                        27.90% |

**PT-sUSDE Stablecoins E-mode**

| **Asset**         | **PT-sUSDe-27NOV2025** | **PT-sUSDe-25SEP2025** | **sUSDe** | **USDC** | **USDT** | **USDS** | **USDe** | **USDtb** |
| ----------------- | ---------------------- | ---------------------- | --------- | -------- | -------- | -------- | -------- | --------- |
| Collateral        | Yes                    | Yes                    | Yes       | No       | No       | No       | No       | No        |
| Borrowable        | No                     | No                     | No        | Yes      | Yes      | Yes      | Yes      | Yes       |
| LTV               | 86.1%                  | -                      | -         | -        | -        | -        | -        | -         |
| LT                | 88.1%                  | -                      | -         | -        | -        | -        | -        | -         |
| Liquidation Bonus | 5.4%                   | -                      | -         | -        | -        | -        | -        | -         |

**PT-sUSDE USDe E-mode**

| **Asset**         | **PT-sUSDe-27NOV2025** | **PT-sUSDe-25SEP2025** | **USDe** |
| ----------------- | ---------------------- | ---------------------- | -------- |
| Collateral        | Yes                    | Yes                    | No       |
| Borrowable        | No                     | No                     | Yes      |
| LTV               | 87.8%                  | -                      | -        |
| LT                | 89.8%                  | -                      | -        |
| Liquidation Bonus | 3.4%                   | -                      | -        |

The LTV, LT and LB of the previous emode will be managed by the Edge Risk Oracle.

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDe_27NOV2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250825_AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance/AaveV3Ethereum_OnboardSUSDeNovemberExpiryPTTokensOnAaveV3CoreInstance_20250825.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-susde-november-expiry-pt-tokens-on-aave-v3-core-instance/22894)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
