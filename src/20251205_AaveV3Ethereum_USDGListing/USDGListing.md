---
title: "USDG Listing"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-usdg-to-aave-v3-core-instance/23271"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x31a6ca3a958d1d9f0d560b90487a72af28780a9b19bc6398444c06ee9d3a96fb"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **USDG**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDG)         |                                 30,000,000 |
| Borrow Cap (USDG)         |                                 25,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        6 % |
| Variable Slope 2          |                                       50 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x8adb5187695F773513dEC4b569d21db0341931dA |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for USDG and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_USDGListing/AaveV3Ethereum_USDGListing_20251205.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251205_AaveV3Ethereum_USDGListing/AaveV3Ethereum_USDGListing_20251205.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x31a6ca3a958d1d9f0d560b90487a72af28780a9b19bc6398444c06ee9d3a96fb)
- [Discussion](https://governance.aave.com/t/arfc-onboard-usdg-to-aave-v3-core-instance/23271)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
