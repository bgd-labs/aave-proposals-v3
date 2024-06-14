---
title: "Onboarding ETHx to Aave V3 Ethereum"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9238b091250c739f5b5486ab8dbaa110b0b7ec0582698ea2c2d3721377e4b0bb"
---

## Simple Summary

This publication onboards Stader Lab's ETHx onto the Ethereum Aave v3 deployment as collateral and includes it the ETH-correlated E-Mode category.

## Motivation

Liquid staking tokens (LSTs) have proven to be popular collateral assets on Aave. The ETHx represents Stader’s staked ETH and provides its users with liquid staking benefits. Supporting ETHx on Aave V3 promotes LST diversity and complements existing assets like stETH, cbETH and rETH.

Given their high correlation to ETH, LSTs are commonly used as collateral to borrow ETH and engage in yield leveraged staking. Several communities have built products that automate such strategies on top of Aave. The inclusion of ETHx in the ETH-category E-Mode enables these strategies to maximize the yield potential of the recursive strategy.

The risk parameters have been provided by Chaos Labs, and the smart contracts of ETHx reviewed by BGD Labs. Further details, including LlamaRisk's more qualitative assessment, can be found on the Aave governance forum.

## Specification

The table below illustrates the configured risk parameters for **ETHx**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                      false |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (ETHx)                  |                                      3,200 |
| Borrow Cap (ETHx)                  |                                        320 |
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
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xD6270dAabFe4862306190298C2B48fed9e15C847 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240521_AaveV3Ethereum_OnboardingETHxToAaveV3/AaveV3Ethereum_OnboardingETHxToAaveV3_20240521.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240521_AaveV3Ethereum_OnboardingETHxToAaveV3/AaveV3Ethereum_OnboardingETHxToAaveV3_20240521.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9238b091250c739f5b5486ab8dbaa110b0b7ec0582698ea2c2d3721377e4b0bb)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-ethx-to-aave-v3-ethereum/15672)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
