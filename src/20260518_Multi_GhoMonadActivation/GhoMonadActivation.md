---
title: "Gho Monad Activation"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6"
---

## Simple Summary

This AIP proposes activating CCIP Lanes for GHO on the Monad blockchain.

## Motivation

Monad’s pipelined EVM architecture delivers fast, high-throughput performance while remaining fully compatible with Ethereum, making it ideal for real-time financial applications.
This directly supports the needs of neobanks and fintech platforms, which rely on quick transaction finality, scalability, and predictable costs.

Deploying GHO concurrently with the Aave instance on Monad ensures that GHO has every chance of becoming foundational to DeFi and payments infrastructure on a chain optimized for performance.

The goal is to establish GHO as a key stablecoin within Monad’s ecosystem from inception, facilitating reward programs, liquidity incentives, and seamless integration with the upcoming Aave deployment.

## Specification

This AIP includes a series of actions required to launch GHO on Monad:

1. Configure new Chainlink CCIP lanes between Monad and the chains where GHO is launched with a rate limit of 1,500,000 GHO capacity and 300 GHO per second rate.
2. Configure GhoCcipSteward.
3. Configure GhoBucketSteward.

   The table below lists the address of the new **Monad** deployments

   | Contract           | Address                                                                                                                |
   | :----------------- | :--------------------------------------------------------------------------------------------------------------------- |
   | GhoToken           | [0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73](https://monadscan.com/address/0xfc421aD3C883Bf9E7C4f42dE845C4e4405799e73) |
   | GhoTokenPool       | [0xA5AE05b71c3F170E12E7620Fdf7679721aec1EC8](https://monadscan.com/address/0xA5AE05b71c3F170E12E7620Fdf7679721aec1EC8) |
   | GhoBucketSteward   | [0xDe6539018B095353A40753Dc54C91C68c9487D4E](https://monadscan.com/address/0xDe6539018B095353A40753Dc54C91C68c9487D4E) |
   | GhoCcipSteward     | [0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12](https://monadscan.com/address/0x360d8aa8F6b09B7BC57aF34db2Eb84dD87bf4d12) |
   | GhoAaveCoreSteward | [0xA5Ba213867E175A182a5dd6A9193C6158738105A](https://monadscan.com/address/0xA5Ba213867E175A182a5dd6A9193C6158738105A) |

   The initial CCIP Facilitator Bucket Capacity will be 100,000,000 units.

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Ethereum_GhoMonadActivation_20260518.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Avalanche_GhoMonadActivation_20260518.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Arbitrum_GhoMonadActivation_20260518.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Base_GhoMonadActivation_20260518.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Gnosis_GhoMonadActivation_20260518.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Plasma_GhoMonadActivation_20260518.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3XLayer_GhoMonadActivation_20260518.sol), [AaveV3Ink](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Ink_GhoMonadActivation_20260518.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/remote-lanes/AaveV3Mantle_GhoMonadActivation_20260518.sol), [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/AaveV3Monad_GhoMonadActivation_20260518.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Ethereum_GhoMonadActivation_20260518.t.sol), [AaveV3Avalanche](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Avalanche_GhoMonadActivation_20260518.t.sol), [AaveV3Arbitrum](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Arbitrum_GhoMonadActivation_20260518.t.sol), [AaveV3Base](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Base_GhoMonadActivation_20260518.t.sol), [AaveV3Gnosis](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Gnosis_GhoMonadActivation_20260518.t.sol), [AaveV3Plasma](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Plasma_GhoMonadActivation_20260518.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3XLayer_GhoMonadActivation_20260518.t.sol), [AaveV3Ink](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Ink_GhoMonadActivation_20260518.t.sol), [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/remote-lanes/AaveV3Mantle_GhoMonadActivation_20260518.t.sol), [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/bb3cc7571fd226efdd9d74567f66b0191e618c88/src/20260518_Multi_GhoMonadActivation/tests/AaveV3Monad_GhoMonadActivation_20260518.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x24f105bd023c476a9b85fa87ff795bfeec769fa799ce6ada8e2724c9738049f6)
- [Discussion](https://governance.aave.com/t/arfc-deploy-aave-protocol-on-monad/24943)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
