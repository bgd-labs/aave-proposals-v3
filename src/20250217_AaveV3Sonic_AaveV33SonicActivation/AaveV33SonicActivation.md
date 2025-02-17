---
title: "Aave V3.3 Sonic Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543/3"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **WETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WETH)         |                                        400 |
| Borrow Cap (WETH)         |                                        370 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       80 % |
| LT                        |                                       83 % |
| Liquidation Bonus         |                                        6 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      2.7 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x824364077993847f71293B24ccA8567c00c2de11 |

,The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                  2,000,000 |
| Borrow Cap (USDC)         |                                  1,900,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      9.5 % |
| Variable Slope 2          |                                       40 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x7A8443a2a5D772db7f1E40DeFe32db485108F128 |

,The table below illustrates the configured risk parameters for **wS**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wS)           |                                  3,000,000 |
| Borrow Cap (wS)           |                                  1,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       35 % |
| LT                        |                                       40 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xc76dFb89fF298145b417d221B2c747d84952e01d |

## References

- Implementation: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV3Sonic_AaveV33SonicActivation_20250217.sol)
- Tests: [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250217_AaveV3Sonic_AaveV33SonicActivation/AaveV3Sonic_AaveV33SonicActivation_20250217.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x8d41750cae27326ac50a84a25846747baeb99c57d371c536ec9219ff662f7497)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-sonic/20543/3)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
