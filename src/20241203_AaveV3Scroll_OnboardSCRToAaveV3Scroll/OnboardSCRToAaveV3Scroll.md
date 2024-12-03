---
title: "Onboard SCR to Aave V3 Scroll"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-scr-to-aave-v3-scroll-instance/19688"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xef7dfa4e96e5f6a7337648d2dd3882f7b10e969c9564c118a34ce99eccec9383"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **SCR**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (SCR)          |                                    360,000 |
| Borrow Cap (SCR)          |                                    180,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                        0 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x26f6F7C468EE309115d19Aa2055db5A74F8cE7A5 |

Additionaly [0xac140648435d03f784879cd789130F22Ef588Fcd](https://scrollscan.com/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for SCR and the corresponding aToken.

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241203_AaveV3Scroll_OnboardSCRToAaveV3Scroll/AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241203_AaveV3Scroll_OnboardSCRToAaveV3Scroll/AaveV3Scroll_OnboardSCRToAaveV3Scroll_20241203.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xef7dfa4e96e5f6a7337648d2dd3882f7b10e969c9564c118a34ce99eccec9383)
- [Discussion](https://governance.aave.com/t/arfc-onboard-scr-to-aave-v3-scroll-instance/19688)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
