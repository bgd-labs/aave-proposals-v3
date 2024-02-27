---
title: "Treasury Management - GSM Funding & RWA Strategy Preparations (Part 2)"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19"
---

## Simple Summary

In preparation for potentially funding the GHO Stability Module (GSM) and the $1M RWA strategy with Centrifuge, this publication seeks to make available the necessary amount of USDC, USDT and DAI on Ethereum.

## Motivation

The GSM was deployed in a previous proposal and the current stable coin holdings on Ethereum are insufficient to support both the GSM, RWA strategy and Service Provider (SP) commitments. Additional funds are needed on Ethereum to support the GSM.

## Specification

- Swap all DAI to USDT
- Swap 0.70M USDC to USDT
- Deposit USDT into Aave v3
- Deposit USDC minus 0.70M into Aave v3

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/312f7338478da05b55b2104434002762238df0d3/src/20240209_AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2/AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/312f7338478da05b55b2104434002762238df0d3/src/20240209_AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2/AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
