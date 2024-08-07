---
title: "a.DI ZkSync path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/40"
---

## Simple Summary

Proposal to register the necessary ZKSync adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 ZKSync.

## Motivation

In order to be able to pass messages from Ethereum to ZKSync via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum → ZKSync smart contract enabled in the system.

The first case of message passing Ethereum → ZKSync is the activation proposal for an Aave v3 ZKSync pool and consequently, to be able to execute on the ZKSync side the payload, the Aave governance should approve in advance the a.DI adapter smart contract.

This procedure mirrors the requirements on previous networks like Scroll.

## Specification

The proposal payload simply registers a pre-deployed ZKSync adapter (with the necessary configurations to communicate with the ZKSync a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

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

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/fac71a7a436feaea5a2b01021fa40286fc8bb58e/src/20240726_AaveV3Ethereum_ADIZkSyncPathActivation/AaveV3Ethereum_ADIZkSyncPathActivation_20240726.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/fac71a7a436feaea5a2b01021fa40286fc8bb58e/src/20240726_AaveV3Ethereum_ADIZkSyncPathActivation/AaveV3Ethereum_ADIZkSyncPathActivation_20240726.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/40)
- [Tests](https://github.com/bgd-labs/adi-deploy/blob/0362a18614325de76fa1ab4b9ae5c3172d382ec6/tests/payloads/zksync/AddZkSyncPathTest.t.sol)
- [Diffs](https://github.com/bgd-labs/adi-deploy/blob/06de05532d37a480b008fc70a4f2569c4a812161/diffs/adi_add_zksync_path_to_adiethereum_before_adi_add_zksync_path_to_adiethereum_after.md)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
