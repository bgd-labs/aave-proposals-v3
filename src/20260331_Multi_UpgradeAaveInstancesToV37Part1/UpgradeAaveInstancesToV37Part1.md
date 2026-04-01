---
title: "Upgrade Aave instances to v3.7 Part 1"
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

Part 1 is applied on the following networks: **Sonic, Optimism, Gnosis, Scroll, Celo, MegaEth, XLayer and Ethereum (EtherFi)**. Part 2 will follow shortly.

An additional action is included on mainnet which:

- transfers 62'422 $ as aUSDT to BGD Labs
- transfers 12'240 $ as GHO to Certora

to reimburse the cost of the audits.

## References

- [Implementation](https://github.com/bgd-labs/protocol-v3.7-upgrade/blob/main/src/UpgradePayload.sol)
- [Tests](https://github.com/bgd-labs/protocol-v3.7-upgrade/tree/main/test)
- [Diffs](https://github.com/bgd-labs/protocol-v3.7-upgrade/tree/main/diffs/code)
- [Snapshot](https://snapshot.org/#/aavedao.eth/proposal/0x2cdd27eda22b36ddde2303c3d69859f74b330eb93661e632700d18c6095335a8)
- [Discussion](https://governance.aave.com/t/arfc-bgd-aave-v3-7/24075)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
