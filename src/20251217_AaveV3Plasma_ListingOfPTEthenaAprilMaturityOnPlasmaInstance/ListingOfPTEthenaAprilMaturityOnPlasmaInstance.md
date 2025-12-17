---
title: "Listing of PT Ethena April Maturity on Plasma Instance"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-april-expiry-pt-tokens-on-aave-v3-plasma-instance/23515/3"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDE_9APR2026**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_sUSDE_9APR2026) |                                100,000,000 |
| Borrow Cap (PT_sUSDE_9APR2026) |                                          1 |
| Debt Ceiling                   |                                      USD 0 |
| LTV                            |                                     87.2 % |
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
| Oracle                         | 0x13f2EA8dfa948c5247826283079615Ee4d0A1AA5 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDE_9APR2026 and the corresponding aToken.
,The table below illustrates the configured risk parameters for **PT_USDe_9APR2026**

| Parameter                     |                                      Value |
| ----------------------------- | -----------------------------------------: |
| Isolation Mode                |                                      false |
| Borrowable                    |                                   DISABLED |
| Collateral Enabled            |                                       true |
| Supply Cap (PT_USDe_9APR2026) |                                 40,000,000 |
| Borrow Cap (PT_USDe_9APR2026) |                                          1 |
| Debt Ceiling                  |                                      USD 0 |
| LTV                           |                                     0.05 % |
| LT                            |                                      0.1 % |
| Liquidation Bonus             |                                      7.5 % |
| Liquidation Protocol Fee      |                                       10 % |
| Reserve Factor                |                                       45 % |
| Base Variable Borrow Rate     |                                        0 % |
| Variable Slope 1              |                                       10 % |
| Variable Slope 2              |                                      300 % |
| Uoptimal                      |                                       45 % |
| Flashloanable                 |                                    ENABLED |
| Siloed Borrowing              |                                   DISABLED |
| Borrowable in Isolation       |                                   DISABLED |
| Oracle                        | 0x37f3a8b02BAbe4dd71acb5f214F22C09AFf607f3 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_9APR2026 and the corresponding aToken.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251217_AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance/AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251217_AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance/AaveV3Plasma_ListingOfPTEthenaAprilMaturityOnPlasmaInstance_20251217.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-april-expiry-pt-tokens-on-aave-v3-plasma-instance/23515/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
