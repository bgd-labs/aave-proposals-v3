---
title: "Aave v3 BNB Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-bnb-chain/12609/"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **Cake**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (Cake)                  |                                  5,000,000 |
| Borrow Cap (Cake)                  |                                  2,750,000 |
| Debt Ceiling                       |                              USD 8,000,000 |
| LTV                                |                                       55 % |
| LT                                 |                                       61 % |
| Liquidation Bonus                  |                                       10 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        7 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xB6064eD41d4f67e353768aA239cA86f4F73665a1 |

,The table below illustrates the configured risk parameters for **WBNB**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (WBNB)                  |                                    100,000 |
| Borrow Cap (WBNB)                  |                                    550,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       70 % |
| LT                                 |                                       75 % |
| Liquidation Bonus                  |                                       10 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        7 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x0567F2323251f0Aab15c8dFb1967E4e8A7D42aeE |

,The table below illustrates the configured risk parameters for **BTCB**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (BTCB)                  |                                        500 |
| Borrow Cap (BTCB)                  |                                        275 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       73 % |
| LT                                 |                                       78 % |
| Liquidation Bonus                  |                                      7.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       20 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        7 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x264990fbd0A4796A3E3d8E37C4d5F87a3aCa5Ebf |

,The table below illustrates the configured risk parameters for **ETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (ETH)                   |                                      8,000 |
| Borrow Cap (ETH)                   |                                      6,400 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       80 % |
| LT                                 |                                     82.5 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
| Base Variable Borrow Rate          |                                        1 % |
| Variable Slope 1                   |                                      3.8 % |
| Variable Slope 2                   |                                       80 % |
| Uoptimal                           |                                       80 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        4 % |
| Stable Slope2                      |                                       80 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x9ef1B8c0E4F7dc8bF5719Ea496883DC6401d5b2e |

,The table below illustrates the configured risk parameters for **USDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDC)                  |                                 50,000,000 |
| Borrow Cap (USDC)                  |                                 20,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                     77.5 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                       60 % |
| Base Stable Rate Offset            |                                        1 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                    ENABLED |
| Oracle                             | 0x51597f405303C4377E36123cBc172b13269EA163 |

,The table below illustrates the configured risk parameters for **USDT**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDT)                  |                                 50,000,000 |
| Borrow Cap (USDT)                  |                                 20,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                     77.5 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        5 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        5 % |
| Stable Slope2                      |                                       60 % |
| Base Stable Rate Offset            |                                        1 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                    ENABLED |
| Oracle                             | 0xB97Ad0E74fa7d920791E90258A6E2085088b4320 |

## References

- Implementation: [AaveV3Bnb](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231122_AaveV3Bnb_AaveV3BNBActivation/AaveV3Bnb_AaveV3BNBActivation_20231122.sol)
- Tests: [AaveV3Bnb](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231122_AaveV3Bnb_AaveV3BNBActivation/AaveV3Bnb_AaveV3BNBActivation_20231122.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x60d44523a63e022fcca2f54aa3b84977e49fec0bdf15c9a298122422f6dd5902)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-bnb-chain/12609/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
