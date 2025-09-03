---
title: "GHO Facilitator Replacement"
author: "BGD Labs @bgdlabs"
discussions: https://governance.aave.com/t/technical-maintenance-proposals/15274/107
---

## Simple Summary

This proposal outlines the migration from the current `CoreGhoDirectMinter` to a new, correctly configured instance.

## Motivation

During the Aave V3.4 upgrade, the model of GHO on the v3 Core Ethereum pool was changed, for the DAO to mint GHO to borrow via a Direct Minter facilitator, same as on v3 Prime Ethereum.

However, this `CoreGhoDirectMinter` facilitator was configured wrongly ([here](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayloadMainnet.sol#L106-L110)) in what regards the ownership of the facilitator’s upgradeability: the ownership of the ProxyAdmin ([`0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8`](https://etherscan.io/address/0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8)) (proxy admin of the direct minter itself) was assigned to another `ProxyAdmin` contract ([`0xD3cF979e676265e4f6379749DECe4708B9A22476`](https://etherscan.io/address/0xD3cF979e676265e4f6379749DECe4708B9A22476)) controlled by the Governance Executor, instead of assigning it to the `GovernanceV3Ethereum.EXECUTOR_LVL_1` directly.

Even if the ownership/admin-chain of the setup doesn’t create any type of security issue (all contracts are part the DAO or contracts controlled), this setup doesn’t allow for future upgrades of the `CoreGhoDirectMinter`: the `GovernanceV3Ethereum.EXECUTOR_LVL_1` owns the top-level `ProxyAdmin` but cannot use it to command the facilitator’s the `ProxyAdmin` below to perform an upgrade.

This proposal resolves the issue by migrating the minted GHO and permissions from the old, non-upgradeable facilitator to a new, correctly configured `CoreGhoDirectMinter` instance.

This operation has no negative effect as the Direct Minter is internal infrastructure of the DAO, with end users not having any contact with it.

Addresses of the old facilitator:

- `UpgradePayloadMainnet` contract (V3.4 upgrade payload for the Ethereum Core instance): [`0xC2584B9cA7759FE1ac48D8aE38aeAFE12dbC9876`](https://etherscan.io/address/0xC2584B9cA7759FE1ac48D8aE38aeAFE12dbC9876)
- `GhoDirectMinter` implementation: [`0xe4c958de49303c9be571e00582cf9454586de76f`](https://etherscan.io/address/0xe4c958de49303c9be571e00582cf9454586de76f)
- `GhoDirectMinter` proxy: [`0x593B09afc075B3c326CE2AD7750888645BA8943d`](https://etherscan.io/address/0x593B09afc075B3c326CE2AD7750888645BA8943d)
- `GhoDirectMinter`’s `ProxyAdmin` contract: [`0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8`](https://etherscan.io/address/0xf02d4931e0d5c79af9094cd9dff16ea6e3d9acb8)
- `MiscEthereum.PROXY_ADMIN` contract (which itself is an owner of the `GhoDirectMinter`’s `ProxyAdmin` contract): [`0xD3cF979e676265e4f6379749DECe4708B9A22476`](https://etherscan.io/address/0xD3cF979e676265e4f6379749DECe4708B9A22476)
- Owner of the `MiscEthereum.PROXY_ADMIN` contract (`GovernanceV3Ethereum.EXECUTOR_LVL_1`): [`0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A`](https://etherscan.io/address/0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A)

## Specification

This proposal will execute a payload to perform the following migration steps:

1. Transfer state to new Facilitator

- The bucket capacity and current GHO level of the old facilitator (`0x593B09afc075B3c326CE2AD7750888645BA8943d`) are read.
- The new facilitator (new `GhoDirectMinter` on `0x5513224daaEABCa31af5280727878d52097afA05`) is added to the `GhoToken` with the same bucket capacity as the previous one.
- The new facilitator mints and supplies GHO to the Aave Pool, matching the GHO level of the old facilitator.

2. Disable the old Facilitator:

- After the mint and supply on step 1, there is now liquidity available on the pool for the old facilitator to withdraw its GHO from the pool and burn it..
- The old facilitator is removed from the GhoToken’s list of facilitators.

3. Update permissions:

- The `RISK_ADMIN` role is granted to the new facilitator and revoked from the old one.
- The `GhoBucketSteward` is updated to control the new facilitator and cease control of the old one.

This ensures a seamless/exact transition of the facilitator’s role and funds (aGHO) while restoring the DAO’s ability to perform future upgrades.

## References

- Implementation: [`AaveV3Ethereum`](https://github.com/bgd-labs/aave-proposals-v3/blob/3cd5d056c3cb152fa44843a78532023100a6595b/src/20250821_AaveV3Ethereum_GHOFacilitatorReplacement/AaveV3Ethereum_GHOFacilitatorReplacement_20250821.sol)
- Tests: [`AaveV3Ethereum`](https://github.com/bgd-labs/aave-proposals-v3/blob/3cd5d056c3cb152fa44843a78532023100a6595b/src/20250821_AaveV3Ethereum_GHOFacilitatorReplacement/AaveV3Ethereum_GHOFacilitatorReplacement_20250821.t.sol)
- Aave V3.4 upgrade payload: [`UpgradePayloadMainnet`](https://github.com/bgd-labs/protocol-v3.4-upgrade/blob/main/src/UpgradePayloadMainnet.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/107)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
