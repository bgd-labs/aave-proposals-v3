---
title: "X Layer network aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: TODO
snapshot: TODO
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

| Network  | XLayer Native Adapter                       |
| -------- | ------------------------------------------- |
| Ethereum | [](https://etherscan.io/address/)           |
| XLayer   | [](https://www.oklink.com/x-layer/address/) |

The new a.DI deployments on XLayer network are as follows:

| Contract             | Address                                     |
| -------------------- | ------------------------------------------- |
| CrossChainController | [](https://www.oklink.com/x-layer/address/) |
| Granular Guardian    | [](https://www.oklink.com/x-layer/address/) |

The new Aave Governance deployments on XLayer network are as follows:

| Contract            | Address                                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [](https://www.oklink.com/x-layer/address/)                                                                                     |
| Executor Lvl 1      | [](https://www.oklink.com/x-layer/address/)                                                                                     |
| Governance Guardian | [0xeB55A63bf9993d80c86D47f819B5eC958c7C127B](https://www.oklink.com/x-layer/address/0xeB55A63bf9993d80c86D47f819B5eC958c7C127B) |
| BGD Labs Guardian   | [0x734c3ff8de95c3745770df69053a31fdc92f2526](https://www.oklink.com/x-layer/address/0x734c3ff8de95c3745770df69053a31fdc92f2526) |

## References

- Adapter Implementations: [XLayer Native Adapters]()
- Payload Implementation: [Payload]()
- Payload Tests: [tests]()
- Diffs: [a.DI diffs]()
- [Discussion]()

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
