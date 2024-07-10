---
title: "Aave v3.1 update"
author: "BGD labs"
discussions: "https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x905264def5a1736097807e33b43bed5271844c6aed9d4f46e047fe6810e39160"
---

## Simple Summary

Proposal for the activation of Aave v3.1 as an upgrade on top of all active Aave v3 instances.

The codebase can be found on https://github.com/aave-dao/aave-v3-origin

## Motivation

Aave v3 is a “living” DeFi protocol, which akin to any other software, receives upgrades over time on its different components.
Sometimes, the improvements can be made in isolation in independent upgrades, for example, almost 1 year ago, we introduced
a new 3.0.2 version 1, including only relatively minor changes and bug fixes.

However, since 3.0.2, we had multiple other ideas on the backlog heavily focused on security and optimisation,
that over time got validated due to security incidents on similar protocols and by observing operational overhead
for Aave contributors (e.g. governance proposals changing parameters). As some of this features in some cases were dependent
between each other, end of 2023 we decided to batch them together in a new major-minor Aave v3 version we propose
for activation here: Aave v3.1.

## Specification

v3.1 is clearly focused in 2 fields: redundant security and optimisation of the logic to reduce operational overhead.
With those principles in mind, the following is a summarised of the features/improvements included in the release
(for extensive information, full specification can be found HERE):

1. Virtual accounting
2. Stateful interest rate strategy
3. Freezing by EMERGENCY_GUARDIAN on PoolConfigurator
4. Reserve data update on rate strategy and RF (Reserve Factor) changes
5. Minimum decimals for listed assets
6. Liquidations grace sentinel
7. LTV0 on freezing
8. Permission-less movement of stable positions to variable
9. Allow setting debt ceiling whenever LT is 0
10. New getters on Pool and PoolConfigurator for library addresses
11. Misc minor bug fixes and sync the codebase with the current v3 production

This update solves the problem of non-inclusion of the amount accrued to the treasury since the last interaction for initial virtual accounting.
To achieve it we force the update of indexes on all reserves before VirtualAccounting activation during the Pool initialization.
Also, because we need to cache the reserve to introduce this change, we switch to using aTokenAddress and liquidityIndex from there.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Ethereum_AaveV31Update_20240624.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Polygon_AaveV31Update_20240624.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Avalanche_AaveV31Update_20240624.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Optimism_AaveV31Update_20240624.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Arbitrum_AaveV31Update_20240624.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Metis_AaveV31Update_20240624.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Base_AaveV31Update_20240624.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Gnosis_AaveV31Update_20240624.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Scroll_AaveV31Update_20240624.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3BNB_AaveV31Update_20240624.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Ethereum_AaveV31Update_20240624.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Polygon_AaveV31Update_20240624.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Avalanche_AaveV31Update_20240624.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Optimism_AaveV31Update_20240624.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Arbitrum_AaveV31Update_20240624.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Metis_AaveV31Update_20240624.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Base_AaveV31Update_20240624.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Gnosis_AaveV31Update_20240624.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3Scroll_AaveV31Update_20240624.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240624_Multi_AaveV31Update/AaveV3BNB_AaveV31Update_20240624.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x905264def5a1736097807e33b43bed5271844c6aed9d4f46e047fe6810e39160)
- [Discussion](https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
