---
title: "Onboarding wstETH to Aave V3 on Base Network"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-onboarding-wsteth-to-aave-v3-on-base-network/15510"
---

## Simple Summary

This AIP proposes the onboarding of wstETH (wrapped staked ETH) from Lido to the Aave V3 Base Network to enrich the diversity of the ecosystem's liquid staking assets.

## Motivation

The onboarding of wstETH will provide Aave users with more options for earning staking rewards on their collateral, reinforcing Aave's position as a diverse and inclusive DeFi protocol.

## Specification

The table below illustrates the configured risk parameters for **wstETH**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                      false |
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
| Oracle                             | 0x945fD405773973d286De54E44649cc0d9e264F78 |

- Contract Address: [wstETH - 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452](https://basescan.org/address/0xc1cba3fcea344f92d9239c08c0568f6f2f0ee452)

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/5a20ff77b5bc9ef8b9bf46a3212a9318750e75a6/src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/5a20ff77b5bc9ef8b9bf46a3212a9318750e75a6/src/20231127_AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork/AaveV3Base_OnboardingWstETHToAaveV3OnBaseNetwork_20231127.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9cf4ba743e0363f77fbbd1bf0d3946b06154abd57cd4bc897c23cdfcdb3bcbeb)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-wsteth-to-aave-v3-on-base-network/15510/5)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
