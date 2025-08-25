---
title: "Ink aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/108"
---

## Simple Summary

Proposal to register the necessary Ink adapters on a.DI, a technical pre-requirement to have Aave Governance-controlled contracts on Ink, in this case, cross-chain GHO-related to be listed on the Aave <> Ink friendly fork.

## Motivation

In order to be able to pass messages from Ethereum to Ink via a.DI (Aave Delivery Infrastructure), it is necessary to at least have three valid adapters Ethereum → Ink smart contracts enabled in the system.

The first case of message passing Ethereum → Ink is the proposal for GHO CCIP configuration on Ink, and consequently, to be able to execute on the Ink side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements of previous networks like Base or Optimism.

## Specification

The proposal payload simply registers pre-deployed Ink adapters (with the necessary configurations to communicate with the Ink a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → Ink path. The required confirmations on the path are 1 out of 1.

| Network  | Ink Native Adapter                                                                                                          |
| -------- | --------------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0x98E78C2cD3013BF13a658E210e27C3732c8Dc48A](https://etherscan.io/address/0x98E78C2cD3013BF13a658E210e27C3732c8Dc48A)       |
| Ink      | [0xC2cD4F76B7a77AEaE3C04A9B6B105EC1Ad28e984](https://57073.routescan.io/address/0xC2cD4F76B7a77AEaE3C04A9B6B105EC1Ad28e984) |

The new a.DI deployments on Ink network are as follows:

| Contract             | Address                                                                                                                     |
| -------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0x990B75fD1a2345D905a385dBC6e17BEe0Cb2f505](https://57073.routescan.io/address/0x990B75fD1a2345D905a385dBC6e17BEe0Cb2f505) |
| Granular Guardian    | [0xa2bDB2335Faf1940c99654c592B1a80618d79Fc9](https://57073.routescan.io/address/0xa2bDB2335Faf1940c99654c592B1a80618d79Fc9) |

The new Aave Governance deployments on Ink network are as follows:

| Contract            | Address                                                                                                                     |
| ------------------- | --------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x44D73D7C4b2f98F426Bf8B5e87628d9eE38ef0Cf](https://57073.routescan.io/address/0x44D73D7C4b2f98F426Bf8B5e87628d9eE38ef0Cf) |
| Executor Lvl 1      | [0x47aAdaAE1F05C978E6aBb7568d11B7F6e0FC4d6A](https://57073.routescan.io/address/0x47aAdaAE1F05C978E6aBb7568d11B7F6e0FC4d6A) |
| Governance Guardian | [0x1bBcC6F0BB563067Ca45450023a13E34fa963Fa9](https://57073.routescan.io/address/0x1bBcC6F0BB563067Ca45450023a13E34fa963Fa9) |
| BGD Labs Guardian   | [0x81D251dA015A0C7bD882918Ca1ec6B7B8E094585](https://57073.routescan.io/address/0x81D251dA015A0C7bD882918Ca1ec6B7B8E094585) |

## References

- Adapter Implementations: [Ink Native Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/main/src/contracts/adapters/ink/InkAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy/blob/f56472b1557e7b638e0a63d009d9396869ce1968/scripts/payloads/adapters/ethereum/Ethereum_Activate_Ink_Bridge_Adapter_Payload.s.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy/blob/f56472b1557e7b638e0a63d009d9396869ce1968/tests/payloads/ethereum/AddInkPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy/blob/f56472b1557e7b638e0a63d009d9396869ce1968/diffs/adi_add_ink_path_to_adiethereum_before_adi_add_ink_path_to_adiethereum_after.md)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/108)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
