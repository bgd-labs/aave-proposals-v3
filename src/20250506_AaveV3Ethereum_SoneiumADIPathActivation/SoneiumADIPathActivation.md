---
title: "Soneium aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/83"
---

## Simple Summary

Proposal to register the necessary Soneium adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Soneium.

## Motivation

In order to be able to pass messages from Ethereum to Soneium via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum → Soneium smart contract enabled in the system (native adapter).

The first case of message passing Ethereum → Soneium is the activation proposal for an Aave v3 Soneium pool and consequently, to be able to execute on the Soneium side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

This procedure mirrors the requirements on previous networks like ZkSync or Linea.

## Specification

The proposal payload simply registers pre-deployed Soneium adapters (with the necessary configurations to communicate with the Soneium a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → Soneium path. The required confirmations on the path are 1 out of 1.

| Network  | Soneium Native Adapter                                                                                                          |
| -------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0xe66973c4571F733CafEb1BDE1fa58Ff35416d901](https://etherscan.io/address/0xe66973c4571F733CafEb1BDE1fa58Ff35416d901)           |
| Soneium  | [0x5698e43Ef1be85C68Dec568B5925dD5DB7903e39](https://soneium.blockscout.com/address/0x5698e43Ef1be85C68Dec568B5925dD5DB7903e39) |

The new a.DI deployments on Soneium network are as follows:

| Contract             | Address                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0xD92b37a5114b33F668D274Fb48f23b726a854d6E](https://soneium.blockscout.com/address/0xD92b37a5114b33F668D274Fb48f23b726a854d6E) |
| Granular Guardian    | [0xD8E6956718784B914740267b7A50B952fb516656](https://soneium.blockscout.com/address/0xD8E6956718784B914740267b7A50B952fb516656) |

The new Aave Governance deployments on Soneium network are as follows:

| Contract            | Address                                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x44D73D7C4b2f98F426Bf8B5e87628d9eE38ef0Cf](https://soneium.blockscout.com/address/0x44D73D7C4b2f98F426Bf8B5e87628d9eE38ef0Cf) |
| Executor Lvl 1      | [0x47aAdaAE1F05C978E6aBb7568d11B7F6e0FC4d6A](https://soneium.blockscout.com/address/0x47aAdaAE1F05C978E6aBb7568d11B7F6e0FC4d6A) |
| Governance Guardian | [0x19CE4363FEA478Aa04B9EA2937cc5A2cbcD44be6](https://soneium.blockscout.com/address/0x19CE4363FEA478Aa04B9EA2937cc5A2cbcD44be6) |
| BGD Labs Guardian   | [0xdc62E0e65b2251Dc66404ca717FD32dcC365Be3A](https://soneium.blockscout.com/address/0xdc62E0e65b2251Dc66404ca717FD32dcC365Be3A) |

## References

- Adapter Implementations: [Soneium Native Adapters](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/4509fff1467c02488296a47f617afaafd82d1454/src/contracts/adapters/soneium/soneiumAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy/blob/be5cbd5c5daf24b07ff9f4906ad69cef129838c4/scripts/payloads/adapters/ethereum/Ethereum_Activate_Soneium_Bridge_Adapter_Payload.s.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy/blob/be5cbd5c5daf24b07ff9f4906ad69cef129838c4/tests/payloads/ethereum/AddSoneiumPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy/blob/be5cbd5c5daf24b07ff9f4906ad69cef129838c4/diffs/adi_add_soneium_path_to_adiethereum_before_adi_add_soneium_path_to_adiethereum_after.md)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/83)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
