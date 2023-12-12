---
title: "Onboarding ETHx to Aave V3 Ethereum"
author: "MarcZeller - Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672"
---

## Simple Summary

This AIP proposes the addition of the liquid staking token ETHx from Stader to Aave V3 Ethereum to enhance LST liquidity and asset diversity.

## Motivation

ETHx represents Stader’s staked ETH, providing users with liquid staking benefits. Supporting ETHx on Aave V3 continues our advocacy for LST diversity, complementing existing assets like stETH, cbETH and rETH.

## Specification

The table below illustrates the configured risk parameters for **ETHx**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       false |
| Borrowable                         |                                   DISABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (ETHx)                  |                                     10,000 |
| Borrow Cap (ETHx)                  |                                      1,000 |
| Debt Ceiling                       |                                      USD 0 |
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
| Stable Slope1                      |                                        7 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        1 % |
| Stable Rate Excess Offset          |                                        8 % |
| Optimal Stable To Total Debt Ratio |                                       20 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xED65C5085a18Fa160Af0313E60dcc7905E944Dc7 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231212_AaveV3Ethereum_OnboardingETHxToAaveV3Ethereum/AaveV3Ethereum_OnboardingETHxToAaveV3Ethereum_20231212.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231212_AaveV3Ethereum_OnboardingETHxToAaveV3Ethereum/AaveV3Ethereum_OnboardingETHxToAaveV3Ethereum_20231212.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9238b091250c739f5b5486ab8dbaa110b0b7ec0582698ea2c2d3721377e4b0bb)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
