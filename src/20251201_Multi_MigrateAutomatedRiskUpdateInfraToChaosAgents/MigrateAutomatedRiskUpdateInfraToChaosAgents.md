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

All the current automated risk param updates will be migrated from the old injector infra to the chaos-agent system including the following:

| Risk Param                                    | Network Instance                                          |
| --------------------------------------------- | --------------------------------------------------------- |
| Supply and Borrow Caps                        | Arbitrum, Avalanche, Base, BNB, Gnosis, Optimism, Polygon |
| Pendle EMode Collateral Param                 | EthereumCore, Plasma                                      |
| Pendle Discount Rate                          | EthereumCore, Plasma                                      |
| Interest Rate: Base, Slope1, Slope2, uOptimal | EthereumPrime                                             |
| Interest Rate: Slope2                         | EthereumCore, Linea                                       |

The chaos agent contracts have not been pre-configured during deployment and all operations including the following will be done on the payload:

- Register new agents on the AgentHub contract by calling `registerAgent()`
- Configure constrained ranges on the `RangeValidationModule` to strictly bound the risk param update from the Chaos Risk Oracle.
- Give `RISK_ADMIN` role to the AgentContract which will be called by the Chaos Agent system to inject updates onto the Aave protocol.
- Revoke `RISK_ADMIN` role from the previous injector contracts as this system will be unused.
- Cancel previous injector automation and register new one's on the AgentHub Automation wrapper contract. This is done only on networks were we use chainlink automation, on Linea, Gnosis and Plasma networks this will be done off-chain using the DAO account on Gelato automation.
- Reimburse BGD Labs with 120 LINK by withdrawing aLINK from Collector on Ethereum, which was used to fund chainlink automation on BNB, Base networks as Collector did not have LINK on those networks.

All configurations used on the proposal payload could be found on the [AgentConfigLib](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/AgentConfigLib.sol).

More detailed specification can be found on the [chaos-agents-migration](https://github.com/bgd-labs/chaos-agents-migration) repo.

## References

- Implementation: [BaseMigrationPayload](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/BaseMigrationPayload.sol), [AaveV3Ethereum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/EthereumCoreMigrationPayload.sol), [AaveV3EthereumPrime](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/EthereumPrimeMigrationPayload.sol), [AaveV3Ethereum_ReimburseLinkForRobot](https://github.com/bgd-labs/aave-proposals-v3/blob/f1f657065c0b6689289710fd8d2e1ceb199a8a91/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_ReimburseLinkForRobot_20251201.sol), [AaveV3Polygon](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/PolygonMigrationPayload.sol), [AaveV3Avalanche](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/AvalancheMigrationPayload.sol), [AaveV3Optimism](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/OptimismMigrationPayload.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/ArbitrumMigrationPayload.sol), [AaveV3Base](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/BaseNetworkMigrationPayload.sol), [AaveV3Gnosis](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/GnosisMigrationPayload.sol), [AaveV3BNB](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/BNBMigrationPayload.sol), [AaveV3Linea](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/LineaMigrationPayload.sol), [AaveV3Plasma](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/PlasmaMigrationPayload.sol)
- Tests: [BaseMigrationTest](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/BaseMigrationPayload.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/EthereumCoreMigrationPayload.t.sol), [AaveV3EthereumPrime](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/EthereumPrimeMigrationPayload.t.sol), [AaveV3Ethereum_ReimburseLinkForRobot](https://github.com/bgd-labs/aave-proposals-v3/blob/f1f657065c0b6689289710fd8d2e1ceb199a8a91/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_ReimburseLinkForRobot_20251201.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/PolygonMigrationPayload.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/AvalancheMigrationPayload.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/OptimismMigrationPayload.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/ArbitrumMigrationPayload.t.sol), [AaveV3Base](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/BNBMigrationPayload.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/GnosisMigrationPayload.t.sol), [AaveV3BNB](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/BNBMigrationPayload.t.sol), [AaveV3Linea](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/LineaMigrationPayload.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/PlasmaMigrationPayload.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x9795f1b7057d2780b3382b9f67f309fbfead98e7357a88df4c309dbbfefcbeb7)
- [Discussion](https://governance.aave.com/t/arfc-chaos-risk-agents/23401)
- Github: [Chaos Agents](https://github.com/ChaosLabsInc/chaos-agents)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
