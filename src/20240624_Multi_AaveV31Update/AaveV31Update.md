---
title: "Aave v3.1 upgrade"
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
a new 3.0.2 version, including only relatively minor changes and bug fixes.

However, since 3.0.2, we had multiple other ideas on the backlog heavily focused on security and optimisation,
that over time got validated due to security incidents on similar protocols and by observing operational overhead
for Aave contributors (e.g. governance proposals changing parameters). As some of this features in some cases were dependent
between each other, end of 2023 we decided to batch them together in a new major-minor Aave v3 version we propose
for activation here: Aave v3.1.

## Specification

v3.1 is clearly focused in 2 fields: redundant security and optimisation of the logic to reduce operational overhead.
With those principles in mind, the following is a summarised of the features/improvements included in the release
(for extensive information, full specification can be found [HERE](https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305#features-4)):

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

### Upgrade payloads

All the information about this upgrade can be found on the [payload repository](https://github.com/bgd-labs/protocol-v3.1-upgrade), but to summarise, for each network:

1. The PoolConfigurator implementation is upgraded.
2. The Pool implementation is upgraded. On initialization of the new implementation:

- For each asset, indexes and rate data is updated to the most recent value.
- Also for each asset (except GHO), virtual balance (virtual accounting storage variable) is initialized, together with the flag to enable virtual accounting.

3. The PoolDataProvider address is updated on the PoolAddressesProvider.
4. `_pendingLtv` is initialized for all frozen assets on the PoolConfigurator.
5. The new stateful interest rate strategy is connected to every asset with the current production paramaters. GHO is handled ad-hoc in this stage, given its fixed rate.
6. The `RISK_ADMIN` role is temporarily disabled for Aave v3 Avalanche, due to incompatibility with the new freezing and LTV0 mechanics. It will be re-enabled in a follow-up proposal.

## References

- Payload implementation: [UpgradePayload](https://github.com/bgd-labs/protocol-v3.1-upgrade/blob/main/src/contracts/UpgradePayload.sol)
- New initialization logic of Pool: [PoolRevisionFourInitialize](https://github.com/bgd-labs/protocol-v3.1-upgrade/blob/main/src/contracts/PoolRevisionFourInitialize.sol)
- New L1 pool implementation: [PoolInstanceWithCustomInitialize](https://github.com/bgd-labs/protocol-v3.1-upgrade/blob/main/src/contracts/PoolInstanceWithCustomInitialize.sol)
- New L2 pool implementation: [L2PoolInstanceWithCustomInitialize](https://github.com/bgd-labs/protocol-v3.1-upgrade/blob/main/src/contracts/L2PoolInstanceWithCustomInitialize.sol)
- Payload tests: [Tests](https://github.com/bgd-labs/protocol-v3.1-upgrade/tree/main/tests)
- Aave v3.1 and payloads security procedures: [v3.1 security section](https://github.com/aave-dao/aave-v3-origin?tab=readme-ov-file#security)
- Configuration diffs pre/post proposal execution: [diffs](https://github.com/bgd-labs/protocol-v3.1-upgrade/tree/main/diffs)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x905264def5a1736097807e33b43bed5271844c6aed9d4f46e047fe6810e39160)
- [Discussion](https://governance.aave.com/t/bgd-aave-v3-1-and-aave-origin/17305)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
