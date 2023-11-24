---
title: "V2 Deprecation Plan, 2023.11.20"
author: "Gauntlet, Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-v2-ethereum-deprecation-11-20-2023/15628"
---

## Simple Summary

A proposal to reduce Liquidation Thresholds (LT) on Aave V2 Ethereum.

## Motivation

In accordance with the [v2 deprecation framework](https://governance.aave.com/t/arfc-aave-v2-markets-deprecation-plan/14870), Gauntlet and Chaos Labs advise implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum.

## Specification

The recommendations below suggest an LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of at least ~4% from the closest LT figure, which would trigger more substantial liquidations.
This will affect 33 accounts, leading to a cumulative of $5,460 in value liquidated.

| Asset | Current LT | New LT |
| ----- | ---------- | ------ |
| BAL   | 21%        | 1%     |
| CRV   | 38%        | 30%    |
| CVX   | 30%        | 24%    |
| DPI   | 14%        | 5%     |
| ENJ   | 50%        | 44%    |
| ENS   | 47%        | 38%    |
| LINK  | 81%        | 80%    |
| MANA  | 37%        | 29%    |
| MKR   | 30%        | 28%    |
| REN   | 25%        | 18%    |
| SNX   | 41%        | 30%    |
| UNI   | 64%        | 55%    |
| YFI   | 43%        | 32%    |
| ZRX   | 34%        | 24%    |

As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos and Gauntlet will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e571baf835c669d317a9dfc656f3f4d7159c9972/src/20231121_AaveV2Ethereum_V2DeprecationPlan20231120/AaveV2Ethereum_V2DeprecationPlan20231120_20231121.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/e571baf835c669d317a9dfc656f3f4d7159c9972/src/20231121_AaveV2Ethereum_V2DeprecationPlan20231120/AaveV2Ethereum_V2DeprecationPlan20231120_20231121.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-v2-ethereum-deprecation-11-20-2023/15628)

## Disclaimer

Gauntlet and Chaos Labs have not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via CC0.

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
