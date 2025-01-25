---
title: "Collector upgrade"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/63"
---

## Simple Summary

This proposal will upgrade the Aave Collector across all networks, to allow **multiple** funds admins.

## Motivation

Currently, the Aave Collector (treasury smart contract of the DAO, one per network) is managed by a single `Funds Admin` role, which across all Aave instances is configured to be the Governance Level 1 Executor (Short).

This setup is overly limiting and does not provide the flexibility needed to support use cases like the [Finance Steward](https://governance.aave.com/t/arfc-aave-finance-steward/17570) contracts proposed by Karpatkey & Tokenlogic.

## Specification

The proposal will upgrade all collector contracts to the new version proposed on the aave-origin repository. To account for the differences in the storage layout, a custom initializer is implemented that aligns the storage layout across versions.

As the new version of the Collector implements AccessControl from OZ and removes the existing fundsAdmin role, the proposal will also grant the FUND_ADMIN role to the Level 1 Executor (Short Executor). This way, the setup post-proposal execution will be the same as currently.

## References

- [Implementation](https://github.com/bgd-labs/collector-upgrade-rev6/blob/main/src/CollectorWithCustomImpl.sol), [Linea & Zksync Implementation](https://github.com/bgd-labs/collector-upgrade-rev6/blob/main/src/CollectorWithCustomImplNewLayout.sol)
- [Tests](https://github.com/bgd-labs/collector-upgrade-rev6/tree/main/test)
- [Audit](https://github.com/aave-dao/aave-v3-origin/blob/fbf5c91d7b3f34fff44ac2affdcce5e809889098/audits/2025-01-20_Certora_CollectorRev6.pdf)
- [Upgraded Code](https://github.com/aave-dao/aave-v3-origin/blob/fbf5c91d7b3f34fff44ac2affdcce5e809889098/src/contracts/treasury/Collector.sol), [Code Changes](https://github.com/aave-dao/aave-v3-origin/pull/84)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/63)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
