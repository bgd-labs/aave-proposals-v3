---
title: "Activate Gho Stewards"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956"
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
- GSM Fee Strategy

GHO Stewards consists of members from Growth (ACI), Risk (ChaosLabs) and Finance (TokenLogic + Karpatkey) Service Providers and utilize a 3 of 4 multi-sig.

## Specification

The proposal gives the following admin roles:

- Grant GHO Steward the Pool Admin role via the [ACL_MANAGER](https://etherscan.io/address/0xc2aaCf6553D20d1e9d78E365AAba8032af9c85b0) contract.
- Grant GHO Steward the Bucket Manager role on the [GHO token](https://etherscan.io/address/0x40D16FC0246aD3160Ccc09B8D0D3A2cD28aE6C2f).
- Grant GHO Steward the Configurator role on [GSM_USDC](https://etherscan.io/address/0x0d8eFfC11dF3F229AA1EA0509BC9DFa632A13578) and [GSM_USDT](https://etherscan.io/address/0x686F8D21520f4ecEc7ba577be08354F4d1EB8262).
- Whitelists all the facilitators on the GHO Stewards, including: [GHO_AToken](https://etherscan.io/address/0x00907f9921424583e7ffBfEdf84F92B7B2Be4977), [GHO_FlashMinter](https://etherscan.io/address/0xb639D208Bcf0589D54FaC24E655C79EC529762B8), [GSM_USDC](https://etherscan.io/address/0x0d8eFfC11dF3F229AA1EA0509BC9DFa632A13578), [GSM_USDT](https://etherscan.io/address/0x686F8D21520f4ecEc7ba577be08354F4d1EB8262) - so that the steward has the permissions to update the bucket capacity.

The GHO Stewards parameters are set as follow:

- GHO Aave Bucket Capacity: 100% increase
- GHO Borrow Rate: 5% change
- GSM Exposure Cap: 100% increase
- GSM Bucket Capacity: 100% increase
- GHO Borrow Cap: 100% increase
- GSM Fee Strategy: +0.5%

## References

- GHO Steward SAFE address: [0x8513e6F37dBc52De87b166980Fa3F50639694B60](https://etherscan.io/address/0x8513e6F37dBc52De87b166980Fa3F50639694B60)
- GHO Steward V2 address: [0x8F2411a538381aae2b464499005F0211e867d84f](https://etherscan.io/address/0x8F2411a538381aae2b464499005F0211e867d84f)
- GHO Steward Repo: [GhoStewardV2.sol](https://github.com/aave/gho-core/blob/f02f87482de7ccbd30ba76b40939fb016dbb2fea/src/contracts/misc/GhoStewardV2.sol)
- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240326_AaveV3Ethereum_ActivateGhoStewards/AaveV3Ethereum_ActivateGhoStewards_20240326.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240326_AaveV3Ethereum_ActivateGhoStewards/AaveV3Ethereum_ActivateGhoStewards_20240326.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x29f63b24638ee822f88632572ca4b061774771c0cc6d0ae5ccdeb538177232cd)
- [Discussion](https://governance.aave.com/t/arfc-gho-stewards-borrow-rate-update/16956)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
