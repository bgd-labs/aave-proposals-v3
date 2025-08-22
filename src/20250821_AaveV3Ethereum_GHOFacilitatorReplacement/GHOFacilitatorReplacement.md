---
title: "GHO Facilitator Replacement"
author: "BGD Labs @bgdlabs"
discussions: TODO
snapshot: TODO
---

## Simple Summary

This proposal outlines the migration from the current `CoreGhoDirectMinter` to a new, correctly configured instance. This is necessary because a misconfiguration during the V3.4 upgrade left the existing facilitator proxy non-upgradeable by Aave Governance.

## Motivation

During the Aave V3.4 upgrade, the `CoreGhoDirectMinter` facilitator was deployed with a misconfiguration in its proxy ownership structure. Specifically, the ownership of the facilitator's `ProxyAdmin` (`0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8`) was assigned to another `ProxyAdmin` contract (`0xD3cF979e676265e4f6379749DECe4708B9A22476`) instead of `GovernanceV3Ethereum.EXECUTOR_LVL_1` ([here](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayloadMainnet.sol#L106-L110)).

This setup creates a dead-end for upgrades. The `GovernanceV3Ethereum.EXECUTOR_LVL_1` owns the top-level `ProxyAdmin` but cannot use it to command the facilitator's `ProxyAdmin` to perform an upgrade. As a result, the DAO is unable to upgrade the `CoreGhoDirectMinter` implementation, preventing future maintenance and improvements.

This proposal resolves the issue by migrating all funds and permissions from the old, non-upgradeable facilitator to a new, correctly configured `CoreGhoDirectMinter` instance.

Addresses of the old facilitator:

- `UpgradePayloadMainnet` contract (V3.4 upgrade payload for the Ethereum Core instance): [`0xC2584B9cA7759FE1ac48D8aE38aeAFE12dbC9876`](https://etherscan.io/address/0xC2584B9cA7759FE1ac48D8aE38aeAFE12dbC9876)
- `GhoDirectMinter` implementation: [`0xe4c958de49303c9be571e00582cf9454586de76f`](https://etherscan.io/address/0xe4c958de49303c9be571e00582cf9454586de76f)
- `GhoDirectMinter` proxy: [`0x593B09afc075B3c326CE2AD7750888645BA8943d`](https://etherscan.io/address/0x593B09afc075B3c326CE2AD7750888645BA8943d)
- `GhoDirectMinter`'s `ProxyAdmin` contract: [`0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8`](https://etherscan.io/address/0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8)
- `MiscEthereum.PROXY_ADMIN` contract (which itself is an owner of the `GhoDirectMinter`'s `ProxyAdmin` contract): [`0xD3cF979e676265e4f6379749DECe4708B9A22476`](https://etherscan.io/address/0xD3cF979e676265e4f6379749DECe4708B9A22476)
- Owner of the `MiscEthereum.PROXY_ADMIN` contract (`GovernanceV3Ethereum.EXECUTOR_LVL_1`): [`0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A`](https://etherscan.io/address/0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A)

## Specification

This proposal will execute a payload to perform the following migration steps:

1.  **Deploy a New Facilitator:** A new `GhoDirectMinter` instance is deployed at `0x5513224daaEABCa31af5280727878d52097afA05`.
2.  **Transfer State:**
    - The bucket capacity and current GHO level of the old facilitator (`0x593B09afc075B3c326CE2AD7750888645BA8943d`) are read.
    - The new facilitator is added to the `GhoToken` with the same bucket capacity.
    - The new facilitator mints and supplies GHO to the Aave Pool, matching the GHO level of the old facilitator.
3.  **Decommission Old Facilitator:**
    - The old facilitator withdraws its GHO from the pool and burns it.
    - Any remaining GHO dust in the old facilitator is transferred to the treasury.
    - The old facilitator is removed from the `GhoToken`'s list of facilitators.
4.  **Update Permissions:**
    - The `RISK_ADMIN` role is granted to the new facilitator and revoked from the old one.
    - The `GhoBucketSteward` is updated to control the new facilitator and cease control of the old one.

This ensures a seamless transition of the facilitator's role and funds while restoring the DAO's ability to perform future upgrades.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250821_AaveV3Ethereum_GHOFacilitatorReplacement/AaveV3Ethereum_GHOFacilitatorReplacement_20250821.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250821_AaveV3Ethereum_GHOFacilitatorReplacement/AaveV3Ethereum_GHOFacilitatorReplacement_20250821.t.sol)
- Aave V3.4 upgrade payload: [`UpgradePayloadMainnet`](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayloadMainnet.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
