---
title: "Aave v3 Scroll Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **WETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (WETH)                  |                                        240 |
| Borrow Cap (WETH)                  |                                        200 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       75 % |
| LT                                 |                                       78 % |
| Liquidation Bonus                  |                                        6 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                      3.3 % |
| Variable Slope 2                   |                                        8 % |
| Uoptimal                           |                                       80 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                      3.3 % |
| Stable Slope2                      |                                        8 % |
| Base Stable Rate Offset            |                                        2 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0x6bF14CB0A831078629D993FDeBcB182b21A8774C |

,The table below illustrates the configured risk parameters for **USDC**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (USDC)                  |                                  1,000,000 |
| Borrow Cap (USDC)                  |                                    900,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       77 % |
| LT                                 |                                       80 % |
| Liquidation Bonus                  |                                        5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        6 % |
| Variable Slope 2                   |                                       60 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        6 % |
| Stable Slope2                      |                                       60 % |
| Base Stable Rate Offset            |                                        1 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                    ENABLED |
| Oracle                             | 0x43d12Fb3AfCAd5347fA764EeAB105478337b7200 |

,The table below illustrates the configured risk parameters for **wstETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (wstETH)                |                                        130 |
| Borrow Cap (wstETH)                |                                         45 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       75 % |
| LT                                 |                                       78 % |
| Liquidation Bonus                  |                                        7 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
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
| Oracle                             | 0xdb93e2712a8b36835078f8d28c70fcc95fd6d37c |

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3Scroll_AaveV3ScrollActivation_20240122.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240122_AaveV3Scroll_AaveV3ScrollActivation/AaveV3Scroll_AaveV3ScrollActivation_20240122.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8110de95ff2827946ede0a9b8c5b9c1876605163bb1e7f8c637b6b80848224c8)
- [Discussion](https://governance.aave.com/t/arfc-aave-v3-deployment-on-scroll-mainnet/16126/)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
