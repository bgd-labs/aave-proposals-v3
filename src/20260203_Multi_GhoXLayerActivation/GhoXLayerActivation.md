---
title: "Gho X-Layer Activation"
author: "@TokenLogic"
discussions: https://governance.aave.com/t/arfc-launch-gho-on-x-layer-set-aci-as-emissions-manager-for-rewards/23178
snapshot: https://snapshot.box/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0
---

## Simple Summary

This AIP proposes activating CCIP Lanes for GHO on the X-Layer blockchain.

## Motivation

X Layer is expected to act as both a payment-focused network and a DeFi hub, creating new avenues for user onboarding, real-world adoption, and capital efficiency.

Deploying GHO concurrently with the Aave instance on X-Layer ensures that GHO has every chance of becoming foundational to DeFi and payments infrastructure on a chain optimized for Money 2.0 utility.

The goal is to establish GHO as a key stablecoin within X Layer’s ecosystem from inception, facilitating reward programs, liquidity incentives, and seamless integration with the upcoming Aave deployment.

## Specification

This AIP includes a series of actions required to launch GHO on X-Layer:

1. Configure new Chainlink CCIP lanes between X-Layer and the chains where GHO is launched with a rate limit of 1.5M GHO capacity and 300 GHO per second rate.
2. Configure GhoCcipSteward.
3. Configure GhoBucketSteward

   The table below lists the address of the new **X-Layer** deployments

   | Contract           | Address                                                                                                                                  |
   | :----------------- | :--------------------------------------------------------------------------------------------------------------------------------------- |
   | GhoToken           | [0xDe6539018B095353A40753Dc54C91C68c9487D4E](https://www.oklink.com/x-layer/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E)          |
   | GhoTokenPool       | [0xA5Ba213867E175A182a5dd6A9193C6158738105A](https://www.oklink.com/x-layer/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A)          |
   | GhoBucketSteward   | [0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6](https://www.oklink.com/x-layer/address/0x20fd5f3FCac8883a3A0A2bBcD658A2d2c6EFa6B6)          |
   | GhoCcipSteward     | [0xFAdC082665577b533e62A7B0E067f884cA5C5E8F](https://www.oklink.com/x-layer/address/0xFAdC082665577b533e62A7B0E067f884cA5C5E8F)          |
   | GhoAavecoreSteward | [0x6e637e1e48025e51315d50ab96d5b3be1971a715](https://www.oklink.com/x-layer/address/0x6e637e1e48025e51315d50ab96d5b3be1971a715/contract) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Ethereum_GhoXLayerActivation_20260203.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Avalanche_GhoXLayerActivation_20260203.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Arbitrum_GhoXLayerActivation_20260203.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Base_GhoXLayerActivation_20260203.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Gnosis_GhoXLayerActivation_20260203.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Plasma_GhoXLayerActivation_20260203.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Ethereum_GhoXLayerActivation_20260203.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Avalanche_GhoXLayerActivation_20260203.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Arbitrum_GhoXLayerActivation_20260203.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Base_GhoXLayerActivation_20260203.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Gnosis_GhoXLayerActivation_20260203.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260203_Multi_GhoXLayerActivation/AaveV3Plasma_GhoXLayerActivation_20260203.t.sol)
  [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x251c520f1f1da8287168420fa2d2a73a2eb5342c3c62508553123129dec059b0)
- [Discussion](https://governance.aave.com/t/arfc-launch-gho-on-x-layer-set-aci-as-emissions-manager-for-rewards/23178)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
