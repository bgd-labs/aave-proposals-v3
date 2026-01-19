---
title: "Aave V3.6 Mantle Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/12"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0xa3dc5b82f2dc5176c2a7543a6cc10aa75cccf96a73afe06478795182cff9d771"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **WETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WETH)         |                                     30,000 |
| Borrow Cap (WETH)         |                                     28,000 |
| Debt Ceiling              |                             USD 30,000,000 |
| LTV                       |                                     80.5 % |
| LT                        |                                       83 % |
| Liquidation Bonus         |                                      5.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      2.5 % |
| Variable Slope 2          |                                        8 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x5bc7Cf88EB131DB18b5d7930e793095140799aD5 |

,The table below illustrates the configured risk parameters for **WMNT**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WMNT)         |                                  5,000,000 |
| Borrow Cap (WMNT)         |                                          1 |
| Debt Ceiling              |                              USD 2,000,000 |
| LTV                       |                                       40 % |
| LT                        |                                       45 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       20 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xD97F20bEbeD74e8144134C4b148fE93417dd0F96 |

,The table below illustrates the configured risk parameters for **USDT0**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDT0)        |                                 50,000,000 |
| Borrow Cap (USDT0)        |                                 47,000,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       10 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee |

,The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                 10,000,000 |
| Borrow Cap (USDC)         |                                  9,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       10 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x3876fb349c14613e0633b5cae08c4e3b1d4904fb |

,The table below illustrates the configured risk parameters for **USDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDe)         |                                 20,000,000 |
| Borrow Cap (USDe)         |                                 17,500,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                     5.25 % |
| Variable Slope 2          |                                       12 % |
| Uoptimal                  |                                       85 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0xFA5dEcEd7cdCEAB065addd0E32D9527ABd1069Ee |

,The table below illustrates the configured risk parameters for **sUSDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (sUSDe)        |                                 20,000,000 |
| Borrow Cap (sUSDe)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       20 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x8b47ec48ac560793861d94a997d020872c1ce3f5 |

,The table below illustrates the configured risk parameters for **FBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (FBTC)         |                                         50 |
| Borrow Cap (FBTC)         |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       20 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x7db2275279F52D0914A481e14c4Ce5a59705A25b |

,The table below illustrates the configured risk parameters for **syrupUSDT**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (syrupUSDT)    |                                 70,000,000 |
| Borrow Cap (syrupUSDT)    |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       20 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xcf1700ee060ab65fa16d5f44a6fbf16721eb0d9b |

,The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wrsETH)       |                                     18,000 |
| Borrow Cap (wrsETH)       |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                        0 % |
| LT                        |                                        0 % |
| Liquidation Bonus         |                                        0 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        5 % |
| Variable Slope 2          |                                       20 % |
| Uoptimal                  |                                       90 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xfed794060d37391d966f931b9509378063c5b0fb |

## References

- Implementation: [AaveV3Mantle](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260117_AaveV3Mantle_AaveV36MantleActivation/AaveV3Mantle_AaveV36MantleActivation_20260117.sol)
- Tests: [AaveV3Mantle](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260117_AaveV3Mantle_AaveV36MantleActivation/AaveV3Mantle_AaveV36MantleActivation_20260117.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0xa3dc5b82f2dc5176c2a7543a6cc10aa75cccf96a73afe06478795182cff9d771)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-v3-on-mantle/20542/12)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
