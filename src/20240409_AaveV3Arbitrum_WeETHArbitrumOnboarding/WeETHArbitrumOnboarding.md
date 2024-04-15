---
title: "weETH Arbitrum onboarding"
author: "@mzeller - ACI"
discussions: "https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758/11"
---

## Simple Summary

This AIP seeks to add Ether.fi Liquid Restaking Token weETH to Aave V3 Arbitrum.

## Motivation

eETH is an LRT that allows users to stake their ETH, accrue staking rewards, and receive additional rewards through native restaking on EigenLayer.

Ether.fi has also launched eETH on Arbitrum, allowing users on the L2 to get exposure to the LRT yield and points. As weETH has already been approved for onboarding to Aave v3 Ethereum by the DAO, this proposal aims to extend the onboarding of weETH to Aave v3 Arbitrum.

## Specification

The table below illustrates the configured risk parameters for **weETH**

| Parameter                          |                                                                                                                Value |
| ---------------------------------- | -------------------------------------------------------------------------------------------------------------------: |
| Isolation Mode                     |                                                                                                                 true |
| Borrowable                         |                                                                                                              ENABLED |
| Collateral Enabled                 |                                                                                                                 true |
| Supply Cap (weETH)                 |                                                                                                                1,000 |
| Borrow Cap (weETH)                 |                                                                                                                  100 |
| Debt Ceiling                       |                                                                                                                USD 0 |
| LTV                                |                                                                                                               72.5 % |
| LT                                 |                                                                                                                 75 % |
| Liquidation Bonus                  |                                                                                                                7.5 % |
| Liquidation Protocol Fee           |                                                                                                                 10 % |
| Reserve Factor                     |                                                                                                                 15 % |
| Base Variable Borrow Rate          |                                                                                                                  0 % |
| Variable Slope 1                   |                                                                                                                  7 % |
| Variable Slope 2                   |                                                                                                                300 % |
| Uoptimal                           |                                                                                                                 45 % |
| Stable Borrowing                   |                                                                                                             DISABLED |
| Stable Slope1                      |                                                                                                                  7 % |
| Stable Slope2                      |                                                                                                                300 % |
| Base Stable Rate Offset            |                                                                                                                  2 % |
| Stable Rate Excess Offset          |                                                                                                                 20 % |
| Optimal Stable To Total Debt Ratio |                                                                                                                 20 % |
| Flashloanable                      |                                                                                                              ENABLED |
| Siloed Borrowing                   |                                                                                                             DISABLED |
| Borrowable in Isolation            |                                                                                                             DISABLED |
| Oracle                             | [0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3](https://arbiscan.io/address/0x517276B5972C4Db7E88B9F76Ee500E888a2D73C3) |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cb2ebc8db9790d41bb20243fe74e084cf8d14e9f/src/20240409_AaveV3Arbitrum_WeETHArbitrumOnboarding/AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cb2ebc8db9790d41bb20243fe74e084cf8d14e9f/src/20240409_AaveV3Arbitrum_WeETHArbitrumOnboarding/AaveV3Arbitrum_WeETHArbitrumOnboarding_20240409.t.sol)
- [Snapshot](direct-to-aip)
- [Discussion](https://governance.aave.com/t/arfc-onboard-weeth-to-aave-v3-on-ethereum/16758/11)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
