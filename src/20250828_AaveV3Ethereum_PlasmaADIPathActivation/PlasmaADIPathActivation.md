---
title: "Plasma aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/112"
---

## Simple Summary

Proposal to register the necessary Plasma adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Plasma.

## Motivation

In order to be able to pass messages from Ethereum to Plasma via a.DI (Aave Delivery Infrastructure), it is necessary to at least have three valid adapters Ethereum → Plasma smart contracts enabled in the system.

The first case of message passing Ethereum → Plasma is the activation proposal for an Aave v3 Plasma pool and consequently, to be able to execute on the Plasma side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements on previous networks like Sonic, or Celo.

## Specification

The proposal payload simply registers pre-deployed Plasma adapters (with the necessary configurations to communicate with the Plasma a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The optimal bandwidth on the Ethereum -> Plasma path is set to 2, by calling updateOptimalBandwidthByChain().

The following are the configured adapters for the Ethereum → Plasma path. The required confirmations on the path are 2 out of 3.

| Network  | Hyperlane Adapter                                                                                                      | LayerZero Adapter                                                                                                      | CCIP Adapter                                                                                                           |
| -------- | ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x6bda311748E6542d578b167d791A4130f3FbBc67](https://etherscan.io/address/0x6bda311748E6542d578b167d791A4130f3FbBc67)  | [0xBA0Ee375e9d0c815097D9eB7EB9Db20b59c06792](https://etherscan.io/address/0xBA0Ee375e9d0c815097D9eB7EB9Db20b59c06792)  | [0x352C71092fB60ce2f94DFF4ACda330DdffD946B0](https://etherscan.io/address/0x352C71092fB60ce2f94DFF4ACda330DdffD946B0)  |
| Plasma   | [0x13Dc9eBb19bb1A14aa56215b443B2703A07ba2D5](https://plasmascan.to/address/0x13Dc9eBb19bb1A14aa56215b443B2703A07ba2D5) | [0x99950E7C7eB320A8551916e8676a42b90b058d5D](https://plasmascan.to/address/0x99950E7C7eB320A8551916e8676a42b90b058d5D) | [0x719e23D7B48Fc5AEa65Cff1bc58865C2b8d89A34](https://plasmascan.to/address/0x719e23D7B48Fc5AEa65Cff1bc58865C2b8d89A34) |

The new a.DI deployments on Plasma network are as follows:

| Contract                   | Address                                                                                                                |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| CrossChainController       | [0x643441742f73e270e565619be6DE5f4D55E08cd6](https://plasmascan.to/address/0x643441742f73e270e565619be6DE5f4D55E08cd6) |
| Granular Guardian          | [0x60665b4F4FF7073C5fed2656852dCa271DfE2684](https://plasmascan.to/address/0x60665b4F4FF7073C5fed2656852dCa271DfE2684) |
| Chainlink Emergency Oracle | [0xF61FE74Ec1cFbd9Ee8Bd27592D2EDEe0E2aA85Cf](https://plasmascan.to/address/0xF61FE74Ec1cFbd9Ee8Bd27592D2EDEe0E2aA85Cf) |

The new Aave Governance deployments on Plasma network are as follows:

| Contract            | Address                                                                                                                |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0xe76EB348E65eF163d85ce282125FF5a7F5712A1d](https://plasmascan.to/address/0xe76EB348E65eF163d85ce282125FF5a7F5712A1d) |
| Executor Lvl 1      | [0x47aAdaAE1F05C978E6aBb7568d11B7F6e0FC4d6A](https://plasmascan.to/address/0x47aAdaAE1F05C978E6aBb7568d11B7F6e0FC4d6A) |
| Governance Guardian | [0x19CE4363FEA478Aa04B9EA2937cc5A2cbcD44be6](https://plasmascan.to/address/0x19CE4363FEA478Aa04B9EA2937cc5A2cbcD44be6) |
| BGD Labs Guardian   | [0xdc62E0e65b2251Dc66404ca717FD32dcC365Be3A](https://plasmascan.to/address/0xdc62E0e65b2251Dc66404ca717FD32dcC365Be3A) |

- _The Plasma [explorer](https://plasmascan.to) is still in pre-release stage, so currently the access is restricted. We expect it to be fully open in the following days_
- _[Chainlink Emergency Oracle](https://plasmascan.to/address/0xF61FE74Ec1cFbd9Ee8Bd27592D2EDEe0E2aA85Cf) implementation will be deployed by Chainlink during proposal life cycle_

## References

- Adapter Implementations: [HyperLane Bridge Adapters](https://github.com/aave-dao/aave-delivery-infrastructure/blob/d944e042703b1a1208f323ab9c7765297319c0b4/src/contracts/adapters/hyperLane/HyperLaneAdapter.sol), [LayerZero Bridge Adapters](https://github.com/aave-dao/aave-delivery-infrastructure/blob/d944e042703b1a1208f323ab9c7765297319c0b4/src/contracts/adapters/layerZero/LayerZeroAdapter.sol), [CCIP Bridge Adapters](https://github.com/aave-dao/aave-delivery-infrastructure/blob/d944e042703b1a1208f323ab9c7765297319c0b4/src/contracts/adapters/ccip/CCIPAdapter.sol)
- Payload Implementation: [Payload](https://github.com/aave-dao/adi-deploy/blob/accfe189423c7c05b83f81f229bee2974ef5653f/src/adapter_payloads/Ethereum_Plasma_Path_Payload.sol)
- Payload Tests: [tests](https://github.com/aave-dao/adi-deploy/blob/accfe189423c7c05b83f81f229bee2974ef5653f/tests/payloads/ethereum/AddPlasmaPathTest.t.sol)
- Payload Creation Script: [script](https://github.com/aave-dao/adi-deploy/blob/accfe189423c7c05b83f81f229bee2974ef5653f/scripts/payloads/adapters/ethereum/Ethereum_Activate_Plasma_Bridge_Adapter_Payload.s.sol)
- Diffs: [a.DI diffs](https://github.com/aave-dao/adi-deploy/blob/accfe189423c7c05b83f81f229bee2974ef5653f/diffs/adi_add_plasma_path_to_adiethereum_before_adi_add_plasma_path_to_adiethereum_after.md)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/112)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
