---
title: "Aave v3 zkSync Activation"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95"
---

## Simple Summary

This proposal allows the Aave governance to activate the Aave V3 zkSync pool (3.1) by completing all the initial setup and listing USDC, USDT, WETH, wstETH, ZK as suggested by the risk service providers engaged with the DAO on the [governance forum](https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937/7).

All the Aave zkSync V3 addresses can be found in the [aave-address-book](https://github.com/bgd-labs/aave-address-book/blob/main/src/AaveV3ZkSync.sol).

## Motivation

All the governance procedures for the expansion of Aave v3 to zkSync have been finished, said:

- Positive signaling and approval regarding the expansion on the [governance forum](https://governance.aave.com/t/temp-check-aave-v3-deployment-on-zksync-era-mainnet/12477), [temp check snapshot](https://snapshot.org/#/aave.eth/proposal/0x46cf72da892eb216edc1b7fe2f24f7491d8c37344b2b1f67632fa6950be034f7), and [final snapshot](https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95).
- Positive technical evaluation done by BGD Labs of the zkSync network, as described in the [forum](https://governance.aave.com/t/bgd-aave-zksync-infrastructure-technical-evaluation/18503) in detail.
- Positive risk analysis and assets/parameters recommendation by the risk service providers.

## Specification

The proposal will do the following:

- List the following assets on Aave V3 zkSync: USDC, USDT, WETH, wstETH, ZK
- Set the guardian address as the pool admin by executing `ACL_MANAGER.addPoolAdmin()`. This is following the standard procedure of keeping pool admin on the Aave Guardian during the bootstrap period, for security.

The table below illustrates the initial suggested risk parameters for each asset:

| Parameter                 |            [USDC](https://era.zksync.network/address/0x1d17CBcF0D6D143135aE902365D2E5e2A16538D4) |            [USDT](https://era.zksync.network/address/0x493257fD37EDB34451f62EDf8D2a0C418852bA4C) |     [WETH](https://era.zksync.network/address/0x5AEa5775959fBC2557Cc8789bC1bf90A239D9a91) | [wstETH](https://era.zksync.network/address/0x703b52F2b28fEbcB60E1372858AF5b18849FE867) |      [ZK](https://era.zksync.network/address/0x5A7d6b2F92C77FAD6CCaBd7EE0624E64907Eaf3E) |
| ------------------------- | -----------------------------------------------------------------------------------------------: | -----------------------------------------------------------------------------------------------: | ----------------------------------------------------------------------------------------: | --------------------------------------------------------------------------------------: | ---------------------------------------------------------------------------------------: |
| Supply Cap                |                                                                                        1,000,000 |                                                                                        3,000,000 |                                                                                     1,000 |                                                                                     500 |                                                                               24,000,000 |
| Borrow Cap                |                                                                                          900,000 |                                                                                        2,700,000 |                                                                                       800 |                                                                                      50 |                                                                               10,000,000 |
| Borrowable                |                                                                                          ENABLED |                                                                                          ENABLED |                                                                                   ENABLED |                                                                                 ENABLED |                                                                                  ENABLED |
| Collateral Enabled        |                                                                                             true |                                                                                             true |                                                                                      true |                                                                                    true |                                                                                     true |
| LTV                       |                                                                                             75 % |                                                                                             75 % |                                                                                      75 % |                                                                                    71 % |                                                                                     40 % |
| LT                        |                                                                                             78 % |                                                                                             78 % |                                                                                      78 % |                                                                                    76 % |                                                                                     45 % |
| Liquidation Bonus         |                                                                                              5 % |                                                                                              5 % |                                                                                       6 % |                                                                                     7 % |                                                                                     10 % |
| Liquidation Protocol Fee  |                                                                                             10 % |                                                                                             10 % |                                                                                      10 % |                                                                                    10 % |                                                                                     20 % |
| Reserve Factor            |                                                                                             10 % |                                                                                             10 % |                                                                                      15 % |                                                                                    15 % |                                                                                     20 % |
| Base Variable Borrow Rate |                                                                                              0 % |                                                                                              0 % |                                                                                       0 % |                                                                                     0 % |                                                                                      0 % |
| Variable Slope 1          |                                                                                              9 % |                                                                                              9 % |                                                                                     3.3 % |                                                                                   4.5 % |                                                                                      9 % |
| Variable Slope 2          |                                                                                             75 % |                                                                                             75 % |                                                                                      80 % |                                                                                    80 % |                                                                                    300 % |
| Uoptimal                  |                                                                                             90 % |                                                                                             90 % |                                                                                      80 % |                                                                                    45 % |                                                                                     45 % |
| Oracle                    | [Capped USDC/USD](https://era.zksync.network/address/0xA715ED3eC1C078EEf8437Cf717Cf76004f29eAED) | [Capped USDT/USD](https://era.zksync.network/address/0x336EC4bcb65C1A141318fBd3f8E7379c085E8B15) | [ETH/USD](https://era.zksync.network//address/0x6D41d1dc818112880b40e26BD6FD347E41008eDA) |                     [Capped wstETH/ETH/USD](0x624FEc7DDeb62Dcbce1fc456D7cc5c6A47cC69aF) | [ZK/USD](https://era.zksync.network//address/0xD1ce60dc8AE060DDD17cA8716C96f193bC88DD13) |
| Flashloanable             |                                                                                          ENABLED |                                                                                          ENABLED |                                                                                   ENABLED |                                                                                 ENABLED |                                                                                  ENABLED |
| Isolation Mode            |                                                                                            false |                                                                                            false |                                                                                     false |                                                                                   false |                                                                                     true |
| Debt Ceiling              |                                                                                            USD 0 |                                                                                            USD 0 |                                                                                     USD 0 |                                                                                   USD 0 |                                                                            USD 1,000,000 |
| Borrowable in Isolation   |                                                                                          ENABLED |                                                                                          ENABLED |                                                                                  DISABLED |                                                                                DISABLED |                                                                                 DISABLED |
| Siloed Borrowing          |                                                                                         DISABLED |                                                                                         DISABLED |                                                                                  DISABLED |                                                                                DISABLED |                                                                                 DISABLED |
| Stable Borrowing          |                                                                                         DISABLED |                                                                                         DISABLED |                                                                                  DISABLED |                                                                                DISABLED |                                                                                 DISABLED |

### Security procedures

- The proposal execution is simulated within the tests and the resulting pool configuration is tested for correctness.

- The deployed pool and other permissions have been programmatically verified, which can be found on the [aave-permissions-book](https://github.com/bgd-labs/aave-permissions-book/blob/4ce5f4a0c40818e5b837eb035243f7b729279553/out/ZK_SYNC-V3.md#contracts)

- In addition, we have also checked the code diffs of the deployed zkSync contracts with the deployed contracts on Ethereum, which can be found [here](https://github.com/bgd-labs/aave-v3-origin/pull/10)

<details close>
<summary>Below is the comparative diffs of contract modifications relative to Ethereum network, with accompanying link to the diffs</summary>
<br>

[Collector](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-2d2e4b82a1481118e886d5dd780cc16200b579d7ad65e2050cf2a6cea8bf80ed):

- Removal of `_initGuard()` method, as it was added specific to collector unification before.
- Removal of `receive()` method to discourage native tokens on collector and to use wrapped tokens instead.

[AToken](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-ce2e23d83d458b9427a925ad95f53364290f070923aebcee09c5aa6e80f5e675)

- Renaming constructor params in its dependency contract `IncentivizedERC20`.
- Change in inheritance structure for easier modification of revisions and better abstraction.

[StableDebtToken](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-e842d4a31b7539548dd24872dd8b81f0175bdcd7e7ca951495ec5439afa84e8a)

- Renaming constructor params in its dependency contract `IncentivizedERC20`.
- Change in inheritance structure for easier modification of revisions and better abstraction.
- Change to revert in most methods or return 0, as part of stable rate deprecation.

[VariableDebtToken](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-8b0c737dd51a790145194cb5b1bf11a46a9db6049f2a914093bd754303dd3999)

- Renaming constructor params in its dependency contract `IncentivizedERC20`.
- Change in inheritance structure for easier modification of revisions and better abstraction.

[IncentivesController](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-96c59cb2f1cc1468419446aa859acf21ddd24cd75a87636fc4a3003bdc288d8f)

- Change in some `public` methods to `external` on the `RewardsDistributor`.

[PoolAddressesProvider](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-9b575a3437ceb6c996f29c77aff78de0f201be0d9993154566ee3c91863a0f38)

- Renaming constructor params in its dependency contract `BaseImmutableAdminUpgradeabilityProxy`.
- Addition of `receive()` method with fallback in its dependency contract `Proxy`

[UIIncentiveDataProvider](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-c4fa9d74a0a751ca38905d10e309cf5ae9425b31101c508ea0c453db18c0e042)

- Renaming constructor params in its dependency contract `IncentivizedERC20`.
- Renaming of structs to use `DataTypes.ReserveDataLegacy` instead of `DataTypes.ReserveData` following v3.1 changes.

[WETH Gateway](https://github.com/bgd-labs/aave-v3-origin/pull/10/files#diff-b89e24fe08c06cb9f120c2981abc18a998bf971c9052dc309729599a63e6293f)

- Refactoring the `WETH` `POOL` immutable variables as internal.

</details>

## References

- Implementation: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.sol)
- Tests: [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20240805_AaveV3ZkSync_AaveV3ZkSyncActivation/AaveV3ZkSync_AaveV3ZkSyncActivation_20240805.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb74537a0528f484e9cc76d8c7931eedef7b6290e7d2dc725b2c98e623a214f95)
- [Discussion](https://governance.aave.com/t/arfc-deployment-of-aave-on-zksync/17937)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
