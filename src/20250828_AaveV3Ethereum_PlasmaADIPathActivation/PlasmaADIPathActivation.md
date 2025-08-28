---
title: "Plasma aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: TODO
snapshot: TODO
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

| Network  | Hyperlane Adapter                  | LayerZero Adapter                  | CCIP Adapter                       |
| -------- | ---------------------------------- | ---------------------------------- | ---------------------------------- |
| Ethereum | [](https://etherscan.io/address/)  | [](https://etherscan.io/address/)  | [](https://etherscan.io/address/)  |
| Plasma   | [](https://plasmascan.to/address/) | [](https://plasmascan.to/address/) | [](https://plasmascan.to/address/) |

The new a.DI deployments on Plasma network are as follows:

| Contract                   | Address                            |
| -------------------------- | ---------------------------------- |
| CrossChainController       | [](https://plasmascan.to/address/) |
| Granular Guardian          | [](https://plasmascan.to/address/) |
| Chainlink Emergency Oracle | [](https://plasmascan.to/address/) |

The new Aave Governance deployments on Plasma network are as follows:

| Contract            | Address                            |
| ------------------- | ---------------------------------- |
| PayloadsController  | [](https://plasmascan.to/address/) |
| Executor Lvl 1      | [](https://plasmascan.to/address/) |
| Governance Guardian | [](https://plasmascan.to/address/) |
| BGD Labs Guardian   | [](https://plasmascan.to/address/) |

## References

- Adapter Implementations: [HyperLane Bridge Adapters](), [LayerZero Bridge Adapters](), [CCIP Bridge Adapters]()
- Payload Implementation: [Payload]()
- Payload Tests: [tests]()
- Diffs: [a.DI diffs]()
- Snapshot: Direct-to-AIP
- [Discussion]()

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
