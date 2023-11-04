---
title: "Disable Stable Borrows"
author: "BGD (@bgdlabs)"
discussions: https://governance.aave.com/t/aave-v2-v3-security-incident-04-11-2023/15335
---

## Simple Summary

This proposal disables stable borrow rate for all assets across all pools on all networks.
In addition, it unfreezes assets that were previously frozen by the freeze steward.

## Motivation

In response to an attack vector reported by a white-hat, some immediate steps where taken to protect the Aave Markets by
pausing and freezing the affected markets.
This proposal will revert the freezings and apply a permanent fix. Un-pausing the applicable pools will be done via Guardian.

## Specification

The proposal calls

- `POOL_CONFIGURATOR.setReserveStableRateBorrowing(asset, false);` for all assets with stable borrowing enabled on v3 pools,
- `POOL_CONFIGURATOR.disableReserveStableRate(asset);` for Ethereum v2 pool, and
- `POOL_CONFIGURATOR.unfreeze(asset)` with all assets previously frozen as risk mitigation measure.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV2Ethereum_Disable_Stable_Borrows_20231104.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Polygon_Disable_Stable_Borrows_20231104.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Avalanche_Disable_Stable_Borrows_20231104.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Optimism_Disable_Stable_Borrows_20231104.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Arbitrum_Disable_Stable_Borrows_20231104.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV2Ethereum_Disable_Stable_Borrows_20231104.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Polygon_Disable_Stable_Borrows_20231104.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Avalanche_Disable_Stable_Borrows_20231104.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Optimism_Disable_Stable_Borrows_20231104.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/3fb43d535c708cc836c2a4a75a3d36eb2ce9a698/src/20231104_Multi_Disable_Stable_Borrows/AaveV3Arbitrum_Disable_Stable_Borrows_20231104.t.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
