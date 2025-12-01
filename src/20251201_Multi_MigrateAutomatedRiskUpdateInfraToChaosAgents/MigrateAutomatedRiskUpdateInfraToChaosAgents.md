---
title: "Migrate automated risk update infra to chaos agents"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/arfc-chaos-risk-agents/23401"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x9795f1b7057d2780b3382b9f67f309fbfead98e7357a88df4c309dbbfefcbeb7"
---

## Simple Summary

This proposal migrates all existing injector middleware infra used to perform automated risk updates to the new chaos agents system.

## Motivation

Currently, the AGRS in conjunction with the injector system is responsible for processing risk recommendations for a range of parameters including supply and borrow caps, interest rates, pendle pt e-mode collateral params and CAPO values across multiple assets and Aave instances. These updates are executed through the injector middleware which consume updates from the chaos risk oracles and inject updates onto the Aave protocol in real-time.

While the existing system has served Aave more than well, several limitations exist:

- Limited generalization: Almost every Risk Stewards activation requires ad-hoc replication of the entire architecture. This results in meaningful overhead for Aave SPs (e.g., ACI, Chaos Labs, BGD Labs).
- Limited infrastructure visibility: Tracking all active Risk Stewards, as well as their covered assets and constraints, can be challenging at times.

The Chaos Risk Agents framework generalizes and modularizes the process of ingesting Risk Oracle data within Aave. It eliminates redundant deployments, centralizes validation logic, and improves visibility across all risk automation layers. The result is a cleaner, more maintainable architecture that allows Aave to expand real-time risk management capabilities, ensuring consistent, verifiable execution of parameter updates.

## Specification

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3EthereumLido_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Polygon_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Avalanche_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Optimism_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Arbitrum_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Base_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Gnosis_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3BNB_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Linea_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Plasma_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3EthereumLido_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Polygon_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Avalanche_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Optimism_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Arbitrum_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Base_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Gnosis_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3BNB_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Linea_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Plasma_MigrateAutomatedRiskUpdateInfraToChaosAgents_20251201.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x9795f1b7057d2780b3382b9f67f309fbfead98e7357a88df4c309dbbfefcbeb7)
- [Discussion](https://governance.aave.com/t/arfc-chaos-risk-agents/23401)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
