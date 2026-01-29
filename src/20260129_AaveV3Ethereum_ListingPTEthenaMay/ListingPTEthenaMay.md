---
title: "Listing PT Ethena May"
author: "Aavechan Initiative @aci"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-may-expiry-pt-tokens-on-aave-v3-core-instance/23882"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PT_USDe_7MAY2026**

| Parameter                     |                                      Value |
| ----------------------------- | -----------------------------------------: |
| Isolation Mode                |                                       true |
| Borrowable                    |                                   DISABLED |
| Collateral Enabled            |                                       true |
| Supply Cap (PT_USDe_7MAY2026) |                                 81,000,000 |
| Borrow Cap (PT_USDe_7MAY2026) |                                          1 |
| Debt Ceiling                  |                                      USD 1 |
| LTV                           |                                        0 % |
| LT                            |                                        0 % |
| Liquidation Bonus             |                                        0 % |
| Liquidation Protocol Fee      |                                        0 % |
| Reserve Factor                |                                       45 % |
| Base Variable Borrow Rate     |                                        0 % |
| Variable Slope 1              |                                       10 % |
| Variable Slope 2              |                                      300 % |
| Uoptimal                      |                                       45 % |
| Flashloanable                 |                                    ENABLED |
| Siloed Borrowing              |                                   DISABLED |
| Borrowable in Isolation       |                                   DISABLED |
| Oracle                        | 0x0a72df02CE3E4185b6CEDf561f0AE651E9BeE235 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDe_7MAY2026 and the corresponding aToken.
,The table below illustrates the configured risk parameters for **PT_sUSDe_7MAY2026**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                       true |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_sUSDe_7MAY2026) |                                145,000,000 |
| Borrow Cap (PT_sUSDe_7MAY2026) |                                          1 |
| Debt Ceiling                   |                                      USD 1 |
| LTV                            |                                        0 % |
| LT                             |                                        0 % |
| Liquidation Bonus              |                                        0 % |
| Liquidation Protocol Fee       |                                        0 % |
| Reserve Factor                 |                                       45 % |
| Base Variable Borrow Rate      |                                        0 % |
| Variable Slope 1               |                                       10 % |
| Variable Slope 2               |                                      300 % |
| Uoptimal                       |                                        0 % |
| Flashloanable                  |                                    ENABLED |
| Siloed Borrowing               |                                   DISABLED |
| Borrowable in Isolation        |                                   DISABLED |
| Oracle                         | 0xa0dc0249c32fa79e8B9b17c735908a60b1141B40 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDe_7MAY2026 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260129_AaveV3Ethereum_ListingPTEthenaMay/AaveV3Ethereum_ListingPTEthenaMay_20260129.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260129_AaveV3Ethereum_ListingPTEthenaMay/AaveV3Ethereum_ListingPTEthenaMay_20260129.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-may-expiry-pt-tokens-on-aave-v3-core-instance/23882)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
