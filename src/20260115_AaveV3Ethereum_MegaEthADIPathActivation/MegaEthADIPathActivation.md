---
title: "MegaEth aDI path activation"
author: "BGD Labs @bgdlabs"
discussions: TODO
---

## Simple Summary

Proposal to register the necessary MegaEth adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 MegaEth.

## Motivation

In order to be able to pass messages from Ethereum to MegaEth via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum → MegaEth smart contract enabled in the system (native adapter).

The first case of message passing Ethereum → MegaEth is the activation proposal for an Aave v3 MegaEth pool and consequently, to be able to execute on the MegaEth side the payload, the Aave governance should approve in advance the a.DI adapters smart contracts.

## Specification

The proposal payload simply registers pre-deployed MegaEth adapters (with the necessary configurations to communicate with the MegaEth a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

The following are the configured adapters for the Ethereum → MegaEth path. The required confirmations on the path are 1 out of 1.

| Network  | MegaEth Native Adapter                                                                                                          |
| -------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Ethereum | [0xC88f3Ffa9923BfAA93681D62864a24d0D10D68d3](https://etherscan.io/address/0xC88f3Ffa9923BfAA93681D62864a24d0D10D68d3)           |
| MegaEth  | [0x9Ec11a4c2fEc289Db81D75eF31140c358CB93CC6](https://megaeth.blockscout.com/address/0x9Ec11a4c2fEc289Db81D75eF31140c358CB93CC6) |

The new a.DI deployments on MegaEth network are as follows:

| Contract             | Address                                                                                                                         |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| CrossChainController | [0x5EE63ACb37AeCDc7e23ACA283098f8ffD9677BBe](https://megaeth.blockscout.com/address/0x5EE63ACb37AeCDc7e23ACA283098f8ffD9677BBe) |
| Granular Guardian    | [0x8Fa22D09b13486A40cd6b04398b948AA8bD5853A](https://megaeth.blockscout.com/address/0x8Fa22D09b13486A40cd6b04398b948AA8bD5853A) |

The new Aave Governance deployments on MegaEth network are as follows:

| Contract            | Address                                                                                                                         |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| PayloadsController  | [0x80e11cB895a23C901a990239E5534054C66476B5](https://megaeth.blockscout.com/address/0x80e11cB895a23C901a990239E5534054C66476B5) |
| Executor Lvl 1      | [0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19](https://megaeth.blockscout.com/address/0xE2E8Badc5d50f8a6188577B89f50701cDE2D4e19) |
| Governance Guardian | [0x5a578ee1dA2c798Be60036AdDD223Ac164d948Af](https://megaeth.blockscout.com/address/0x5a578ee1dA2c798Be60036AdDD223Ac164d948Af) |
| BGD Labs Guardian   | [0x58528Cd7B8E84520df4D3395249D24543f431c21](https://megaeth.blockscout.com/address/0x58528Cd7B8E84520df4D3395249D24543f431c21) |

## References

- Adapter Implementations: [MegaEth Native Adapter](https://github.com/aave-dao/aave-delivery-infrastructure/blob/8e0fc4e4e49045d808a35ffcf5b536b4147ded5b/src/contracts/adapters/megaEth/MegaEthAdapter.sol)
- Payload Implementation: [Payload](https://github.com/aave-dao/adi-deploy/blob/24bcd658ba115a99743f6282e42a070b81ada588/scripts/payloads/adapters/ethereum/Ethereum_Activate_MegaEth_Bridge_Adapter_Payload.s.sol)
- Payload Tests: [tests](https://github.com/aave-dao/adi-deploy/blob/24bcd658ba115a99743f6282e42a070b81ada588/tests/payloads/ethereum/AddMegaEthPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/aave-dao/adi-deploy/blob/24bcd658ba115a99743f6282e42a070b81ada588/diffs/adi_add_megaeth_path_to_adiethereum_before_adi_add_megaeth_path_to_adiethereum_after.md)
- [Discussion]()

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
