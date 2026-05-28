---
title: "Upgrade Aave instances to v3.7 Part 2"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075"
snapshot: "https://snapshot.org/#/aavedao.eth/proposal/0x2cdd27eda22b36ddde2303c3d69859f74b330eb93661e632700d18c6095335a8"
---

## Simple Summary

Upgrade the Aave protocol instances from v3.6 to v3.7

## Motivation

Aave v3.7 focused on non-invasive simplification of the protocol. It includes the following changes and features:

- Simplification of eModes’ configuration, adding an isolated flag.
- Removal of isolated collaterals and borrowable in isolation, features not useful anymore.
- Removal of the L2 sequencer oracle.
- Explicit removal of the flow to drop reserves, making the reserves list append-only.
- Small improvements on liquidation calculations.

## Specification

Before upgrading the implementations, the payload cleans up reserve configuration flags and settings that are removed in v3.7. For each reserve:

- Reset `debtCeiling`: If a reserve has a non-zero debt ceiling, it is set to zero via `setDebtCeiling(reserve, 0)`. This also resets `isolationModeTotalDebt` to zero.
- Disable `borrowableInIsolation`: If a reserve has `borrowableInIsolation` enabled, it is set to false via `setBorrowableInIsolation(reserve, false)`.
- Additionally, if a sequencer uptime price oracle sentinel is configured, it is unset via `setPriceOracleSentinel(address(0))`, as this feature is removed in v3.7.

After the cleanup, the payload upgrades the core protocol contracts:

- Upgrade `Pool` implementation: The `Pool` contract proxy is updated to point to the new v3.7 implementation via POOL_ADDRESSES_PROVIDER.setPoolImpl(POOL_IMPL).
- Upgrade `PoolConfigurator` implementation: The `PoolConfigurator contract proxy is updated to the new v3.7 implementation via POOL_ADDRESSES_PROVIDER.setPoolConfiguratorImpl(POOL_CONFIGURATOR_IMPL).

Part 2 is applied on the following networks: **Ethereum (Core, Lido), Polygon, Avalanche, Arbitrum, Base, BNB, Linea, Plasma and Mantle**.

Alongside the v3.7 implementation upgrade, this proposal also replaces the current RiskSteward with a newly deployed steward compatible with v3.7. As part of the transition, the existing stewards will have their RISK_ADMIN role revoked on the corresponding ACL_MANAGER, and the new stewards will be granted the role via:

- `ACL_MANAGER.addRiskAdmin(NEW_RISK_STEWARD)`
- `ACL_MANAGER.removeRiskAdmin(OLD_RISK_STEWARD)`

The new stewards are wired in across the following instances: **Ethereum (Core, Prime, EtherFi), Polygon, Avalanche, Arbitrum, Optimism, Base, BNB, Scroll, Gnosis, Linea, Sonic, Celo, Plasma, Mantle, MegaEth, XLayer**.

Additionally, on the instances where GHO is listed as a reserve, GHO is blacklisted on the new RiskSteward via `setAddressRestricted(GHO_UNDERLYING, true)`, since GHO is managed by its own dedicated stewards. The instances where this is applied are: **Ethereum Core, Ethereum Prime, Arbitrum, Avalanche, Base, Gnosis, Mantle, Plasma and XLayer**.

The original proposal has been reviewed by `Certora` at [be21f7354a7e378393515ffd4ebf2d60ca2fcea0](https://github.com/aave-dao/aave-proposals-v3/commit/be21f7354a7e378393515ffd4ebf2d60ca2fcea0).
Since than it has been amended with the RiskSteward migration, which has been reviewed by `Certora` as well.
The proposal diff can be found [here](https://github.com/aave-dao/aave-proposals-v3/blob/0dbee921b36e1ea10ce8c43f4ee6e7971e6c9992/src/20260331_Multi_UpgradeAaveInstancesToV37Part2/git.diff).

## References

- [Implementation](https://github.com/bgd-labs/protocol-v3.7-upgrade/blob/main/src/UpgradePayload.sol)
- [Tests](https://github.com/bgd-labs/protocol-v3.7-upgrade/tree/main/test)
- [Diffs](https://github.com/bgd-labs/protocol-v3.7-upgrade/tree/main/diffs/code)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0x2cdd27eda22b36ddde2303c3d69859f74b330eb93661e632700d18c6095335a8)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
