---
title: "Onboarding weETH to Aave V3 on Scroll"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboarding-weeth-to-aave-v3-on-scroll/18301"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x252bafcf8ead0bf1869b7ba9fef430caf3977dfd1e1f84e2e4bc1842e83520b4"
---

## Simple Summary

This ARFC seeks to add [Ether.fi](http://ether.fi/) Liquid Restaking Token weETH to Aave V3 on Scroll.

After the successful onboarding of weETH to [Aave v3 Ethereum ](https://vote.onaave.com/proposal/?proposalId=74&ipfsHash=0x227ef8b0f49775f64100ec697bc4e67b0739bd1ff08788b1f6b48a66e1d57bf7), [Arbitrum ](https://vote.onaave.com/proposal/?proposalId=76&ipfsHash=0x78778591515790b337fcdcc2a02d49dc58e98cad614c33d61e1173bc6194729d), and [Base ](https://governance.aave.com/t/arfc-onboarding-of-weeth-to-aave-v3-on-base/17691), alongside recent Supply and Borrow Cap increases for weETH due to significant demand, this proposal will further increase the ability for Aave to service weETH demand from users.

## Motivation

weETH is an LRT that allows users to stake their ETH, accrue staking rewards, and receive additional rewards through native restaking on EigenLayer.

[Ether.fi](http://ether.fi/) has also launched weETH on Arbitrum and Base allowing L2 users to get exposure to LRT yield and points. As weETH has already been approved for onboarding to Aave V3 on Ethereum, Arbitrum, and Base by the DAO, this proposal extends the onboarding of weETH to Aave v3 on Scroll.

## Specification

The table below illustrates the configured risk parameters for **weETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (weETH)        |                                      2,000 |
| Borrow Cap (weETH)        |                                        400 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     72.5 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x32f924C0e0F1Abf5D1ff35B05eBc5E844dEdD2A9 |
| E-Mode Category           |                             ETH-correlated |

## References

- Implementation: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/443541cf27fddd1e4c2ac409c2acfbbd0137ac2e/src/20240731_AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll/AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731.sol)
- Tests: [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/443541cf27fddd1e4c2ac409c2acfbbd0137ac2e/src/20240731_AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll/AaveV3Scroll_OnboardingWeETHToAaveV3OnScroll_20240731.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x252bafcf8ead0bf1869b7ba9fef430caf3977dfd1e1f84e2e4bc1842e83520b4)
- [Discussion](https://governance.aave.com/t/arfc-onboarding-weeth-to-aave-v3-on-scroll/18301)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
