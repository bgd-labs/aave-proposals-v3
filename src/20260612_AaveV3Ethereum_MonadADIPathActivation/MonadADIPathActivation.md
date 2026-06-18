---
title: "Monad aDI path activation"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/130"
---

## Simple Summary

Proposal to register the necessary Monad adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Monad.

## Motivation

In order to be able to pass messages from Ethereum to Monad via a.DI (Aave Delivery Infrastructure), it is necessary to have at least one valid adapter Ethereum → Monad smart contract enabled in the system.

The first case of message passing Ethereum → Monad is the activation proposal for an Aave V3 Monad pool, and consequently, to be able to execute on the Monad side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

## Specification

The proposal payload simply registers pre-deployed Monad adapters (with the necessary configurations to communicate with the Monad a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → Monad path. The required confirmations on the path are 2 out of 3.

| Adapter   | Ethereum                                                                                                              | Monad                                                                                                                  |
| --------- | --------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| CCIP      | [0x7c28CEb47b49cFAC40e718dD407e4249F9C891F6](https://etherscan.io/address/0x7c28CEb47b49cFAC40e718dD407e4249F9C891F6) | [0x7Cd4245433185A08084E9cf80300682397F733AC](https://monadscan.com/address/0x7Cd4245433185A08084E9cf80300682397F733AC) |
| Hyperlane | [0x6bda311748E6542d578b167d791A4130f3FbBc67](https://etherscan.io/address/0x6bda311748E6542d578b167d791A4130f3FbBc67) | [0xb8F8aFdB7f1F4Ca9D842adFF86d052cb0C9f20CA](https://monadscan.com/address/0xb8F8aFdB7f1F4Ca9D842adFF86d052cb0C9f20CA) |
| LayerZero | [0xf9482751C9937fF940b93B5921B8984645dD0a53](https://etherscan.io/address/0xf9482751C9937fF940b93B5921B8984645dD0a53) | [0xb544322f8e59B71d7875e0E2EbceB7f3783257BE](https://monadscan.com/address/0xb544322f8e59B71d7875e0E2EbceB7f3783257BE) |

The new a.DI deployments on Monad network are as follows:

| Contract             | Address                                                                                                                |
| -------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0x8dd5b84b26ae3916A5Fb34C8968F93d206216b63](https://monadscan.com/address/0x8dd5b84b26ae3916A5Fb34C8968F93d206216b63) |
| Granular Guardian    | [0xD3DD0bE957fcE2dCd359e09374Cbc99f60337D42](https://monadscan.com/address/0xD3DD0bE957fcE2dCd359e09374Cbc99f60337D42) |

The new Aave Governance deployments on Monad network are as follows:

| Contract            | Address                                                                                                                |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x442CA936e5E6Db875357d0A16481145c96dd9a82](https://monadscan.com/address/0x442CA936e5E6Db875357d0A16481145c96dd9a82) |
| Executor Lvl 1      | [0xa9d0EAFF48cE1DF468f9eAeb7e628c413343F6A2](https://monadscan.com/address/0xa9d0EAFF48cE1DF468f9eAeb7e628c413343F6A2) |
| Governance Guardian | [0x056E4C4E80D1D14a637ccbD0412CDAAEc5B51F4E](https://monadscan.com/address/0x056E4C4E80D1D14a637ccbD0412CDAAEc5B51F4E) |
| Aave Labs Guardian  | [0x2B99790c35a401be873FA7Eb514D9220736BB1cA](https://monadscan.com/address/0x2B99790c35a401be873FA7Eb514D9220736BB1cA) |

The Protocol Guardian on Monad is as follows:

| Contract          | Address                                                                                                                |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Protocol Guardian | [0xc887455536CBD4e615B745e70CaCde15B3117e74](https://monadscan.com/address/0xc887455536CBD4e615B745e70CaCde15B3117e74) |

## References

- Adapter Implementation:
  - [CCIPAdapter](https://github.com/aave-dao/aave-delivery-infrastructure/blob/e4e2500c58fa1eeaa3ffd8f352bdc55c576c1148/src/contracts/adapters/ccip/CCIPAdapter.sol)
  - [HyperLaneAdapter](https://github.com/aave-dao/aave-delivery-infrastructure/blob/e4e2500c58fa1eeaa3ffd8f352bdc55c576c1148/src/contracts/adapters/hyperLane/HyperLaneAdapter.sol)
  - [LayerZeroAdapter](https://github.com/aave-dao/aave-delivery-infrastructure/blob/e4e2500c58fa1eeaa3ffd8f352bdc55c576c1148/src/contracts/adapters/layerZero/LayerZeroAdapter.sol)
- Payload Implementation: [Payload](https://github.com/aave-dao/adi-deploy/blob/aa9e8053b422f63ea6abf2d15802d6e363ff57c0/scripts/payloads/adapters/ethereum/Ethereum_Activate_Monad_Bridge_Adapter_Payload.s.sol)
- Payload Tests: [tests](https://github.com/aave-dao/adi-deploy/blob/aa9e8053b422f63ea6abf2d15802d6e363ff57c0/tests/payloads/ethereum/AddMonadPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/aave-dao/adi-deploy/blob/aa9e8053b422f63ea6abf2d15802d6e363ff57c0/diffs/adi_add_monad_path_to_adiethereum_before_adi_add_monad_path_to_adiethereum_after.md)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/130)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
