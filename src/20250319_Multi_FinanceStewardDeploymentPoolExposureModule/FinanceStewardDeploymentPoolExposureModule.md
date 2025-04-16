---
title: "Finance Steward Deployment: Pool Exposure Module"
author: "@TokenLogic"
discussions: https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495
snapshot: https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d
---

## Simple Summary

This publication details the initial configuration of the [Aave Finance Steward](https://governance.aave.com/t/arfc-aave-finance-steward/17570/1) PoolExposure module.

The Finance Steward role is comprised of a set of Modules (Smart Contracts) that provide approved signers with the ability to perform DAO approved actions such as swapping tokens or migrating assets from Aave V2 to Aave V3.

## Motivation

The Finance Steward modules enables the DAO to define a core set of financial capabilities to be carried out within strict role-based guardrails. As the role matures or new use cases arise, we plan to bring forward additional capabilities for the DAO to discuss.

The initial set up of the Finance Steward includes deploying two separate modules (smart contracts), the PoolExposureSteward and the MainnetSwapSteward, this publication deploys the PoolExposureSteward smart contract across various chains.

### PoolExposureModule

#### Features

The PoolExposureModule is granted permission to facilitate the following routine operational tasks:

_Migrations_

- Withdraw assets from Aave V2 and deposit into Aave V3.
- Withdraw assets from a given Aave V3 pool and deposit into another Aave V3 pool (ie: Core to Prime).

_Deposit Passive Assets_

- Deposit idle Collector funds into Aave V3.

_Withdraw Assets_

- Withdraw funds from Aave V2 or Aave V3 into the Collector.
  These funds can then be used for runway or to perform swaps where applicable.

## Specification

The PoolExposureSteward contracts have been deployed, across all chains, with the DAO as the owner of the contracts and the following SAFE acting as the guardian [0x22740deBa78d5a0c24C58C740e3715ec29de1bFa](https://app.safe.global/home?safe=eth:0x22740deBa78d5a0c24C58C740e3715ec29de1bFa).

The SAFE is configured as a 3-out-of-4 multi-sig, and the signers for the SAFE are the following:

Marc (AaveChan) - `0x329c54289Ff5D6B7b7daE13592C6B1EDA1543eD4`
Matt (TokenLogic) - `0xb647055A9915bF9c8021a684E175A353525b9890`
Chaos Labs - `0x5d49dBcdd300aECc2C311cFB56593E71c445d60d`
Val (LlamaRisk) - `0xbA037E4746ff58c55dc8F27a328C428F258DDACb`

The PoolExposureModule will be deployed on the following chains, with the listed pools approved for interaction.

| Network   | Pools                         |
| --------- | ----------------------------- |
| Mainnet   | V2, AMM V2, V3 Core, V3 Prime |
| Polygon   | V2, V3                        |
| Avalanche | V2, V3                        |
| Optimism  | V3                            |
| Arbitrum  | V3                            |
| Scroll    | V3                            |
| Base      | V3                            |
| BNB       | V3                            |
| Gnosis    | V3                            |
| Sonic     | V3                            |
| Linea     | V3                            |

For each pool, ~$100 worth of each reserve will be sent to the DustBinSteward contract. The DustBin is a special contract that, as the name implies, holds a dust amount of tokens. This is done to ensure that the pools are never emptied and the PoolExposure module can operate without having to worry about possibly emptying a given reserve.

If the corresponding DustBin for a specific reserve holds about ~$100 worth of the token, then that token will not be transferred. If the DustBin does not yet have that token, the mentioned amount will be sent alongside this proposal.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Avalanche_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Ethereum_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3EthereumLido_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Polygon_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Avalanche_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Optimism_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Arbitrum_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Base_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Scroll_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3BNB_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Linea_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/28abacb4b3002a4801b8f2336ab49cbdc5853e08/src/20250319_Multi_FinanceStewardDeploymentPoolExposureModule/AaveV3Sonic_FinanceStewardDeploymentPoolExposureModule_20250319.t.sol)
  [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x1730ba3a2dd1f7b0b00cfae01b0c9f1bb7494b848c5de517275e2c72cf8c7b4d)
- [Discussion](https://governance.aave.com/t/arfc-aave-finance-steward-deployment/21495)
- PoolSteward Code and Review: [PoolSteward](https://github.com/bgd-labs/aave-stewards/blob/52bb008fffda95c0afc72d28560fe89625df07a4/src/finance/PoolExposureSteward.sol), [PoolStewardTests](https://github.com/bgd-labs/aave-stewards/blob/52bb008fffda95c0afc72d28560fe89625df07a4/tests/finance/PoolExposureSteward.t.sol), [CertoraReport](https://github.com/bgd-labs/aave-stewards/blob/main/audits/2025_02_16_PoolExposureSteward_Certora.pdf)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
