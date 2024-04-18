---
title: "Ethereum V2 LT Reductions "
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-04-15-2024/17369"
---

## Simple Summary

A proposal to reduce Liquidation Thresholds on Aave V2 Ethereum.

## Motivation

In continuation of the deprecation of Aave V2, Chaos Labs advises implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum.

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. We will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

Our recommendations below suggest an LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of ~4-6% from the closest LT figure, which would trigger more substantial liquidations.

## Specification

Aave v2 Ethereum
| Asset | Current LT | Chaos Rec LT | Value Liquidated ($) | Accounts Liquidated |
|-------|------------|--------------|----------------------|---------------------|
| CRV | 14% | 0.01% | 1.07k | 6 |
| LINK | 72% | 68% | 2.82k | 7 |
| MKR | 14% | 10% | 280 | 4 |
| UNI | 14% | 0.01% | 1.12k | 12 |
| ZRX | 8% | 5% | - | - |

|       | Value liquidated | Accounts liquidated |
| ----- | ---------------- | ------------------- |
| Total | $5.49k           | 31                  |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240416_AaveV2Ethereum_EthereumV2LTReductions/AaveV2Ethereum_EthereumV2LTReductions_20240416.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240416_AaveV2Ethereum_EthereumV2LTReductions/AaveV2Ethereum_EthereumV2LTReductions_20240416.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-04-15-2024/17369)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
