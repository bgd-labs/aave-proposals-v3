---
title: "GHO Steward v2 Upgrade"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xc5e7df1536ef9fc71a7d2e2f6fee6e4e20e37a50b4e0f1646616d066b8697da5"
---

## Simple Summary

This publication proposes upgrading the GHO Steward Role to incorporate additional functionality to accomodate the current and future growth of GHO.

## Motivation

In response to the expanding GHO ecosystem, GhoSteward v2 incorporates several different stewards to avoid the need to redeploy the entire steward contract whenever an upgrade or change is proposed.

- GhoBucketSteward
- GhoAaveSteward
- GhoCcipSteward
- GhoGsmSteward

Any future change to the GHO Steward functionality will require only the corresponding steward to be updated. This reduces the complexity and streamlines future amendments to the GHO Steward role.

In addition, some new features have been added to allow for controlling parameters related to CCIP.

## Specification

The following contracts must be granted these roles by the DAO:

- GhoAaveSteward
  1. RiskAdmin in Aave V3 Ethereum Pool
- GhoBucketSteward (both on Ethereum and Arbitrum)
  1. GhoTokenBucketManagerRole on GhoToken
- GhoCcipSteward
  1. RateLimitAdmin and BridgeLimitAdmin roles on GhoTokenPool (just rateLimitAdmin on Arbitrum)
- GhoGsmSteward
  1. Configurator in every GSM asset that the DAO wants the risk council to manage

To facilitate the CCIP Steward, a new CCIP token pool implementation will be implemented on Arbitrum to allow setting of rateLimitAdmin.

List of new addresses:

| Contract            | Arbitrum                                   | Ethereum                                   |
| ------------------- | ------------------------------------------ | ------------------------------------------ |
| New CCIP Token Pool | 0xb78eDA33EB5493d56f14a81023CE69438a562A2c |                                            |
| Gho Bucket Steward  | 0xa9afaE6A53E90f9E4CE0717162DF5Bc3d9aBe7B2 | 0x46Aa1063e5265b43663E81329333B47c517A5409 |
| Gho Aave Steward    | 0xCd04D93bEA13921DaD05240D577090b5AC36DfCA | 0xFEb4e54591660F42288312AE8eB59e9f2B746b66 |
| Gho CCIP Steward    | 0xb329CEFF2c362F315900d245eC88afd24C4949D5 | 0x101Efb7b9Beb073B1219Cd5473a7C8A2f2EB84f4 |
| Gho GSM Steward     |                                            | 0xD1E856a947CdF56b4f000ee29d34F5808E0A6848 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/603758edd1814e074b1c7a08c7da140df4338351/src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Ethereum_GHOStewardV2Upgrade_20241007.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/603758edd1814e074b1c7a08c7da140df4338351/src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/603758edd1814e074b1c7a08c7da140df4338351/src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Ethereum_GHOStewardV2Upgrade_20241007.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/603758edd1814e074b1c7a08c7da140df4338351/src/20241007_Multi_GHOStewardV2Upgrade/AaveV3Arbitrum_GHOStewardV2Upgrade_20241007.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc5e7df1536ef9fc71a7d2e2f6fee6e4e20e37a50b4e0f1646616d066b8697da5)
- [Discussion](https://governance.aave.com/t/arfc-gho-steward-v2-upgrade/19116)
- The GHO Stewards implementations can be found [here](https://github.com/aave/gho-core/tree/main/src/contracts/misc)
- The original PR introducing the Stewards to GHO-CORE can be found [here](https://github.com/aave/gho-core/pull/414/files)
- The Certora review of the Stewards can be found [here](https://github.com/aave/gho-core/pull/423)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
