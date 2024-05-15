---
title: "Chaos Labs Ethereum V2 LT Reductions"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-05-06-2024/17598"
---

## Simple Summary

A proposal to reduce Liquidation Thresholds on Aave V2 Ethereum.

## Motivation

In continuation of the deprecation of Aave V2, Chaos Labs advises implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum.

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. We will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

Our recommendations below suggest an LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of ~4-6% from the closest LT figure, which would trigger more substantial liquidations.

## Specification

| Asset | Current LT | Recommended LT |
| ----- | ---------- | -------------- |
| LINK  | 68%        | 65%            |
| ZRX   | 5%         | 0_01%          |

|       | Value liquidated | Accounts liquidated |
| ----- | ---------------- | ------------------- |
| Total | $688             | 6                   |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240509_AaveV2Ethereum_ChaosLabsEthereumV2LTReductions/AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240509_AaveV2Ethereum_ChaosLabsEthereumV2LTReductions/AaveV2Ethereum_ChaosLabsEthereumV2LTReductions_20240509.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-ethereum-v2-lt-reductions-05-06-2024/17598)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
