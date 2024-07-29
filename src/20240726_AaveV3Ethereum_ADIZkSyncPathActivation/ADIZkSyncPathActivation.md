---
title: "a.DI ZkSync path activation"
author: "BGD Labs @bgdlabs"
discussions: ""
---

## Simple Summary

This AIP activates the path Ethereum -> ZkSync on a.DI

## Motivation

By activating the path Ethereum -> ZkSync on a.DI, we are enabling Aave Governance to activate and control (in a future AIP) the new
Aave V3 market on ZkSync.

## Specification

The AIP adds the ZkSync adapter on Ethereum, and enables it for communication with ZkSync network with id 324, and pairs it with
the ZkSync adapter on ZkSync network so that messages are sent there.

| Network  | ZkSync Adapter                                                                                                              |
| -------- | --------------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x6aD9d4147467f08b165e1b6364584C5d28898b84](https://etherscan.io/address/0x6aD9d4147467f08b165e1b6364584C5d28898b84)       |
| ZkSync   | [0x1BC5C10CAe378fDbd7D52ec4F9f34590a619c68E](https://era.zksync.network/address/0x1BC5C10CAe378fDbd7D52ec4F9f34590a619c68E) |

The new a.DI deployments on ZkSync network are as follows:

| Contract             | Address                                                                                                                     |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0x800813f4714BC7A0a95310e3fB9e4f18872CA92C](https://era.zksync.network/address/0x800813f4714BC7A0a95310e3fB9e4f18872CA92C) |
| Granular Guardian    | [0xe0e23196D42b54F262a3DE952e6B34B197D1A228](https://era.zksync.network/address/0xe0e23196D42b54F262a3DE952e6B34B197D1A228) |

The new Aave Governance deployments on ZkSync network are as follows:

| Contract            | Address                                                                                                                     |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x2E79349c3F5e4751E87b966812C9E65E805996F1](https://era.zksync.network/address/0x2E79349c3F5e4751E87b966812C9E65E805996F1) |
| Executor Lvl 1      | [0x04cE39789e11a49595cD0ECEf6f4Bd54ABF4d020](https://era.zksync.network/address/0x04cE39789e11a49595cD0ECEf6f4Bd54ABF4d020) |
| Governance Guardian | [0x4257bf0746D783f0D962913d7d8AFA408B62547E](https://era.zksync.network/address/0x4257bf0746D783f0D962913d7d8AFA408B62547E) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_AaveV3Ethereum_ADIZkSyncPathActivation/AaveV3Ethereum_ADIZkSyncPathActivation_20240726.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240726_AaveV3Ethereum_ADIZkSyncPathActivation/AaveV3Ethereum_ADIZkSyncPathActivation_20240726.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)
- [Tests](TODO)
- [Diffs](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
