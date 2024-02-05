---
title: "V2 Ethereum LT Reductions"
author: "Chaos Labs - Eyal Ovadya"
discussions: "https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-30-2024/16468"
---

## Simple Summary

A proposal to reduce Liquidation Thresholds on Aave V2 Ethereum.

## Motivation

Following the v2 deprecation framework, Chaos Labs and Gauntlet advise implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum and Polygon

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. We will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

## Specification

Chaos and Gauntlet align on following recommendations, choosing the higher value between Gauntlet’s aggressive and Chaos’s moderate approach for each asset:

##### Aave v2 Ethereum

| Asset | Current LT | Recommended LT |
| ----- | ---------- | -------------- |
| CRV   | 18%        | 14%            |
| ENS   | 24%        | 0.05%          |
| LINK  | 74%        | 72%            |
| MKR   | 18%        | 14%            |
| UNI   | 20%        | 14%            |
| ZRX   | 12%        | 8%             |

|       | Value liquidated | Accounts liquidated |
| ----- | ---------------- | ------------------- |
| Total | $67,480          | 47                  |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/295f9414834c29c4250b6da9d52c2c3e958b0728/src/20240201_AaveV2Ethereum_ChaosLabsV2EthereumLTReductions/AaveV2Ethereum_ChaosLabsV2EthereumLTReductions_20240201.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/295f9414834c29c4250b6da9d52c2c3e958b0728/src/20240201_AaveV2Ethereum_ChaosLabsV2EthereumLTReductions/AaveV2Ethereum_ChaosLabsV2EthereumLTReductions_20240201.t.sol)
- [Snapshot](No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-01-30-2024/16468)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
