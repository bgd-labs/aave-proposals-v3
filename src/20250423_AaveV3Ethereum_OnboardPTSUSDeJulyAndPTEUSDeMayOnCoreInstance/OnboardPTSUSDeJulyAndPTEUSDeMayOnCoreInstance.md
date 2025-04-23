---
title: "Onboard PT sUSDe July and PT eUSDe May on Core Instance"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **PT_sUSDE_31JUL2025**

| Parameter                       |                                      Value |
| ------------------------------- | -----------------------------------------: |
| Isolation Mode                  |                                      false |
| Borrowable                      |                                   DISABLED |
| Collateral Enabled              |                                       true |
| Supply Cap (PT_sUSDE_31JUL2025) |                                 85,000,000 |
| Borrow Cap (PT_sUSDE_31JUL2025) |                                          1 |
| Debt Ceiling                    |                                      USD 0 |
| LTV                             |                                     0.05 % |
| LT                              |                                      0.1 % |
| Liquidation Bonus               |                                      7.5 % |
| Liquidation Protocol Fee        |                                       10 % |
| Reserve Factor                  |                                       20 % |
| Base Variable Borrow Rate       |                                        0 % |
| Variable Slope 1                |                                        7 % |
| Variable Slope 2                |                                      300 % |
| Uoptimal                        |                                       45 % |
| Flashloanable                   |                                    ENABLED |
| Siloed Borrowing                |                                   DISABLED |
| Borrowable in Isolation         |                                   DISABLED |
| Oracle                          | 0xfB2d51573d97fEbA5E2Ad7cc447e76CBad153878 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://etherscan.io/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for PT_sUSDE_31JUL2025 and the corresponding aToken.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250423_AaveV3Ethereum_OnboardPTSUSDeJulyAndPTEUSDeMayOnCoreInstance/AaveV3Ethereum_OnboardPTSUSDeJulyOnCoreInstance_20250423.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xc039953e4f18804bb017876d27621da1ab3e4de53acd3b32d0f1fe94d4bbb6a0)
- [Discussion](https://governance.aave.com/t/arfc-onboard-susde-july-expiry-pt-tokens-on-aave-v3-core-instance/21878)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
