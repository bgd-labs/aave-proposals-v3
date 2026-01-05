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

| Risk Param                                    | Network Instance                                          | Constrains                                                             |
| --------------------------------------------- | --------------------------------------------------------- | ---------------------------------------------------------------------- |
| Supply and Borrow Caps                        | Arbitrum, Avalanche, Base, BNB, Gnosis, Optimism, Polygon | max 30% relative change / 3 days                                       |
| Pendle EMode Collateral Param                 | EthereumCore, Plasma                                      | max 0.5% absolute change / 3 days for LT, LTV, LB                      |
| Pendle Discount Rate                          | EthereumCore, Plasma                                      | max 1% absolute change / 2 days                                        |
| Interest Rate: Base, Slope1, Slope2, uOptimal | EthereumPrime                                             | max 3% uOpt, 0.5% base, 0.5% slope1, 5% slope2 absolute change / 1 day |
| Interest Rate: Slope2                         | EthereumCore, Linea                                       | max 4% absolute change / 8 hours                                       |

Whitelisted Assets / Markets configured on chaos agent:

|                                      | Whitelisted Assets / Markets                                                                                                                               |
| ------------------------------------ | ---------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Arbitrum Supply / Borrow Caps        | WETH, USDC, USDT, WBTC, DAI, weETH, ARB, USDC.e, GHO, LINK, wstETH, LUSD, FRAX, rETH, AAVE                                                                 |
| Avalanche Supply / Borrow Caps       | WETHe, USDCe, USDTe, WBTCe, DAIe, LINKe, AAVEe, WAVAX, sAVAX, FRAX, MAI, BTCb, AUSD                                                                        |
| Base Supply / Borrow Caps            | WETH, cbETH, USDC, USDbC, weETH, GHO, wstETH, cbBTC, LBTC, EURC                                                                                            |
| BNB Supply / Borrow Caps             | ETH, wstETH, BTCB, USDC, USDT, WBNB                                                                                                                        |
| Gnosis Supply / Borrow Caps          | WETH, wstETH, USDCe, sDAI, EURe, GNO                                                                                                                       |
| Optimism Supply / Borrow Caps        | WETH, wstETH, rETH, WBTC, USDC, USDT, OP                                                                                                                   |
| Polygon Supply / Borrow Caps         | WETH, wstETH, WBTC, USDC, USDC.e, USDT, DAI, AAVE, LINK, WPOL                                                                                              |
| EthereumCore Pendle EMode Collateral | EMode Ids: 8, 9, 10, 12, 13, 14, 17, 18, 19, 20, 24, 25, 27, 28, 29, 30, 31, 32                                                                            |
| Plasma Pendle EMode Collateral       | EMode Ids: 5, 6, 7, 8, 13, 14, 15, 16                                                                                                                      |
| EthereumCore Pendle Discount Rate    | PT_sUSDe_31JUL25, PT_USDe_31JUL25, PT_eUSDe_14AUG25, PT_sUSDe_25SEP25, PT_USDe_25SEP25, PT_sUSDe_27NOV25, PT_USDe_27NOV25, PT_sUSDe_5FEB26, PT_USDe_5FEB26 |
| Plasma Pendle Discount Rate          | PT_sUSDe_15JAN26, PT_USDe_15JAN26, PT_sUSDE_9APR26, PT_USDE_9APR26                                                                                         |
| EthereumPrime Interest Rate          | WETH                                                                                                                                                       |
| EthereumCore Slope2 Interest Rate    | WETH, USDC, USDT, USDe                                                                                                                                     |
| Linea Slope2 Interest Rate           | WETH, USDC, USDT                                                                                                                                           |

_Please note: The whitelisted assets and the constrains are exactly the same as previously on the AGRS injector infra. This proposal only migrates existing automated AGRS system using injector infra, there is no change to the manual AGRS system and updates on it using the new infra will be applied at a different AIP._

The chaos agent contracts have not been pre-configured during deployment and all operations including the following will be done on the payload:

- Register new agents on the AgentHub contract by calling `registerAgent()`
- Configure constrained ranges on the `RangeValidationModule` to strictly bound the risk param update from the Chaos Risk Oracle.
- Give `RISK_ADMIN` role to the AgentContract which will be called by the Chaos Agent system to inject updates onto the Aave protocol.
- Revoke `RISK_ADMIN` role from the previous injector contracts as this system will be unused.
- Cancel previous injector automation and register new one's on the AgentHub Automation wrapper contract. This is done only on networks were we use chainlink automation, on Linea, Gnosis and Plasma networks this will be done off-chain using the DAO account on Gelato automation.
- Reimburse BGD Labs with 120 LINK by withdrawing aLINK from Collector on Ethereum, which was used to fund chainlink automation on BNB, Base networks as Collector did not have LINK on those networks.

All configurations used on the proposal payload could be found on the [AgentConfigLib](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/AgentConfigLib.sol).

More detailed specification can be found on the [chaos-agents-migration](https://github.com/bgd-labs/chaos-agents-migration) repo.

### Security

Chaos Risk Agent contracts is independently audited by [Zellic](https://github.com/ChaosLabsInc/chaos-agents/blob/f02af714ef069e54bae577ac2d34bb3d57d6e1cd/audits/zellic/v1-zellic.pdf) and [Hexens](https://github.com/ChaosLabsInc/chaos-agents/blob/f02af714ef069e54bae577ac2d34bb3d57d6e1cd/audits/hexens/v1-hexens.pdf). In addition, the migration proposal payload and setup has been reviewed by Certora.

### Permissions

Detailed permissions post payload execution of the Chaos Risk Agent could be found on the [permissions-book](https://github.com/aave-dao/aave-permissions-book/compare/47474555dcf6a3d5ce45a0bab7de7bb6d87c1690..33e2307e063e4e21db2408d606ff9bb7a7885ddf), but to summarize (for all networks):

| Role                                | Entity                    |
| ----------------------------------- | ------------------------- |
| AgentHub Owner                      | Governance Executor Lvl 1 |
| AgentHub ProxyAdmin owner           | Governance Executor Lvl 1 |
| Agent Admin                         | Governance Executor Lvl 1 |
| RangeValidationModule Config Update | Governance Executor Lvl 1 |
| `RISK_ADMIN` on ACL Manager         | Agent Contract            |

## References

- Implementation: [BaseMigrationPayload](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/BaseMigrationPayload.sol), [AaveV3Ethereum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/EthereumCoreMigrationPayload.sol), [AaveV3EthereumPrime](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/EthereumPrimeMigrationPayload.sol), [AaveV3Ethereum_ReimburseLinkForRobot](https://github.com/bgd-labs/aave-proposals-v3/blob/f1f657065c0b6689289710fd8d2e1ceb199a8a91/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_ReimburseLinkForRobot_20251201.sol), [AaveV3Polygon](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/PolygonMigrationPayload.sol), [AaveV3Avalanche](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/AvalancheMigrationPayload.sol), [AaveV3Optimism](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/OptimismMigrationPayload.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/ArbitrumMigrationPayload.sol), [AaveV3Base](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/BaseNetworkMigrationPayload.sol), [AaveV3Gnosis](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/GnosisMigrationPayload.sol), [AaveV3BNB](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/BNBMigrationPayload.sol), [AaveV3Linea](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/LineaMigrationPayload.sol), [AaveV3Plasma](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/src/contracts/payloads/PlasmaMigrationPayload.sol)
- Tests: [BaseMigrationTest](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/BaseMigrationPayload.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/EthereumCoreMigrationPayload.t.sol), [AaveV3EthereumPrime](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/EthereumPrimeMigrationPayload.t.sol), [AaveV3Ethereum_ReimburseLinkForRobot](https://github.com/bgd-labs/aave-proposals-v3/blob/f1f657065c0b6689289710fd8d2e1ceb199a8a91/src/20251201_Multi_MigrateAutomatedRiskUpdateInfraToChaosAgents/AaveV3Ethereum_ReimburseLinkForRobot_20251201.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/PolygonMigrationPayload.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/AvalancheMigrationPayload.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/OptimismMigrationPayload.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/ArbitrumMigrationPayload.t.sol), [AaveV3Base](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/BNBMigrationPayload.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/GnosisMigrationPayload.t.sol), [AaveV3BNB](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/BNBMigrationPayload.t.sol), [AaveV3Linea](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/LineaMigrationPayload.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/chaos-agents-migration/blob/88bb6f3c4e043960f8cb42741ebe13c46c73b944/tests/payloads/PlasmaMigrationPayload.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x9795f1b7057d2780b3382b9f67f309fbfead98e7357a88df4c309dbbfefcbeb7)
- [Discussion](https://governance.aave.com/t/arfc-chaos-risk-agents/23401)
- Github: [Chaos Agents](https://github.com/ChaosLabsInc/chaos-agents), [Aave Risk Agents](https://github.com/bgd-labs/aave-agents), [Migration Payload](https://github.com/bgd-labs/chaos-agents-migration)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
