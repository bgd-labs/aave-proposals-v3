---
title: "Upgrade Aave instances to v3.4"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-v3-4/21572/21"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xbbdd44ff07184dc17b9215414f5bb747a48c19e699c7505df35a7e1ca54e9da6"
---

## Simple Summary

Upgrade the Aave v3 Protocol across all networks from v3.3 to v3.4.

## Motivation

The motivation behind this proposal is to upgrade the Aave instances to version 3.4, which includes several improvements most notably:

- The “standardisation” of the custom a/v GHO on Ethereum Core, into the usual a/v Token model for any other asset, including all migration steps required on the protocol layer, not to affect users.
- Multi-call support.
- Introduction of the configurable Position Manager for users, to optionally allow switching emode or collateral enable/disable on behalf of the user.
- Removal of the “unbacked” logic from the protocol.
- Changes of different variables to immutables, given their constant nature.
- Migration to Errors, instead of error codes.
- Flash loan fee simplification.

And extensive list of features and Changelog can be found [HERE](https://github.com/aave-dao/aave-v3-origin/blob/59a2a02be96c824a67ab65f0c465e6db2b034d81/docs/3.4/Aave-v3.4-features.md)

## Specification

The upgrade payload updates the implementations of the `PoolConfigurator`, `Pool`,`PoolDataProvider`, `AToken` & `VariableDebtToken` on all networks.

On Aave V3 Ethereum, the proposal performs some additional actions, to account for aligning `vGHO` from being a custom implementation to the standard implementation.

_It is important to note that stakers of `stkAAVE` will no longer receive a discount on `vGHO` after the upgrade._
Due to technical limitations, the pending discount will be lost upon upgrade time. The stkAAVE discount only manifests whenever a user interacts with the vGHO (by either repaying or borrowing).
To reduce the impact of this loss, `Dolce vita` will iterate the users and call `vGHO.rebalanceUserDiscountPercent(user)` for every user that receives a discount within `< 24h` before proposal execution.
This will reduce the loss to less then 1 day of discount accrual.

By upgrading the implementation of `vGHO` & `aGHO` the existing `aGHO facilitator` will be removed and the new `aGHO` will follow the same pattern as the current `prime GHO facilitator`, namely the whole `GHO capacity` will be pre-minted to `aGHO` instead of minting on demand. Therefore it is expected that on the upgrade we will see:

- ~177M GHO being minted to the new facilitator
- ~177M GHO being transferred to `aGHO`
- ~177M GHO being burned from `aGHO`
- ~23M GHO being minted to the new facilitator
- ~23M GHO being deposited into `aGHO`

The exact numbers, will depend on the current state of the system and the amount of vGHO that is currently in circulation at the time of execution.

For a more detailed breakdown of the steps performed during the upgrades please check [here](https://github.com/bgd-labs/protocol-v3.4-upgrade?tab=readme-ov-file#general-upgrade-sequence-via-upgradepayload)

## Security procedures

- The upgrade was extensively unit tested and fuzzed.
- Certora adapted its formal properties to ensure the upgrade's correctness.

In addition 4 audits by Independent Auditors were conducted.

- [Stermi](https://github.com/aave-dao/aave-v3-origin/blob/74412e2b6e0b1973fac6837b6a488f8eaaeac4b1/audits/2025-06-11_Stermi_Aave-v3.4_Report.md)
- [Certora](https://github.com/aave-dao/aave-v3-origin/blob/74412e2b6e0b1973fac6837b6a488f8eaaeac4b1/audits/2025-06-11_Certora_Aave-v3.4_Report.pdf)
- [Enigma](https://github.com/aave-dao/aave-v3-origin/blob/74412e2b6e0b1973fac6837b6a488f8eaaeac4b1/audits/2025-05-13_Enigma_Aave-v3.4.pdf)
- [Blackthorn](https://github.com/aave-dao/aave-v3-origin/blob/74412e2b6e0b1973fac6837b6a488f8eaaeac4b1/audits/2025-06-12_Blackthorn-v3.4_Report.pdf)

## References

- Implementation: [AaveV3EthereumCore](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayloadMainnet.sol), [AllOtherInstances](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayload.sol)
- Tests: [AaveV3EthereumCore](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/test/MainnetCore.t.sol), [AllOtherInstances](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/test/UpgradeTest.t.sol)
- Upgrade diff: [v3.3 - v3.4](https://github.com/aave-dao/aave-v3-origin/pull/129)
- Onchain Diffs: [Per network diffs](https://github.com/bgd-labs/protocol-v3.4-upgrade/tree/main/diffs/code)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xbbdd44ff07184dc17b9215414f5bb747a48c19e699c7505df35a7e1ca54e9da6)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-4/21572/20)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
