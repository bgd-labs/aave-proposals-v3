---
title: "Onboard wrsETH to Aave v3 Plasma Instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-onboard-wrseth-to-aave-v3-plasma-instance/23183"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **wstETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wstETH)       |                                     20,000 |
| Borrow Cap (wstETH)       |                                      5,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     78.5 % |
| LT                        |                                       81 % |
| Liquidation Bonus         |                                        6 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       35 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                     0.55 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xd6ff49B650550ce2452e0fCCa101Ab7CE206d851 |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for wstETH and the corresponding aToken.
,The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wrsETH)       |                                     20,000 |
| Borrow Cap (wrsETH)       |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                        7 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x3acFddf27b85B5f773B610c6F7e4420aeB1Df8dD |

Additionally [0xac140648435d03f784879cd789130F22Ef588Fcd](https://plasmascan.to/address/0xac140648435d03f784879cd789130F22Ef588Fcd) has been set as the emission admin for wrsETH and the corresponding aToken.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251007_AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance/AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance_20251007.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251007_AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance/AaveV3Plasma_OnboardWrsETHToAaveV3PlasmaInstance_20251007.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-onboard-wrseth-to-aave-v3-plasma-instance/23183)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
