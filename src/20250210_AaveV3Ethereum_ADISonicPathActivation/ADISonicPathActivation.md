---
title: "a.DI Sonic path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/69"
---

## Simple Summary

Proposal to register the necessary Sonic adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Sonic.

## Motivation

In order to be able to pass messages from Ethereum to Sonic via a.DI (Aave Delivery Infrastructure), it is necessary to at least have three valid adapters Ethereum → Sonic smart contracts enabled in the system.

The first case of message passing Ethereum → Sonic is the activation proposal for an Aave v3 Sonic pool and consequently, to be able to execute on the Sonic side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements on previous networks like ZkSync, Linea, or Celo.

## Specification

The proposal payload simply registers pre-deployed Sonic adapters (with the necessary configurations to communicate with the Sonic a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The optimal bandwidth on the Ethereum -> Sonic path is set to 2, by calling updateOptimalBandwidthByChain().

The following are the configured adapters for the Ethereum → Sonic path. The required confirmations on the path are 2 out of 3.

| Network  | Hyperlane Adapter                                                                                                      | LayerZero Adapter                                                                                                      | CCIP Adapter                                                                                                           |
| -------- | ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1](https://etherscan.io/address/0x01dcb90Cf13b82Cde4A0BAcC655585a83Af3cCC1)  | [0x8FD7D8dd557817966181F584f2abB53549B4ABbe](https://etherscan.io/address/0x8FD7D8dd557817966181F584f2abB53549B4ABbe)  | [0xe3a0d9754aD3452D687cf580Ba3674c2D7D2f7AE](https://etherscan.io/address/0xe3a0d9754aD3452D687cf580Ba3674c2D7D2f7AE)  |
| Sonic    | [0x1098F187F5f444Bc1c77cD9beE99e8d460347F5F](https://sonicscan.org/address/0x1098F187F5f444Bc1c77cD9beE99e8d460347F5F) | [0x7B8FaC105A7a85f02C3f31559d2ee7313BDC5d7f](https://sonicscan.org/address/0x7B8FaC105A7a85f02C3f31559d2ee7313BDC5d7f) | [0x1905fCdDa41241C0871A5eC3f9dcC3E8d247261D](https://sonicscan.org/address/0x1905fCdDa41241C0871A5eC3f9dcC3E8d247261D) |

The new a.DI deployments on Sonic network are as follows:

| Contract                   | Address                                                                                                                |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| CrossChainController       | [0x58e003a3C6f2Aeed6a2a6Bc77B504566523cb15c](https://sonicscan.org/address/0x58e003a3C6f2Aeed6a2a6Bc77B504566523cb15c) |
| Granular Guardian          | [0x10078c1D8E46dd1ed5D8df2C42d5ABb969b11566](https://sonicscan.org/address/0x10078c1D8E46dd1ed5D8df2C42d5ABb969b11566) |
| Chainlink Emergency Oracle | [0xECB564e91f620fBFb59d0C4A41d7f10aDb0D1934](https://sonicscan.org/address/0xECB564e91f620fBFb59d0C4A41d7f10aDb0D1934) |

The new Aave Governance deployments on Sonic network are as follows:

| Contract            | Address                                                                                                                |
| ------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x0846C28Dd54DEA4Fd7Fb31bcc5EB81673D68c695](https://sonicscan.org/address/0x0846C28Dd54DEA4Fd7Fb31bcc5EB81673D68c695) |
| Executor Lvl 1      | [0x7b62461a3570c6AC8a9f8330421576e417B71EE7](https://sonicscan.org/address/0x7b62461a3570c6AC8a9f8330421576e417B71EE7) |
| Governance Guardian | [0x63C4422D6cc849549daeb600B7EcE52bD18fAd7f](https://sonicscan.org/address/0x63C4422D6cc849549daeb600B7EcE52bD18fAd7f) |
| BGD Labs Guardian   | [0x7837d7a167732aE41627A3B829871d9e32e2e7f2](https://sonicscan.org/address/0x7837d7a167732aE41627A3B829871d9e32e2e7f2) |

## References

- Adapter Implementations: [HyperLane Bridge Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/9a79f7986b5442657f64e41a0ab089e0cdb71e98/src/contracts/adapters/hyperLane/HyperLaneAdapter.sol), [LayerZero Bridge Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/9a79f7986b5442657f64e41a0ab089e0cdb71e98/src/contracts/adapters/layerZero/LayerZeroAdapter.sol), [CCIP Bridge Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/9a79f7986b5442657f64e41a0ab089e0cdb71e98/src/contracts/adapters/ccip/CCIPAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy/blob/09dae97164429e0986f07204a4110015a3f6c741/src/adapter_payloads/Ethereum_Sonic_Path_Payload.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy/blob/09dae97164429e0986f07204a4110015a3f6c741/tests/payloads/ethereum/AddSonicPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy/blob/09dae97164429e0986f07204a4110015a3f6c741/diffs/adi_add_sonic_path_to_adiethereum_before_adi_add_sonic_path_to_adiethereum_after.md)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/69)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
