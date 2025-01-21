---
title: "Aave v3 Linea Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852/6"
snapshot: "https://snapshot.org/#/s:aave.eth/proposal/0x5ae276cb67c8d40868916e99f2ef113de02049dd412c3eb47539f97648f50878"
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
| Supply Cap (WETH)         |                                      1,200 |
| Borrow Cap (WETH)         |                                      1,100 |
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
| Oracle                    | 0x3c6Cd9Cc7c7a4c2Cf5a82734CD249D7D593354dA |

,The table below illustrates the configured risk parameters for **WBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WBTC)         |                                         25 |
| Borrow Cap (WBTC)         |                                         12 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       73 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        7 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x7A99092816C8BD5ec8ba229e3a6E6Da1E628E1F9 |

,The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                 12,000,000 |
| Borrow Cap (USDC)         |                                 11,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       60 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x14ac9f8a8646D11D66fbaA9E9F5A869dC08B5D71 |

,The table below illustrates the configured risk parameters for **USDT**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDT)         |                                  7,800,000 |
| Borrow Cap (USDT)         |                                  7,150,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      5.5 % |
| Variable Slope 2          |                                       60 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x0DccbA847D677d4dc3c22C9Dc17DC468226d08Ed |

,The table below illustrates the configured risk parameters for **wstETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wstETH)       |                                        800 |
| Borrow Cap (wstETH)       |                                        400 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       79 % |
| Liquidation Bonus         |                                        7 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                        5 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x96014CA32e2902A5F07c6ADF00eB17D3DE9aC364 |

,The table below illustrates the configured risk parameters for **ezETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (ezETH)        |                                      1,200 |
| Borrow Cap (ezETH)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       72 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x1217a8A40cea4dB5429fbF6EDeB3B606b99CC9b0 |

,The table below illustrates the configured risk parameters for **weETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (weETH)        |                                      1,200 |
| Borrow Cap (weETH)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     72.5 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x0abf2f5642d945b49B8d2DBC6f85c2D8e0424C85 |

## References

- Implementation: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250121_AaveV3Linea_AaveV3LineaActivation/AaveV3Linea_AaveV3LineaActivation_20250121.sol)
- Tests: [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250121_AaveV3Linea_AaveV3LineaActivation/AaveV3Linea_AaveV3LineaActivation_20250121.t.sol)
- [Snapshot](https://snapshot.org/#/s:aave.eth/proposal/0x5ae276cb67c8d40868916e99f2ef113de02049dd412c3eb47539f97648f50878)
- [Discussion](https://governance.aave.com/t/arfc-deployment-of-aave-on-linea/19852/6)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
