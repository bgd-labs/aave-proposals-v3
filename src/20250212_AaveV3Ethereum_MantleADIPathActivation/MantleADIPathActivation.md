---
title: "Mantle a.DI path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/81"
---

## Simple Summary

Proposal to activate the necessary a.DI and governance infrastructure for the Mantle network, a technical prerequisite for an activation vote of Aave v3 Mantle.

## Motivation

In order to be able to pass messages from Ethereum to Mantle via a.DI (Aave Delivery Infrastructure), it is necessary to at least have three valid adapters Ethereum → Mantle smart contracts enabled in the system.

The first case of message passing Ethereum → Mantle is the activation proposal for an Aave v3 Mantle pool, and consequently, to be able to execute on the Mantle side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements of previous networks like ZkSync or Linea.

## Specification

The proposal payload simply registers pre-deployed Mantle adapters (with the necessary configurations to communicate with the Mantle a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → Mantle path. The required confirmations on the path are 1 out of 1.

| Network  | Mantle Native Adapter                                                                                                   |
| -------- | ----------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0xb66FA987fa7975Cac3d12B629c9c44e459e50990](https://etherscan.io/address/0xb66FA987fa7975Cac3d12B629c9c44e459e50990)   |
| Mantle   | [0x4E740ac02b866b429738a9e225e92A15F4452521](https://mantlescan.xyz/address/0x4E740ac02b866b429738a9e225e92A15F4452521) |

The new a.DI deployments on Mantle network are as follows:

| Contract             | Address                                                                                                                 |
| -------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0x1283C5015B1Fb5616FA3aCb0C18e6879a02869cB](https://mantlescan.xyz/address/0x1283C5015B1Fb5616FA3aCb0C18e6879a02869cB) |
| Granular Guardian    | [0xb26670d2800DBB9cfCe2f2660FfDcA48C799c86d](https://mantlescan.xyz/address/0xb26670d2800DBB9cfCe2f2660FfDcA48C799c86d) |

The new Aave Governance deployments on Mantle network are as follows:

| Contract            | Address                                                                                                                 |
| ------------------- | ----------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0xF089f77173A3009A98c45f49D547BF714A7B1e01](https://mantlescan.xyz/address/0xF089f77173A3009A98c45f49D547BF714A7B1e01) |
| Executor Lvl 1      | [0x70884634D0098782592111A2A6B8d223be31CB7b](https://mantlescan.xyz/address/0x70884634D0098782592111A2A6B8d223be31CB7b) |
| Governance Guardian | [0x14816fC7f443A9C834d30eeA64daD20C4f56fBCD](https://mantlescan.xyz/address/0x14816fC7f443A9C834d30eeA64daD20C4f56fBCD) |
| BGD Labs Guardian   | [0x0686f59Cc2aEc1ccf891472Dc6C89bB747F6a4A7](https://mantlescan.xyz/address/0x0686f59Cc2aEc1ccf891472Dc6C89bB747F6a4A7) |

## References

- Adapter Implementations: [Mantle Native Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/9a79f7986b5442657f64e41a0ab089e0cdb71e98/src/contracts/adapters/mantle/MantleAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy/blob/54a363eb2d435782f6107ed3bef4fdbec6ff52c1/scripts/payloads/adapters/ethereum/Ethereum_Activate_Mantle_Bridge_Adapter_Payload.s.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy/blob/54a363eb2d435782f6107ed3bef4fdbec6ff52c1/tests/payloads/ethereum/AddMantlePathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy/blob/54a363eb2d435782f6107ed3bef4fdbec6ff52c1/diffs/adi_add_mantle_path_to_adiethereum_before_adi_add_mantle_path_to_adiethereum_after.md)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/81)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
