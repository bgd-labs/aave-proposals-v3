---
title: "Onboard wrsETH to ZKsync V3 Instance"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-onboard-wrseth-to-zksync-v3-instance/20727"
snapshot: TODO
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **wrsETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                   DISABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wrsETH)       |                                        700 |
| Borrow Cap (wrsETH)       |                                          1 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                     0.05 % |
| LT                        |                                      0.1 % |
| Liquidation Bonus         |                                      7.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                       10 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Flashloanable             |                                   DISABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x8d25c9de6DBAd9a9eadfB2CA4706034F6721d555 |

Additionally [0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc](https://era.zksync.network/address/0x95Cbff6e45C499d45dd8627f3ce179057B5Fbfcc) has been set as the emission admin for wrsETH and the corresponding aToken.

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250408_AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance/AaveV3ZkSync_OnboardWrsETHToZKsyncV3Instance_20250408.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/arfc-onboard-wrseth-to-zksync-v3-instance/20727)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
