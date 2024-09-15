---
title: "Aave v3 zkSync Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 zkSync pool (3.1) by completing all the initial setup and listing USDC, USDT, WETH, wstETH, ZK as suggested by the risk service providers engaged with the DAO on the [governance forum](https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937/7).

_Please note: Due to the [issue on the dependencies of the ZkSync Era compiler](https://governance.aave.com/t/bgd-aave-v3-zksync-activation-issue-report/18819), the instance has been re-deployed with the fixed compiler version zksolc `1.5.3` with no changes on the protocol code._

All the Aave zkSync V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/65a89f74abb1b37c01442be4340370d5179a94bc/src/AaveV3ZkSync.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to zkSync have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/temp-check-aave-v3-deployment-on-zksync-era-mainnet/12477), [temp check snapshot](https://snapshot.org/#/aave.eth/proposal/0x46cf72da892eb216edc1b7fe2f24f7491d8c37344b2b1f67632fa6950be034f7), and [final snapshot](https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95).
- Positive technical evaluation done by BGD Labs of the zkSync network, as described in the [forum](https://governance.aave.com/t/bgd-aave-zksync-infrastructure-technical-evaluation/18503) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 zkSync: USDC, USDT, WETH, wstETH, ZK
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.
- Set ACI as liquidity mining admin for the ZK token by calling `EMISSION_MANAGER.setEmissionAdmin()` method.

_Note: The risk params suggested by risk service providers have changed post-snapshot, and the updated one's from the [forum](https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937/7) are being used._

The table below illustrates the initial suggested risk parameters for each asset:

| Emode Category Id  | LTV | Liquidation Threshold | Liquidation Bonus |
| ------------------ | --- | --------------------: | ----------------: |
| 1 (ETH correlated) | 90% |                   93% |                1% |

| Parameter                 |            [USDC](https://era.zksync.network/address/0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4) |            [USDT](https://era.zksync.network/address/0x493257fD37EDB34451f62EDf8D2a0C418852bA4C) |     [WETH](https://era.zksync.network/address/0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91) |                 [wstETH](https://era.zksync.network/address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867) |      [ZK](https://era.zksync.network/address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E) |
| ------------------------- | -----------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------: | ------------------------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------: |
| Supply Cap                |                                                                                   \* 100,000,000 |                                                                                     \* 3,000,000 |                                                                                  \* 1,000 |                                                                                                  \* 300 |                                                                            \* 18,000,000 |
| Borrow Cap                |                                                                                       \* 900,000 |                                                                                     \* 2,700,000 |                                                                                    \* 900 |                                                                                                   \* 30 |                                                                            \* 10,000,000 |
| Borrowable                |                                                                                          ENABLED |                                                                                          ENABLED |                                                                                   ENABLED |                                                                                                 ENABLED |                                                                                  ENABLED |
| Collateral Enabled        |                                                                                             true |                                                                                             true |                                                                                      true |                                                                                                    true |                                                                                     true |
| LTV                       |                                                                                             75 % |                                                                                             75 % |                                                                                      75 % |                                                                                                    71 % |                                                                                     40 % |
| LT                        |                                                                                             78 % |                                                                                             78 % |                                                                                      78 % |                                                                                                    76 % |                                                                                     45 % |
| Liquidation Bonus         |                                                                                              5 % |                                                                                              5 % |                                                                                       6 % |                                                                                                     7 % |                                                                                     10 % |
| Liquidation Protocol Fee  |                                                                                             10 % |                                                                                             10 % |                                                                                      10 % |                                                                                                    10 % |                                                                                     20 % |
| Reserve Factor            |                                                                                             10 % |                                                                                             10 % |                                                                                      15 % |                                                                                                     5 % |                                                                                     20 % |
| Base Variable Borrow Rate |                                                                                              0 % |                                                                                              0 % |                                                                                       0 % |                                                                                                     0 % |                                                                                      0 % |
| Variable Slope 1          |                                                                                            5.5 % |                                                                                            5.5 % |                                                                                     2.7 % |                                                                                                   4.5 % |                                                                                      9 % |
| Variable Slope 2          |                                                                                             60 % |                                                                                             60 % |                                                                                      80 % |                                                                                                    80 % |                                                                                    300 % |
| Uoptimal                  |                                                                                             90 % |                                                                                             90 % |                                                                                      90 % |                                                                                                    45 % |                                                                                     45 % |
| Oracle                    | [Capped USDC/USD](https://era.zksync.network/address/0x22A46593A7f93Aaec788bE3e27C1838E15781222) | [Capped USDT/USD](https://era.zksync.network/address/0xE8D6d2dffCFfFc6b1f3606b7552e80319D01A8E9) | [ETH/USD](https://era.zksync.network//address/0x6D41d1dc818112880b40e26BD6FD347E41008eDA) | [Capped wstETH/ETH/USD](https://era.zksync.network//address/0xdea7DE07B8275564Af6135F7E9340411246EB7A2) | [ZK/USD](https://era.zksync.network//address/0xD1ce60dc8AE060DDD17cA8716C96f193bC88DD13) |
| Flashloanable             |                                                                                          ENABLED |                                                                                          ENABLED |                                                                                   ENABLED |                                                                                                 ENABLED |                                                                                  ENABLED |
| Isolation Mode            |                                                                                            false |                                                                                            false |                                                                                     false |                                                                                                   false |                                                                                     true |
| Debt Ceiling              |                                                                                            USD 0 |                                                                                            USD 0 |                                                                                     USD 0 |                                                                                                   USD 0 |                                                                              USD 800,000 |
| Borrowable in Isolation   |                                                                                          ENABLED |                                                                                          ENABLED |                                                                                  DISABLED |                                                                                                DISABLED |                                                                                 DISABLED |
| Siloed Borrowing          |                                                                                         DISABLED |                                                                                         DISABLED |                                                                                  DISABLED |                                                                                                DISABLED |                                                                                 DISABLED |
| Stable Borrowing          |                                                                                         DISABLED |                                                                                         DISABLED |                                                                                  DISABLED |                                                                                                DISABLED |                                                                                 DISABLED |
| Emode Category            |                                                                                              N/A |                                                                                              N/A |                                                                        1 (ETH correlated) |                                                                                      1 (ETH correlated) |                                                                                      N/A |

**\* For extra caution and security, the zkSync instance is being activated with low supply and borrow caps (approximately $10'000 value each asset) to allow for extensive internal testing for a few days. This proposal authorizes the Aave Protocol Guardian to raise the caps to the voted expected levels once the technical providers confirm everything working correctly, on the Aave governance forum**

### Security procedures

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.

- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/bgd-labs/aave-permissions-book/blob/b78a9cf88c71b78b8a66b81bf36f36ffadf21700/out/ZK_SYNC-V3.md#contracts)

- In addition, we have also checked the code diffs of the deployed zkSync contracts with the production instance, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/22). zkSync uses the Aave v3.1 version, and there are some minor diffs because production instances didn't require this change to be applied

Below are the per contract comparative diffs of the contract modifications relative to Gnosis network:

- [Collector](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-434f3437d5c8f0795807c3c699db1ad3863e60644e4b994aafeb88d5e357b86a)

- [AToken](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-075797da2050ffa7aea239ac71202e684f54f6eda31fb60ca2ec5339d54ab6dc)

- [StableDebtToken](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-aac5205a9ee6ddf436ac14d5cdc6ec8c3a6a1f28368b452115036ce35e97e5b3)

- [VariableDebtToken](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-4b9c4e82f39de7b0d0ec88f9322279442e6855703c112bf426241866154e5cf8)

- [IncentivesController](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-dc8bea08ee5028b980ccc71b8d0217ae6e546d0a2410b8f7fdbdd3c93c3c2071)

- [PoolAddressesProvider](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-66ef02951c0288c8925fab2cafc2ac90a2051b98cf47be30bc99aae0ca77de1a)

- [UIIncentiveDataProvider](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-143e0f5c980a001a067bebfda808d23e80da705be36dd274120cae71521eac80)

- [WETHGateway](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-57265e55599d4d41832487b130965c80b553a718b04fdf99ec85171fb32fbc7a)

- [StaticATokenFactory](https://github.com/bgd-labs/aave-v3-origin/pull/22/files#diff-f1f9ded6ed1a429f70c7d6304120886b631191b5ad92342c4a5fa644bfc378cc)

Following the issue on the dependencies of the ZkSync Era compiler during [previous activation](https://vote.onaave.com/proposal/?proposalId=153), as a matter of extra security procedures we have:

- Improved the coverage on the tests, adding some more fork test scenarios covering the issue of bitmap corruption and verifying that the zksolc `1.5.3` fixes the issue. The tests can be found [here](https://github.com/bgd-labs/aave-v3-origin/blob/feat/zksync-tests/tests/core/Pool.E2e.t.sol).

- Reduced the supply and borrow caps further, allowing the guardian to slowly increase it over time.

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95)
- [Discussion](https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
