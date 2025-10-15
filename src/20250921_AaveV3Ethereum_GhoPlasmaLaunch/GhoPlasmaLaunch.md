---
title: "Gho Plasma Launch"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb"
---

## Simple Summary

This AIP proposes deploying GHO on the Plasma blockchain. The goal is to establish GHO as a key stablecoin within Plasma’s ecosystem from inception, facilitating reward programs, liquidity incentives, and seamless integration with the Aave deployment on Plasma.

## Motivation

Plasma is a purpose-built, EVM-compatible Bitcoin sidechain designed specifically for stablecoin scalability, speed, and security—offering zero-fee USDT transfers, lightning-fast finality, and Bitcoin-anchored settlement.

The network is quickly approaching launch with substantial USDT liquidity and an institutional partnership with Aave, including active GHO support on the platform.

Deploying GHO concurrently with the Aave instance on Plasma ensures that GHO becomes foundational to DeFi and payments infrastructure on a chain optimized for stablecoin utility.

## Specification

This AIP includes a series of actions required to launch GHO on Plasma:

1. Configure new Chainlink CCIP lanes between Plasma and the chains where GHO is launched with a rate limit of 1.5M GHO capacity and 300 GHO per second rate.
2. Configure GhoCcipSteward.
3. Configure GhoBucketSteward

The table below lists the address of the new **Plasma** deployments

| Contract         | Address                                                                                                                |
| :--------------- | :--------------------------------------------------------------------------------------------------------------------- |
| GhoToken         | [0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3](https://plasmascan.to/address/0xb77E872A68C62CfC0dFb02C067Ecc3DA23B4bbf3) |
| GhoTokenPool     | [0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12](https://plasmascan.to/address/0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12) |
| GhoBucketSteward | [0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B](https://plasmascan.to/address/0x2Ce400703dAcc37b7edFA99D228b8E70a4d3831B) |
| GhoCcipSteward   | [0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6](https://plasmascan.to/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/d443430284364cc940ab062f2423a016b3e8eb0a/src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/AaveV3Ethereum_GhoPlasmaLaunch_20250921.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/d443430284364cc940ab062f2423a016b3e8eb0a/src/20250921_AaveV3Ethereum_GhoPlasmaLaunch/AaveV3Ethereum_GhoPlasmaLaunch_20250921.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0xeb3572580924976867073ad9c8012cb9e52093c76dafebd7d3aebf318f2576fb)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-plasma-set-aci-as-emissions-manager-for-rewards/22994)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
