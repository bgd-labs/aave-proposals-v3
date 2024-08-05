---
title: "Aave v3 zkSync Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95"
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **USDC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDC)         |                                  1,000,000 |
| Borrow Cap (USDC)         |                                    900,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        9 % |
| Variable Slope 2          |                                        7 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0xA715ED3eC1C078EEf8437Cf717Cf76004f29eAED |

,The table below illustrates the configured risk parameters for **USDT**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (USDT)         |                                  3,000,000 |
| Borrow Cap (USDT)         |                                  2,700,000 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       10 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        9 % |
| Variable Slope 2          |                                       75 % |
| Uoptimal                  |                                       90 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                    ENABLED |
| Oracle                    | 0x336EC4bcb65C1A141318fBd3f8E7379c085E8B15 |

,The table below illustrates the configured risk parameters for **WETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (WETH)         |                                      1,000 |
| Borrow Cap (WETH)         |                                        800 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       75 % |
| LT                        |                                       78 % |
| Liquidation Bonus         |                                        6 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      3.3 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       80 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x6D41d1dc818112880b40e26BD6FD347E41008eDA |

,The table below illustrates the configured risk parameters for **wstETH**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (wstETH)       |                                        500 |
| Borrow Cap (wstETH)       |                                         50 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       71 % |
| LT                        |                                       76 % |
| Liquidation Bonus         |                                        7 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       15 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                      4.5 % |
| Variable Slope 2          |                                       80 % |
| Uoptimal                  |                                       45 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x624FEc7DDeb62Dcbce1fc456D7cc5c6A47cC69aF |

,The table below illustrates the configured risk parameters for **ZK**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                       true |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (ZK)           |                                 24,000,000 |
| Borrow Cap (ZK)           |                                 10,000,000 |
| Debt Ceiling              |                              USD 1,000,000 |
| LTV                       |                                       40 % |
| LT                        |                                       45 % |
| Liquidation Bonus         |                                       10 % |
| Liquidation Protocol Fee  |                                       20 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        9 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       45 % |
| Stable Borrowing          |                                   DISABLED |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0xD1ce60dc8AE060DDD17cA8716C96f193bC88DD13 |

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95)
- [Discussion](https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
