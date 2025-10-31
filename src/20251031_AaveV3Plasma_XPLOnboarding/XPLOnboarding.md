---
title: "XPL Onboarding"
author: "ACI"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-xpl-on-aave-v3-plasma-instance/23197"
snapshot: TODO
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **WXPL**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WXPL)         |                                 14,000,000 |
| Borrow Cap (WXPL)         |                                          1 |
| Debt Ceiling              |                                      USD 1 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xF932477C37715aE6657Ab884414Bd9876FE3f750 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for WXPL and the corresponding aToken.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251031_AaveV3Plasma_XPLOnboarding/AaveV3Plasma_XPLOnboarding_20251031.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251031_AaveV3Plasma_XPLOnboarding/AaveV3Plasma_XPLOnboarding_20251031.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-xpl-on-aave-v3-plasma-instance/23197)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
