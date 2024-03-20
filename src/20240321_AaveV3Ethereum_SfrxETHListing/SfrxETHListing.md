---
title: "sfrxETH Listing"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboarding-sfrxeth-to-aave-v3-ethereum/15673"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x7b5eb16470a0246d8515fc551962740735c7db93bf7c39810e7d3126c04e49c3"
---

## Simple Summary

This ARFC proposes the addition of sfrxETH from Frax to Aave V3 Ethereum to enhance LST liquidity and asset diversity.

## Motivation

sFrxETH is the Staked version of FrxETH from the Frax Ecosystem. Users can freely mint frxETH in exchange for ETH deposits.

The Aave-Chan Initiative supports LST diversity in Aave V3 as shown with our historical support of cbETH, rETH, and, parallel to this proposal, our support for ETHx.

This proposal is a reboot of [ARC Proposal: Onboarding sfrxETH from Frax Protocol to Aave V3 Ethereum Market 10 ](https://governance.aave.com/t/arc-proposal-onboarding-sfrxeth-from-frax-protocol-to-aave-v3-ethereum-market/11510) from January. More details for sFrxETH can be found in the first proposal.

## Specification

The table below illustrates the configured risk parameters for [sfrxETH](https://etherscan.io/token/0xac3e018457b222d93114458476f3e3416abbe38f)

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                       true |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (sfrxETH)               |                                     55,000 |
| Borrow Cap (sfrxETH)               |                                      5,500 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                     74.5 % |
| LT                                 |                                       77 % |
| Liquidation Bonus                  |                                        5 % |
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
| Oracle                             | 0x0000000000000000000000000000000000000000 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240321_AaveV3Ethereum_SfrxETHListing/AaveV3Ethereum_SfrxETHListing_20240321.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240321_AaveV3Ethereum_SfrxETHListing/AaveV3Ethereum_SfrxETHListing_20240321.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7b5eb16470a0246d8515fc551962740735c7db93bf7c39810e7d3126c04e49c3)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-sfrxeth-to-aave-v3-ethereum/15673)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
