---
title: "V2 Deprecation Plan, 2024.01.02"
author: "Gauntlet, Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-02-2024/16030"
---

## Simple Summary

A proposal to reduce Liquidation Thresholds (LT) on Aave V2 Ethereum.

## Motivation

In accordance with the [v2 deprecation framework](https://governance.aave.com/t/arfc-aave-v2-markets-deprecation-plan/14870), Gauntlet and Chaos Labs advise implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum.

## Specification

The recommendations below suggest an LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of ~2-4% from the closest LT figure, which would trigger more substantial liquidations.

This will affect 39 accounts, leading to a cumulative of $14K in value liquidated.

| Asset | Current LT | New LT |
| :---- | ---------: | -----: |
| CRV   |       0.25 |   0.18 |
| ENS   |        0.3 |   0.24 |
| LINK  |       0.75 |   0.74 |
| MKR   |       0.26 |   0.18 |
| UNI   |        0.4 |    0.2 |
| ZRX   |       0.18 |   0.12 |

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos and Gauntlet will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ef466b2882c423651490c75b11987268b5943cdf/src/20240103_AaveV2Ethereum_V2DeprecationPlan20240102/AaveV2Ethereum_V2DeprecationPlan20240102_20240103.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ef466b2882c423651490c75b11987268b5943cdf/src/20240103_AaveV2Ethereum_V2DeprecationPlan20240102/AaveV2Ethereum_V2DeprecationPlan20240102_20240103.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-02-2024/16030)

## Disclaimer

Gauntlet and Chaos Labs have not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via CC0.

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
