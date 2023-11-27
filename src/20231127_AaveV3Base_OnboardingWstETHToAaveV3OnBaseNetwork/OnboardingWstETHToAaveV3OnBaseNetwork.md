---
title: "Onboarding wstETH to Aave V3 on Base Network"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-onboarding-wsteth-to-aave-v3-on-base-network/15510/5"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **wstETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (wstETH)                |                                      4,000 |
| Borrow Cap (wstETH)                |                                        400 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                       71 % |
| LT                                 |                                       76 % |
| Liquidation Bonus                  |                                        6 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                       13 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        3 % |
| Stable Rate Excess Offset          |                                        5 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xB88BAc61a4Ca37C43a3725912B1f472c9A5bc061 |

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9cf4ba743e0363f77fbbd1bf0d3946b06154abd57cd4bc897c23cdfcdb3bcbeb)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-wsteth-to-aave-v3-on-base-network/15510/5)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
