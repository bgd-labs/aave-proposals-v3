---
title: "Activate Freezing Steward on v3 missing networks"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274"
---

## Summary

Activates the `FreezingSteward` smart contract across all the networks of the protocol, which allows the emergency admin to freeze reserves, as expected.

Currently, there are freezing stewards live for all the networks except Avalanche, Metis, and Base, and this proposal synchronizes the missing ones.

## Motivation

This is a follow-up to [AIP-319](https://app.aave.com/governance/proposal/319/) where on some networks (Avalanche, Metis, and Base) the proposal wasn’t executed. We now resubmit the proposal as an operational update to maintain security and consistency across Aave V3.

## Specification

Adds the `FreezingSteward` contract as `RISK_ADMIN` on the canonical Aave V3 deployments on the following networks:

- Avalanche
- Metis
- Base

The `FreezingSteward` is identical to the one currently deployed on [Ethereum](https://etherscan.io/address/0x2eE68ACb6A1319de1b49DC139894644E424fefD6#code), [Polygon](https://polygonscan.com/address/0xa7b40ed4dfAC9255EA9Dd218A3874f380D9FbBEB), [Optimism](https://optimistic.etherscan.io/address/0x3829943c53F2d00e20B58475aF19716724bF90Ba), [Arbitrum](https://arbiscan.io/address/0xe59470b3be3293534603487e00a44c72f2cd466d) and only allows for entities holding `EMERGENCY_ADMIN` role on `ACLManager` to freeze reserves.

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Avalanche_FreezeStewards_20230907.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Metis_FreezeStewards_20230907.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Base_FreezeStewards_20230907.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Avalanche_FreezeStewards_20230907.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Metis_FreezeStewards_20230907.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals/blob/eb3b1855f4d9e40d9a84bba5ee45b1c449f219ec/src/20230907_AaveV3_Multi_FreezeStewards/AaveV3_Base_FreezeStewards_20230907.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
