---
title: "Freeze Stewards"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274"
---

## Summary

Aligns the freezing stewards across all the networks of the protocol, which allows the emergency admin to freeze reserves. Currently, we have the freezing stewards live for all the networks except Avalanche, Metis, and Base, so we now synchronize it on the missing networks.

## Motivation

This is a follow-up to [AIP-319](https://app.aave.com/governance/proposal/319/) where on a few L2s: Avalanche, Metis, and Base the proposal expired previously. We now resubmit the proposal as an operational update to maintain security and consistency across Aave V3 deployments.

## Specification

Adds the `FreezingSteward` contract as the `riskAdmin` on the canonical Aave V3 deployments on the following networks:
- Avalanche
- Metis
- Base

The payload on the above networks does so by executing `ACL_MANAGER.addRiskAdmin(FREEZING_STEWARD)`

The `FreezingSteward` is identical to the one currently deployed on [Ethereum](https://etherscan.io/address/0x2eE68ACb6A1319de1b49DC139894644E424fefD6#code), [Polygon](https://polygonscan.com/address/0xa7b40ed4dfAC9255EA9Dd218A3874f380D9FbBEB), [Optimism](https://optimistic.etherscan.io/address/0x3829943c53F2d00e20B58475aF19716724bF90Ba), [Arbitrum](https://arbiscan.io/address/0xe59470b3be3293534603487e00a44c72f2cd466d) and only allows the `emergencyAdmin` listed in the `ACLManager` for the given deployment to freeze reserves.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Avalanche_FreezeStewards_20230907.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Metis_FreezeStewards_20230907.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Base_FreezeStewards_20230907.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Avalanche_FreezeStewards_20230907.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Metis_FreezeStewards_20230907.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Base_FreezeStewards_20230907.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
