---
title: "GHO Cross-Chain Launch"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **GHO**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (GHO)                   |                                  1,000,000 |
| Borrow Cap (GHO)                   |                                  1,000,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                        0 % |
| LT                                 |                                        0 % |
| Liquidation Bonus                  |                                        0 % |
| Liquidation Protocol Fee           |                                        0 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        5 % |
| Variable Slope 1                   |                                        4 % |
| Variable Slope 2                   |                                       50 % |
| Uoptimal                           |                                       80 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xB3Fe476e89C87aB9B10Eb4d457e86eB780ED7D2D |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Ethereum_GHOCrossChainLaunch_20240528.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Arbitrum_GHOCrossChainLaunch_20240528.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Ethereum_GHOCrossChainLaunch_20240528.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240528_Multi_GHOCrossChainLaunch/AaveV3Arbitrum_GHOCrossChainLaunch_20240528.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a)
- [Discussion](https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
