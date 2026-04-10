---
title: "Register FeeSharesMinter Keeper"
author: "Aave Labs"
discussions: "TODO"
snapshot: "TODO"
---

## Simple Summary

Register the FeeSharesMinter contract as Chainlink Automation keepers via the Aave CL Robot Operator for all assets across all three V4 Ethereum hubs (Core, Plus, Prime), funded with 200 LINK from the Aave Collector.

## Motivation

TODO

## Specification

- Deploy the FeeSharesMinterBase contract owned by the governance executor
- Grant the `HUB_FEE_MINTER_ROLE` (ID 102) to the FeeSharesMinterBase via the V4 AccessManager
- Configure all hub assets with a 5% minimum accrued fees threshold
- Withdraw 200 LINK from the Aave V3 Collector
- Register a Chainlink keeper for each asset on each V4 hub (Core, Plus, Prime) — 31 keepers total
- LINK is distributed evenly across all keepers, each configured with a 500,000 gas limit

## References

- Implementation: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260409_AaveV4Ethereum_RegisterFeeSharesMinterKeeper/AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409.sol)
- Tests: [AaveV4Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260409_AaveV4Ethereum_RegisterFeeSharesMinterKeeper/AaveV4Ethereum_RegisterFeeSharesMinterKeeper_20260409.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
