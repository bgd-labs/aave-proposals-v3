---
title: "Ethena PT FEB Listing"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-february-expiry-pt-tokens-on-aave-v3-core-instance/23358"
snapshot: Direct to AIP
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PT_USDE_5FEB_2026**

| Parameter                      |                                      Value |
| ------------------------------ | -----------------------------------------: |
| Isolation Mode                 |                                      false |
| Borrowable                     |                                   DISABLED |
| Collateral Enabled             |                                       true |
| Supply Cap (PT_USDE_5FEB_2026) |                                 30,000,000 |
| Borrow Cap (PT_USDE_5FEB_2026) |                                          1 |
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
| Oracle                         | 0xc35D319FA5FEc2BBE0eB4d0a826465b60f821F81 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_USDE_5FEB_2026 and the corresponding aToken.
,The table below illustrates the configured risk parameters for **PT_sUSDe_5FEB_2026**

| Parameter                       |                                      Value |
| ------------------------------- | -----------------------------------------: |
| Isolation Mode                  |                                      false |
| Borrowable                      |                                   DISABLED |
| Collateral Enabled              |                                       true |
| Supply Cap (PT_sUSDe_5FEB_2026) |                                 30,000,000 |
| Borrow Cap (PT_sUSDe_5FEB_2026) |                                          1 |
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
| Oracle                          | 0x4e89f87F24C13819bBDDb56f99b38746C91677D8 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDe_5FEB_2026 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251111_AaveV3Ethereum_EthenaPTFEBListing/AaveV3Ethereum_EthenaPTFEBListing_20251111.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251111_AaveV3Ethereum_EthenaPTFEBListing/AaveV3Ethereum_EthenaPTFEBListing_20251111.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-usde-susde-february-expiry-pt-tokens-on-aave-v3-core-instance/23358)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
