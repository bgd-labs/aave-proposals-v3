---
title: "Activate Gho Stewards"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-gho-stewards/16466"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x29f63b24638ee822f88632572ca4b061774771c0cc6d0ae5ccdeb538177232cd"
---

## Simple Summary

This proposal activates GHO steward V2 for the Aave DAO, allowing better management of the GHO stablecoin by Risk, Growth & Finance Aave DAO service providers

## Motivation

This publication proposes to creating the GHO Stewards and granting the GHO Stewards permission to adjust the following parameters:

- GHO Borrow Cap
- GHO Borrow Rate
- GSM Exposure Cap
- GSM Bucket Capacity
- GSM Price Strategy
- GSM Fee Strategy
- GSM Price Range (Freeze, Unfreeze)

GHO Stewards consists of members from Growth (ACI), Risk (ChaosLabs and Gauntlet) and Finance (TokenLogic + Karpatkey) Service Providers and utilize a 3 of 4 multi-sig.

## Specification

// add more specification regarding admin roles given

The GHO Stewards parameters are set as follow:

- GHO Aave Bucket Capacity: 100% increase
- GHO Borrow Rate: 0.5% change
- GSM Exposure Cap: 100% increase
- GSM Bucket Capacity: 100% increase
- GHO Borrow Cap: 100% increase
- GSM Price Strategy: TODO
- GSM Fee Strategy: + 0.5%
- GSM Price Range (Freeze, Unfreeze)

## References

- GHO Steward SAFE address: [0x8513e6F37dBc52De87b166980Fa3F50639694B60](https://etherscan.io/address/0x8513e6F37dBc52De87b166980Fa3F50639694B60)
- GHO Steward V2 address: [0x8F2411a538381aae2b464499005F0211e867d84f](https://etherscan.io/address/0x8F2411a538381aae2b464499005F0211e867d84f)
- GHO Steward Repo: [GhoStewardV2.sol](https://github.com/aave/gho-core/blob/f02f87482de7ccbd30ba76b40939fb016dbb2fea/src/contracts/misc/GhoStewardV2.sol)
- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240326_AaveV3Ethereum_ActivateGhoStewards/AaveV3Ethereum_ActivateGhoStewards_20240326.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240326_AaveV3Ethereum_ActivateGhoStewards/AaveV3Ethereum_ActivateGhoStewards_20240326.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x29f63b24638ee822f88632572ca4b061774771c0cc6d0ae5ccdeb538177232cd)
- [Discussion](https://governance.aave.com/t/arfc-gho-stewards/16466)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
