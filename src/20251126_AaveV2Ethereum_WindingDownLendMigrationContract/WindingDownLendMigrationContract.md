---
title: "Winding down Lend Migration Contract"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa"
---

## Simple Summary

Upgrades the Lend Migration Contract to stop migration after January 1st, 2026.

## Motivation

This proposal is following up on promises made in [Aavenomics Part 1](https://governance.aave.com/t/arfc-aavenomics-implementation-part-one/21248), freeing almost $100 million worth of AAVE to be used for further ecosystem growth and partnerships.

As announced multiple times over the past years and half a decade after opening the LEND to AAVE migration contract, it’s time to close the LEND chapter and focus on AAVE.

This proposal will remove all remaining AAVE ~304k tokens at the time of writing—from the migration contract and redirect them to the ecosystem reserve.

Given that the community has had multiple years of notice, we consider it fair to close down the migration process.

## Specification

Calls `upgradeAndCall` on `LEND_MIGARTION_CONTRACT` to replace the current implementation.
The new implementation prevents migrations and unlocks a permissionless `transferRemainingFundsToEcosystemReserve` after a `block.timestamp` of `1767225600`. The `transferRemainingFundsToEcosystemReserve` will transfer the remaining `AAVE` token to the [`ECOSYSTEM_RESERVE`](https://etherscan.io/address/0x25F2226B597E8F9514B3F68F00f494cF4f286491).

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251126_AaveV2Ethereum_WindingDownLendMigrationContract/AaveV2Ethereum_WindingDownLendMigrationContract_20251126.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251126_AaveV2Ethereum_WindingDownLendMigrationContract/AaveV2Ethereum_WindingDownLendMigrationContract_20251126.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x4d9eb143c46a637dbf98d63ad00a6e53739a9b6affc0eed7d3cd35680500afaa)
- [Discussion](https://governance.aave.com/t/arfc-winding-down-lend-migration-contract/23126)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
