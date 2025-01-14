---
title: "Onboard sUSDe and weETH to Aave v3 on zkSync"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-susde-usde-and-weeth-to-aave-v3-on-zksync/19204"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x6709151a1efa71370a6a0f9a7592d983ed401ac0311cce861fba347081384520"
---

## Simple Summary

This proposal aims to onboard sUSDe and weETH to the Aave v3 protocol on zkSync. This follows the original plans for further expansion on the network.

## Motivation

The integration of sUSDe, and weETH into Aave v3 on zkSync is following the initial plan for the zkSync network launch. With the successful launch of Aave v3 on zkSync, and some time for monitoring, we believe it is time to start expanding from the initial asset list.

These onboardings also include partnership with Ethena and EtherFi to add ZK token incentives to each market, which will contribute to Aave’s growth on zkSync.

## Specification

The table below illustrates the configured risk parameters for **weETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (weETH)        |                                        300 |
| Borrow Cap (weETH)        |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     72.5 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       45 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        7 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       30 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x32aF9A0a47B332761c8C90E9eC9f53e46e852b2B |

The table below illustrates the configured risk parameters for **sUSDe**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (sUSDe)        |                                    400,000 |
| Borrow Cap (sUSDe)        |                                          1 |
| Debt Ceiling              |                                USD 400,000 |
| LTV                       |                                       65 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      8.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        9 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xDaec4cC3a41E423d678428A8Bb29fa1ADF26869a |

Additionally [0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc](https://era.zksync.network/address/0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc) has been set as the emission admin for weETH, sUSDe and their corresponding aTokens.

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/f2940b91dd47d700d1d8ec8632c262b1409e71a9/zksync/src/20250110_AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync/AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/f2940b91dd47d700d1d8ec8632c262b1409e71a9/zksync/src/20250110_AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync/AaveV3ZkSync_OnboardSUSDeUSDeAndWeETHToAaveV3OnZkSync_20250110.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x6709151a1efa71370a6a0f9a7592d983ed401ac0311cce861fba347081384520)
- [Discussion](https://governance.aave.com/t/arfc-onboard-susde-usde-and-weeth-to-aave-v3-on-zksync/19204)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
