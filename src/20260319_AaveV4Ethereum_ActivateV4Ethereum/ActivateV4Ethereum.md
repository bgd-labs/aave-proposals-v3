---
title: "Aave V4 Activation on Ethereum Mainnet"
author: "Aave Labs (@aave)"
discussions: "https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265"
---

## Simple Summary

This AIP proposes the activation of Aave V4 on Ethereum Mainnet, through a security-first initial setup with conservative risk parameters and a deliberately narrow Hub and Spoke configuration.

## Motivation

Aave V4 builds on the success of V3, extending the protocol architecture to support a broader range of onchain credit markets while keeping unified liquidity. It introduces a Hub-and-Spoke model, where Spokes encapsulate market-specific logic, risk and asset configurations, while sourcing liquidity from a shared Hub. This design allows different types of collateral, credit structures, and market constraints (e.g., maturity-based assets, RWAs, or structured products) to coexist without forcing them into a single risk framework or fragmenting liquidity across isolated pools.

By decoupling market logic from liquidity, V4 enables more precise risk pricing and capital efficiency. Collateral-level risk premiums ensure borrowing costs reflect the underlying risk of each position, while a share-based accounting model maintains consistency across supply, debt, and liquidation flows despite heterogeneous Spoke implementations. This allows Aave to scale into more complex financial use cases while preserving a unified balance sheet, improving supplier compensation, and supporting diverse credit markets within a single system.

## Specification

The contracts have been pre-deployed and configured, and this AIP performs the activation of the system. The implementation adheres to the risk parameter [recommendations](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293/3) provided by Risk Providers (@Chaos Labs and @Llama Risk), with Aave Labs collaborating closely to ensure precise implementation.

The system is currently paused, meaning no supply or borrow operations are permitted until this proposal is executed and activation occurs. All assets are currently deactivated on the Hub, and this AIP enables them to start the system.

Governance of the contracts is managed by the DAO via Executor Level 1, with additional oversight from the Protocol Security Council during the initial hardening phase, to mitigate risks in potential emergency scenarios. Contracts that support only a single controller are temporarily owned by the Protocol Security Council for simplicity.

The permissions of the Protocol Security Council are expected to be eliminated following this phase, after which all updates will proceed through standard governance processes and approved stewards. The Protocol Security Council [0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9](https://etherscan.io/address/0x187AAE17d4931310B3fc75743e7F16Bdc9eD77e9) is a 5-of-8 Safe multisig currently composed of Aave Labs members, with a follow-up proposal planned to incorporate additional participants.

The Treasury Spoke [0xB9B0b8616f6Bf6841972a52058132BE08d723155
](http://etherscan.io/address/0xB9B0b8616f6Bf6841972a52058132BE08d723155) has been deployed and configured as the fee receiver for all assets listed across Hubs. Initially, it is controlled by the Protocol Security Council and will be handed over to the DAO after the hardening phase.

The table below provides the full list of contract addresses:
| Hub | Address |
| --------- | ------------------------------------------ |
| Core Hub | 0xCca852Bc40e560adC3b1Cc58CA5b55638ce826c9 |
| Plus Hub | 0x06002e9c4412CB7814a791eA3666D905871E536A |
| Prime Hub | 0x943827DCA022D0F354a8a8c332dA1e5Eb9f9F931 |

| Spoke                   | Address                                    |
| ----------------------- | ------------------------------------------ |
| Main Spoke              | 0x94e7A5dCbE816e498b89aB752661904E2F56c485 |
| Lido Spoke              | 0xe1900480ac69f0B296841Cd01cC37546d92F35Cd |
| EtherFi Spoke           | 0xbF10BDfE177dE0336aFD7fcCF80A904E15386219 |
| Kelp Spoke              | 0x3131FE68C4722e726fe6B2819ED68e514395B9a4 |
| Lombard BTC Spoke       | 0x7EC68b5695e803e98a21a9A05d744F28b0a7753D |
| Gold Spoke              | 0x65407b940966954b23dfA3caA5C0702bB42984DC |
| Forex Spoke             | 0xD8B93635b8C6d0fF98CbE90b5988E3F2d1Cd9da1 |
| Bluechip Spoke          | 0x973a023A77420ba610f06b3858aD991Df6d85A08 |
| Ethena Correlated Spoke | 0x58131E79531caB1d52301228d1f7b842F26B9649 |
| Ethena Ecosystem Spoke  | 0xba1B3D55D249692b669A164024A838309B7508AF |

## Security

The Aave V4 protocol has undergone multiple stages of development, testing, and security reviews, as outlined in this [post](https://governance.aave.com/t/security-by-design-aave-v4/24224). The deployed version corresponds to release [0.5.11](https://github.com/aave/aave-v4/releases/tag/v0.5.11), publicly available in the [aave-v4 repository](https://github.com/aave/aave-v4).
Certora has reviewed the deployed contracts, as well as the subsequent configuration and governance proposal.

## References

- Implementation: [AaveV4Ethereum_ActivateV4Ethereum_20260319](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.sol)
- Tests: [AaveV4Ethereum_ActivateV4Ethereum_20260319_Test](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_ActivateV4Ethereum_20260319.t.sol) [AaveV4Ethereum_HubSpokeConfiguration_20260319_Test](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260319_AaveV4Ethereum_ActivateV4Ethereum/AaveV4Ethereum_HubSpokeConfiguration_20260319.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x55e85a32828da36122b9c8d50548696d7c748fd41c775f5bf06bdf0f2e32a265)
- [Discussion](https://governance.aave.com/t/arfc-aave-v4-activation-on-ethereum-mainnet/24293)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
