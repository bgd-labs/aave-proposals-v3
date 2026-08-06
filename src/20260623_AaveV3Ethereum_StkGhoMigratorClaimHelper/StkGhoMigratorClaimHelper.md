---
title: "Grant Claim Helper Role to StkGhoMigrator"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-stkgho-sgho-migration-tool/25250"
---

## Simple Summary

We present to the community the stkGHO → GHO migration tool, a helper contract that facilitates the migration of user deposits from the deprecated stkGHO contract into the new ERC-4626-compliant sGHO vault. The flow will be accessible through the Aave UI, supporting the [stkGHO deprecation strategy outlined by TokenLogic](https://governance.aave.com/t/arfc-sgho-launch-configuration/24346).

## Motivation

Migrating manually requires several steps: triggering the stkGHO cooldown, redeeming GHO, approving GHO, and depositing it into sGHO. The helper bundles these steps into a single flow, exiting stkGHO and depositing into sGHO on the user's behalf.

## Specification

To exit stkGHO on behalf of users, the contract requires the `CLAIM_HELPER_ROLE` on stkGHO. Upon execution, the proposal grants the `CLAIM_HELPER_ROLE` to the [StkGhoMigrator](https://etherscan.io/address/0xC836143e39201698e7d543bCf21AfF3415aE4697) (`0xC836143e39201698e7d543bCf21AfF3415aE4697`) on [stkGHO](https://etherscan.io/address/0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d) (`0x1a88Df1cFe15Af22B3c4c783D4e6F7F9e0C1885d`).

The migration flow will be made available through the Aave UI.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/063482eb398fdcc1adfa42b5a6353cc99358cd2c/src/20260623_AaveV3Ethereum_StkGhoMigratorClaimHelper/AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/063482eb398fdcc1adfa42b5a6353cc99358cd2c/src/20260623_AaveV3Ethereum_StkGhoMigratorClaimHelper/AaveV3Ethereum_StkGhoMigratorClaimHelper_20260623.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-stkgho-sgho-migration-tool/25250)

## Disclaimer

This proposal was prepared by Aave Labs in its capacity as a contributor to the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
