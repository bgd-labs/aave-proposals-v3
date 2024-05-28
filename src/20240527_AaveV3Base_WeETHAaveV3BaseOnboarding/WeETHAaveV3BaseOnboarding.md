---
title: "weETH Aave V3 Base Onboarding"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-onboarding-of-weeth-to-aave-v3-on-base/17691"
---

## Simple Summary

This ARFC seeks to add [Ether.fi](http://ether.fi/) Liquid Restaking Token weETH to Aave V3 on Base.

After the successful onboarding of both weETH to [Aave v3 Ethereum](https://vote.onaave.com/proposal/?proposalId=74&ipfsHash=0x227ef8b0f49775f64100ec697bc4e67b0739bd1ff08788b1f6b48a66e1d57bf7) and [Arbitrum](https://vote.onaave.com/proposal/?proposalId=76&ipfsHash=0x78778591515790b337fcdcc2a02d49dc58e98cad614c33d61e1173bc6194729d), and latest ARFC to Increase Supply and Borrow Caps for weETH on both networks due to huge demand, this proposal will go direct-to-AIP following the asset onboarding framework.

## Motivation

eETH is an LRT that allows users to stake their ETH, accrue staking rewards, and receive additional rewards through native restaking on EigenLayer.

[Ether.fi](http://ether.fi/) has also launched eETH on Arbitrum, allowing users on the L2 to get exposure to the LRT yield and points. As weETH has already been approved for onboarding to Aave v3 Ethereum and Arbitrum by the DAO, this proposal aims to extend the onboarding of weETH to Aave v3 on Base.

## Specification

The table below illustrates the configured risk parameters for **weETH**

the Reserve Factor & UOptimal parameters have been aligned with the mainnet parameters to optimize Aave DAO revenue.

| Parameter                          |                                      Value |
| ---------------------------------- | -----------------------------------------: |
| Isolation Mode                     |                                      False |
| Borrowable                         |                                    ENABLED |
| Collateral Enabled                 |                                       true |
| Supply Cap (weETH)                 |                                        150 |
| Borrow Cap (weETH)                 |                                         30 |
| Debt Ceiling                       |                                      USD 0 |
| LTV                                |                                     72.5 % |
| LT                                 |                                       75 % |
| Liquidation Bonus                  |                                      7.5 % |
| Liquidation Protocol Fee           |                                       10 % |
| Reserve Factor                     |                                       45 % |
| Base Variable Borrow Rate          |                                        0 % |
| Variable Slope 1                   |                                        7 % |
| Variable Slope 2                   |                                      300 % |
| Uoptimal                           |                                       35 % |
| Stable Borrowing                   |                                   DISABLED |
| Stable Slope1                      |                                        7 % |
| Stable Slope2                      |                                      300 % |
| Base Stable Rate Offset            |                                        0 % |
| Stable Rate Excess Offset          |                                        0 % |
| Optimal Stable To Total Debt Ratio |                                        0 % |
| Flashloanable                      |                                    ENABLED |
| Siloed Borrowing                   |                                   DISABLED |
| Borrowable in Isolation            |                                   DISABLED |
| Oracle                             | 0xFc4d1d7a8FD1E6719e361e16044b460737F12C44 |

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240527_AaveV3Base_WeETHAaveV3BaseOnboarding/AaveV3Base_WeETHAaveV3BaseOnboarding_20240527.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240527_AaveV3Base_WeETHAaveV3BaseOnboarding/AaveV3Base_WeETHAaveV3BaseOnboarding_20240527.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-of-weeth-to-aave-v3-on-base/17691)
- [Updated parameters Discussion](https://governance.aave.com/t/arfc-adjusting-interest-rate-curve-for-weeth-on-arbitrum-and-base/17804)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
