---
title: "Migration of remaining Gov v2 permissions & DAO's Paraswap positive slippage"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/17"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4fd357741900bfe62a863d1e3ec84fbf79bfebd5bdda3f66eee75b8845274b6d"
---

## Simple Summary

Migrate Aave Arc pool permissions & Paraswap positive slippage funds allocated to the old governance v2 Short Executor.

## Motivation

In November 2022 a permissionless contract was [introduced](https://governance.aave.com/t/bgd-aave-paraswap-fee-claimer/10671) to collect positive slippage from Paraswap swaps to the Aave Collector, gained on features like collateral swap, debt swap or repay with collateral. While this system is well and active since [then](https://dashboard.paraswap.io/public/dashboard/5b6dae52-b39e-4c49-a670-e0f0c0aebee5?partner=aave) there are some funds (~100k) pending to claim from the previous system which still need [migration](https://governance.aave.com/t/bgd-aave-paraswap-fee-claimer/10671/3).

Additionally, when Governance v3 was introduced, some permissions for the deprecated Aave Arc pool were not migrated to the new governance system. For proper hygiene and permissions alignment, this should still be done.

Approving this proposal will also authorize the guardians on `optimism`, `arbitrum`, `avalanche` and `fantom` to claim the pending paraswap positive slippage to the respective network collector.

## Specification

On Ethereum & Polygon the proposal calls:

- `pspclaimer.batchWithdrawAllERC20(assets, collector)` to claim pending rewards to the collector

On Ethereum the proposal also queues a call to:

- `arcTimelock.updateEthereumGovernanceExecutor(GovernanceV3Ethereum.EXECUTOR_LVL_1)`

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4fd357741900bfe62a863d1e3ec84fbf79bfebd5bdda3f66eee75b8845274b6d)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/17)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
