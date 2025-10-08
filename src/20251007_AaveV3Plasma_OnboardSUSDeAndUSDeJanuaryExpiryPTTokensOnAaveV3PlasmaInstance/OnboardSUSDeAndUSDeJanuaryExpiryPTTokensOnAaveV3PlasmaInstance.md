---
title: "Onboard sUSDe and USDe January expiry PT tokens on Aave V3 Plasma Instance"
author: "Aave_chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-january-expiry-pt-tokens-on-aave-v3-plasma-instance/23196"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PT_USDe_15JAN2026**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_USDe_15JAN2026) |                                200,000,000 |
| Borrow Cap (PT_USDe_15JAN2026) |                                          1 |
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
| Oracle                         | 0x30cb6ff8649Cc02cEa91971D4730EebeD5A8D2F1 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_15JAN2026 and the corresponding aToken.
,The table below illustrates the configured risk parameters for **PT_sUSDE_15JAN2026**

| Parameter                       |                                      Value |
| ------------------------------- | -----------------------------------------: |
| Isolation Mode                  |                                      false |
| Borrowable                      |                                   DISABLED |
| Collateral Enabled              |                                       true |
| Supply Cap (PT_sUSDE_15JAN2026) |                                200,000,000 |
| Borrow Cap (PT_sUSDE_15JAN2026) |                                          1 |
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
| Oracle                          | 0x3eca1c7836eA09DB3dc85be7B5526Ce80E2609a1 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDE_15JAN2026 and the corresponding aToken.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251007_AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance/AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251007_AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance/AaveV3Plasma_OnboardSUSDeAndUSDeJanuaryExpiryPTTokensOnAaveV3PlasmaInstance_20251007.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-susde-and-usde-january-expiry-pt-tokens-on-aave-v3-plasma-instance/23196)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
