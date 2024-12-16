---
title: "a.DI Linea path activation"
author: "BGD Labs @bgdlabs"
discussions: https://governance.aave.com/t/technical-maintenance-proposals/15274/56
snapshot: Direct-to-AIP
---

## Simple Summary

Proposal to register the necessary Liena adapters on a.DI, a technical pre-requirement for an activation vote of Aave v3 Linea.

## Motivation

In order to be able to pass messages from Ethereum to Linea via a.DI (Aave Delivery Infrastructure), it is necessary to at least have one valid adapter Ethereum → Linea smart contract enabled in the system.

The first case of message passing Ethereum → Linea is the activation proposal for an Aave v3 Linea pool and consequently, to be able to execute on the Linea side the payload, the Aave governance should approve in advance the a.DI adapter smart contract.

This procedure mirrors the requirements on previous networks like Scroll or ZkSync.

## Specification

The proposal payload simply registers a pre-deployed Linea adapter (with the necessary configurations to communicate with the Linea a.DI) on the Ethereum a.DI instance.

This is done by calling the enableBridgeAdapters() function on the Ethereum Cross-chain Controller smart contract.

| Network  | Linea Adapter                                                                                                            |
| -------- | ------------------------------------------------------------------------------------------------------------------------ |
| Ethereum | [0x8097555ffDa4176C93FEf92dF473b9763e467686](https://etherscan.io/address/0x8097555ffDa4176C93FEf92dF473b9763e467686)    |
| Linea    | [0xB3332d31ECFC3ef3BF6Cda79833D11d1A53f5cE6](https://lineascan.build/address/0xB3332d31ECFC3ef3BF6Cda79833D11d1A53f5cE6) |

The new a.DI deployments on Linea network are as follows:

| Contract             | Address                                                                                                                  |
| -------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| CrossChainController | [0x0D3f821e9741C8a8Bcac231162320251Db0cdf52](https://lineascan.build/address/0x0D3f821e9741C8a8Bcac231162320251Db0cdf52) |
| Granular Guardian    | [0xc1cd6faF6e9138b4e6C21d438f9ebF2bd6F6cA16](https://lineascan.build/address/0xc1cd6faF6e9138b4e6C21d438f9ebF2bd6F6cA16) |

The new Aave Governance deployments on Linea network are as follows:

| Contract            | Address                                                                                                                  |
| ------------------- | ------------------------------------------------------------------------------------------------------------------------ |
| PayloadsController  | [0x3BcE23a1363728091bc57A58a226CF2940C2e074](https://lineascan.build/address/0x3BcE23a1363728091bc57A58a226CF2940C2e074) |
| Executor Lvl 1      | [0x8c2d95FE7aeB57b86961F3abB296A54f0ADb7F88](https://lineascan.build/address/0x8c2d95FE7aeB57b86961F3abB296A54f0ADb7F88) |
| Governance Guardian | [0x056E4C4E80D1D14a637ccbD0412CDAAEc5B51F4E](https://lineascan.build/address/0x056E4C4E80D1D14a637ccbD0412CDAAEc5B51F4E) |
| BGD Labs Guardian   | [0xfD3a6E65e470a7D7D730FFD5D36a9354E8F9F4Ea](https://lineascan.build/address/0xfD3a6E65e470a7D7D730FFD5D36a9354E8F9F4Ea) |

## References

- Adapter Implementation: [Linea Bridge Adapter](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/239475f03956173abb5e09df31ed748f996c5944/src/contracts/adapters/linea/LineaAdapter.sol)
- Payload Implementation: [Payload](https://github.com/bgd-labs/adi-deploy/blob/e75bde29ab3824fd7533d111651c8c108010723b/scripts/payloads/adapters/ethereum/Ethereum_Activate_Lina_Bridge_Adapter_Payload.s.sol)
- Adapter Tests: [Linea Bridge Adapter tests](https://github.com/bgd-labs/aave-delivery-infrastructure/blob/239475f03956173abb5e09df31ed748f996c5944/tests/adapters/LineaAdapter.t.sol)
- Payload Tests: [tests](https://github.com/bgd-labs/adi-deploy/blob/e75bde29ab3824fd7533d111651c8c108010723b/tests/payloads/ethereum/AddLineaPathTest.t.sol)
- Diffs: [a.DI diffs](https://github.com/bgd-labs/adi-deploy/commit/bf1b830150ec38138d6ffb39d287bc889054c65f#diff-7918ccb77189a37fc1206fa85d2b01945dc79e5f5224c8850018da970c556756)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/56)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
