---
title: "X Layer network aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/120"
---

## Simple Summary

Proposal to register the necessary XLayer adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 XLayer.

## Motivation

In order to be able to pass messages from Ethereum to XLayer via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum → XLayer smart contract enabled in the system (native adapter).

The first case of message passing Ethereum → XLayer is the activation proposal for an Aave v3 XLayer pool and consequently, to be able to execute on the XLayer side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

## Specification

The proposal payload simply registers pre-deployed XLayer adapters (with the necessary configurations to communicate with the XLayer a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → XLayer path. The required confirmations on the path are 1 out of 1.

| Network  | XLayer Native Adapter                                                                                                           |
| -------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x9fD570da8fFe3384F1093833D44072ea79ABdEB0](https://etherscan.io/address/0x9fD570da8fFe3384F1093833D44072ea79ABdEB0)           |
| XLayer   | [0xEbc2c80073E4752e9A1D2e9A9bC98e8F4EeE9Be9](https://www.oklink.com/x-layer/address/0xEbc2c80073E4752e9A1D2e9A9bC98e8F4EeE9Be9) |

The new a.DI deployments on XLayer network are as follows:

| Contract             | Address                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0xFdd46155fD3DA5B907AD3B9f9395366290f58097](https://www.oklink.com/x-layer/address/0xFdd46155fD3DA5B907AD3B9f9395366290f58097) |
| Granular Guardian    | [0xD6727ec503A8d0C10a0EAA4e76eAf9A628188b25](https://www.oklink.com/x-layer/address/0xD6727ec503A8d0C10a0EAA4e76eAf9A628188b25) |

The new Aave Governance deployments on XLayer network are as follows:

| Contract            | Address                                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x80e11cB895a23C901a990239E5534054C66476B5](https://www.oklink.com/x-layer/address/0x80e11cB895a23C901a990239E5534054C66476B5) |
| Executor Lvl 1      | [0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19](https://www.oklink.com/x-layer/address/0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19) |
| Governance Guardian | [0xeB55A63bf9993d80c86D47f819B5eC958c7C127B](https://www.oklink.com/x-layer/address/0xeB55A63bf9993d80c86D47f819B5eC958c7C127B) |
| BGD Labs Guardian   | [0x734c3fF8DE95c3745770df69053A31FDC92F2526](https://www.oklink.com/x-layer/address/0x734c3ff8de95c3745770df69053a31fdc92f2526) |

## References

- Adapter Implementations: [XLayer Native Adapters](https://github.com/aave-dao/aave-delivery-infrastructure/blob/3d430b0441eab83f5825501077e8a02227d31634/src/contracts/adapters/xLayer/xLayerAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy-bgd-fork/blob/8852ea9fe8909446c2a0a35d46b816e7e88877f1/scripts/payloads/adapters/ethereum/Ethereum_Activate_XLayer_Bridge_Adapter_Payload.s.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy-bgd-fork/blob/8852ea9fe8909446c2a0a35d46b816e7e88877f1/tests/payloads/ethereum/AddXLayerPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy-bgd-fork/blob/8852ea9fe8909446c2a0a35d46b816e7e88877f1/diffs/adi_add_xlayer_path_to_adiethereum_before_adi_add_xlayer_path_to_adiethereum_after.md)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/120)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
