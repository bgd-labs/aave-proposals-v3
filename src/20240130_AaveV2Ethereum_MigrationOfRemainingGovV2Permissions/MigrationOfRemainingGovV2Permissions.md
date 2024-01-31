---
title: "Migration of remaining gov v2 permissions"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-aave-paraswap-fee-claimer/10671/3"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4fd357741900bfe62a863d1e3ec84fbf79bfebd5bdda3f66eee75b8845274b6d"
---

## Simple Summary

Migrate aave arc pool permissions & funds allocated to the old governance v2 short executor.

## Motivation

In November 2022 a permissionless contract was [introduced](https://governance.aave.com/t/bgd-aave-paraswap-fee-claimer/10671) to collect positive slippage from paraswap swaps to the aave-collector. While this system is well and active since [then](https://dashboard.paraswap.io/public/dashboard/5b6dae52-b39e-4c49-a670-e0f0c0aebee5?partner=aave) there are some funds(~100k) stuck in the previous system which still need [migration](https://governance.aave.com/t/bgd-aave-paraswap-fee-claimer/10671/3).

When governance v3 was introduced, some permissions for the deprecated aave arc pool were not properly migrated to the new governance system. For proper permission alignment this should still be done.

## Specification

On mainnet & polygon the proposal calls:

- `pspclaimer.batchWithdrawAllERC20(assets, collector)` to claim pending rewards to the collector

On mainnet the proposal also queues a call to:

- `arcTimelock.updateEthereumGovernanceExecutor(GovernanceV3Ethereum.EXECUTOR_LVL_1)`

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240130_AaveV2Ethereum_MigrationOfRemainingGovV2Permissions/AaveV2Ethereum_MigrationOfRemainingGovV2Permissions_20240130.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
