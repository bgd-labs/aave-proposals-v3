---
title: "a.DI Celo path activation"
author: "BGD Labs @bgdlabs"
discussions: https://governance.aave.com/t/technical-maintenance-proposals/15274/61
snapshot: Direct-to-AIP
---

## Simple Summary

Proposal to register the necessary Celo adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Celo.

## Motivation

In order to be able to pass messages from Ethereum to Celo via a.DI (Aave Delivery Infrastructure), it is necessary to at least have three valid adapters Ethereum → Celo smart contracts enabled in the system.

The first case of message passing Ethereum → Celo is the activation proposal for an Aave v3 Celo pool and consequently, to be able to execute on the Celo side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements on previous networks like Scroll or ZkSync.

## Specification

The proposal payload simply registers pre-deployed Celo adapters (with the necessary configurations to communicate with the Celo a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

| Network  | Hyperlane Adapter                                                                                                     | LayerZero Adapter                                                                                                     | CCIP Adapter                                                                                                          |
| -------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1](https://etherscan.io/address/0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1) | [0x8410d9BD353b420ebA8C48ff1B0518426C280FCC](https://etherscan.io/address/0x8410d9BD353b420ebA8C48ff1B0518426C280FCC) | [0x58489B249BfBCF5ef4B30bdE2792086e83122B6f](https://etherscan.io/address/0x58489B249BfBCF5ef4B30bdE2792086e83122B6f) |
| Celo     | [0x7b065E68E70f346B18636Ab86779980287ec73e0](https://celoscan.io/address/0x7b065E68E70f346B18636Ab86779980287ec73e0)  | [0x83BC62fbeA15B7Bfe11e8eEE57997afA5451f38C](https://celoscan.io/address/0x83BC62fbeA15B7Bfe11e8eEE57997afA5451f38C)  | [0x3d534E8964e7aAcfc702751cc9A2BB6A9fe7d928](https://celoscan.io/address/0x3d534E8964e7aAcfc702751cc9A2BB6A9fe7d928)  |

The new a.DI deployments on Linea network are as follows:

| Contract                   | Address                                                                                                              |
| -------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| CrossChainController       | [0x50F4dAA86F3c747ce15C3C38bD0383200B61d6Dd](https://celoscan.io/address/0x50F4dAA86F3c747ce15C3C38bD0383200B61d6Dd) |
| Granular Guardian          | [0xbE815420A63A413BB8D508d8022C0FF150Ea7C39](https://celoscan.io/address/0xbE815420A63A413BB8D508d8022C0FF150Ea7C39) |
| Chainlink Emergency Oracle | [0x91b21900E91CD302EBeD05E45D8f270ddAED944d](https://celoscan.io/address/0x91b21900E91CD302EBeD05E45D8f270ddAED944d) |

The new Aave Governance deployments on Linea network are as follows:

| Contract            | Address                                                                                                              |
| ------------------- | -------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0xE48E10834C04E394A04BF22a565D063D40b9FA42](https://celoscan.io/address/0xE48E10834C04E394A04BF22a565D063D40b9FA42) |
| Executor Lvl 1      | [0x1dF462e2712496373A347f8ad10802a5E95f053D](https://celoscan.io/address/0x1dF462e2712496373A347f8ad10802a5E95f053D) |
| Governance Guardian | [0x056E4C4E80D1D14a637ccbD0412CDAAEc5B51F4E](https://celoscan.io/address/0x056E4C4E80D1D14a637ccbD0412CDAAEc5B51F4E) |
| BGD Labs Guardian   | [0xfD3a6E65e470a7D7D730FFD5D36a9354E8F9F4Ea](https://celoscan.io/address/0xfD3a6E65e470a7D7D730FFD5D36a9354E8F9F4Ea) |

## References

- Adapter Implementations: [HyperLane Bridge Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/1f1c46af4dd914847849cad4fdd2d26525278821/src/contracts/adapters/hyperLane/HyperLaneAdapter.sol), [LayerZero Bridge Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/1f1c46af4dd914847849cad4fdd2d26525278821/src/contracts/adapters/layerZero/LayerZeroAdapter.sol), [CCIP Bridge Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/1f1c46af4dd914847849cad4fdd2d26525278821/src/contracts/adapters/ccip/CCIPAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy/blob/06785fcb243f179425671691099df927876baeb0/src/adapter_payloads/Ethereum_Celo_Path_Payload.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy/blob/06785fcb243f179425671691099df927876baeb0/tests/payloads/ethereum/AddCeloPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy/blob/06785fcb243f179425671691099df927876baeb0/diffs/adi_add_celo_path_to_adiethereum_before_adi_add_celo_path_to_adiethereum_after.md)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/61)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
