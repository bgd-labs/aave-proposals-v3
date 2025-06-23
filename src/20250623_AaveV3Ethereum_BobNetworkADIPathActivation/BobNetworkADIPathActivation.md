---
title: "Bob Network aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: TODO
snapshot: TODO
---

## Simple Summary

Proposal to register the necessary Bob adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Bob.

## Motivation

In order to be able to pass messages from Ethereum to Bob via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum → Bob smart contract enabled in the system (native adapter).

The first case of message passing Ethereum → Bob is the activation proposal for an Aave v3 Bob pool and consequently, to be able to execute on the Bob side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements on previous networks like Soneium or Base.

## Specification

The proposal payload simply registers pre-deployed Bob adapters (with the necessary configurations to communicate with the Bob a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → Bob path. The required confirmations on the path are 1 out of 1.

| Network  | Bob Native Adapter                                                                                                          |
| -------- | --------------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x1e2bFEF32EdAbf6b3EF8B674044DC00f082Addff](https://etherscan.io/address/0x1e2bFEF32EdAbf6b3EF8B674044DC00f082Addff)       |
| Bob      | [0x2171E8AD4045342AF92DdC1227ADC659f2a00535](https://explorer.gobob.xyz/address/0x2171E8AD4045342AF92DdC1227ADC659f2a00535) |

The new a.DI deployments on Bob network are as follows:

| Contract             | Address                                                                                                                     |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0xf630C8A7bC033FD20fcc45d8B43bFe92dE73154F](https://explorer.gobob.xyz/address/0xf630C8A7bC033FD20fcc45d8B43bFe92dE73154F) |
| Granular Guardian    | [0xb2C672931Bd1Da226e29997Ec8cEB60Fb1DA3959](https://explorer.gobob.xyz/address/0xb2C672931Bd1Da226e29997Ec8cEB60Fb1DA3959) |

The new Aave Governance deployments on Bob network are as follows:

| Contract            | Address                                                                                                                     |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x17fa87007bfF1dC7e6b3a36ED936E6355e37237C](https://explorer.gobob.xyz/address/0x17fa87007bfF1dC7e6b3a36ED936E6355e37237C) |
| Executor Lvl 1      | [0x90800d1F54384523723eD3962c7Cd59d7866c83d](https://explorer.gobob.xyz/address/0x90800d1F54384523723eD3962c7Cd59d7866c83d) |
| Governance Guardian | [0x19CE4363FEA478Aa04B9EA2937cc5A2cbcD44be6](https://explorer.gobob.xyz/address/0x19CE4363FEA478Aa04B9EA2937cc5A2cbcD44be6) |
| BGD Labs Guardian   | [0xdc62E0e65b2251Dc66404ca717FD32dcC365Be3A](https://explorer.gobob.xyz/address/0xdc62E0e65b2251Dc66404ca717FD32dcC365Be3A) |

## References

- Adapter Implementations: [Bob Native Adapters]()
- Payload Implementation: [Payload]()
- Payload Tests: [tests]()
- Diffs: [a.DI diffs]()
- Snapshot: Direct-to-AIP
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
