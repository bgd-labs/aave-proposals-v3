---
title: "Onboarding ETHx to Aave V3"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9238b091250c739f5b5486ab8dbaa110b0b7ec0582698ea2c2d3721377e4b0bb"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **ETHx**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                   DISABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (ETHx)                  |                                     10,000 |
| Borrow Cap (ETHx)                  |                                      1,000 |
| Debt Ceiling                       |                                    USD 100 |
| LTV                                |                                     74.5 % |
| LT                                 |                                       77 % |
| Liquidation Bonus                  |                                      7.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       15 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       45 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xC5f8c4aB091Be1A899214c0C3636ca33DcA0C547 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240521_AaveV3Ethereum_OnboardingETHxToAaveV3/AaveV3Ethereum_OnboardingETHxToAaveV3_20240521.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240521_AaveV3Ethereum_OnboardingETHxToAaveV3/AaveV3Ethereum_OnboardingETHxToAaveV3_20240521.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9238b091250c739f5b5486ab8dbaa110b0b7ec0582698ea2c2d3721377e4b0bb)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
