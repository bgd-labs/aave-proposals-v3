---
title: "GHO Cross-Chain - Part 2"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a"
---

## Simple Summary

This AIP is the Part 2 for the GHO Cross-Chain proposal and proposes the configuration of GHO on Arbitrum Aave V3 Pool in connection with the cross-chain implementation strategy.

Following the successful expansion of GHO to the Arbitrum network, this AIP proposes to onboard GHO into the Arbitrum Aave Pool as a borrowable asset, adopting risk parameters formulated by Chaos Labs.

## Motivation

The implementation of the GHO Cross Chain proposal required the proposal AIP to be split into two separate AIPs. This proposal is the second AIP (“Part 2”) for configuration of GHO on Arbitrum Aave Pool adopting risk parameters formulated by Chaos Labs.

## Specification

The table below illustrates the configured risk parameters for **GHO**

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                      false |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                      false |
| Supply Cap (GHO)                   |                                  1,000,000 |
| Borrow Cap (GHO)                   |                                    900,000 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                        0 % |
| LT                                 |                                        0 % |
| Liquidation Bonus                  |                                        0 % |
| Liquidation Protocol Fee           |                                        0 % |
| Reserve Factor                     |                                       10 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                       12 % |
| Variable Slope 2                   |                                       65 % |
| Uoptimal                           |                                       90 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        0 % |
| Stable Slope2                      |                                        0 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xB05984aD83C20b3ADE7bf97a9a0Cb539DDE28DBb |

## References

- Implementation: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/c7161d8c68339faa78dbb10d6c4d0fce1256306f/src/20240613_AaveV3Arbitrum_GHOCrossChainLaunchPart2/AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613.sol)
- Tests: [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/c7161d8c68339faa78dbb10d6c4d0fce1256306f/src/20240613_AaveV3Arbitrum_GHOCrossChainLaunchPart2/AaveV3Arbitrum_GHOCrossChainLaunchPart2_20240613.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2a6ffbcff41a5ef98b7542f99b207af9c1e79e61f859d0a62f3bf52d3280877a)
- [Discussion](https://governance.aave.com/t/arfc-gho-cross-chain-launch/17616)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
