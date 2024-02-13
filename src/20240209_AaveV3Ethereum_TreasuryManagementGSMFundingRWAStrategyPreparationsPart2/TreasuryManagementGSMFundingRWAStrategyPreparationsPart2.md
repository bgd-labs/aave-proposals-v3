---
title: "Treasury Management - GSM Funding & RWA Strategy Preparations (Part 2)"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19"
---

## Simple Summary

In preparation for launching the GHO Stability Module (GSM) and the $1M RWA strategy with Centirfuge, this publication seeks to make available the necessary amount of USDC, USDT and DAI on Ethereum.

This proposal also includes the renewal of the Orbit program for recognized delegates. Compensating them with GHO and ETH reimbursement of Gas costs associated with their governance activity.

## Motivation

The GSM is expected to be available for deployment in the near future. The Centrifuge proposal is currently mid way through the review process. The current stable coin holdings on Ethereum are insufficient to support both the GSM, RWA strategy and Service Provider (SP) commitments. Additional funds are needed on Ethereum to support the GSM.

The Orbit program Snapshot and discussion can be found [here](https://snapshot.org/#/aave.eth/proposal/0x412b38c7a0cf1840b102e28ea7ef0373e3ab4b9544873e8cc1544972b777d9a1) and [here](https://governance.aave.com/t/arfc-orbit-program-renewal/16550) respectively.

The following table outlines the proposed compensation for eligible delegates matching the requirements:

|--|--|--|
|Delegate Platform|Retro-Payment (GHO)|New Stream (GHO)|
|EzR3al|5000|15000|
|Stable Labs|5000|15000|
|LBS Blockchain|5000|15000|
|Michigan|5000|15000|

In terms of gas rebate, we included Gov V2 reimbursement & payload-related activity in the following table:

|--|--|
|Delegate / Service Provider|Gas Used (ETH)|
|ACI| 3.365|
|Tokenlogic|0.586|
|Michigan|0.276|
|Wintermute|0.2518|
|LBS|0.031|
|StableLabs|0.0342|
|ezr3al|0.3833|
|Total|4.9273|

## Specification

- Swap all DAI to USDT
- Swap 0.70M USDC to USDT
- Deposit USDT into Aave v3
- Deposit USDC minus 0.70M into Aave v3

- Create GHO streams for Orbit participants of 15,000 GHO for 90 days as detailed in the table above
- Transfer GHO for Orbit participants of 5,000 as retroactive payment as detailed in the table above
- Transfer ETH to delegates/service providers as detailed in the table above

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240209_AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2/AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240209_AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2/AaveV3Ethereum_TreasuryManagementGSMFundingRWAStrategyPreparationsPart2_20240209.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb39537e468eef8c212c67a539cdc6d802cd857f186a4f66aefd44faaadd6ba19)
- [Discussion](https://governance.aave.com/t/arfc-treasury-management-gsm-funding-rwa-strategy-preparations/16128)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
