---
title: "Aave V2 Ethereum LT Reduction"
author: "Chaos Labs - @yonikesel"
discussions: "https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-10-27-2023/15249"
---

## Simple Summary

A proposal to reduce Liquidation Threshold (LT) on Aave V2 Ethereum.

## Motivation

In accordance with the [v2 deprecation framework](https://governance.aave.com/t/arfc-aave-v2-markets-deprecation-plan/14870), Chaos Labs and Gauntlet advise implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum

## LT Reductions

The recommendations below suggest an LT configuration that optimizes reductions without significantly increasing the number of accounts eligible for liquidation. The proposed values are set at a margin of at least ~4% from the closest LT figure, which would trigger more substantial liquidations.

This will affect 20 accounts, leading to a cumulative liquidation of $1,101 in collateral value.

| Asset  | Current LT | Rec LT | Value Liquidated ($) | Accounts Liquidated |
| ------ | ---------- | ------ | -------------------- | ------------------- |
| 1INCH  | 24%        | 1%     | 163                  | 1                   |
| BAL    | 25%        | 21%    | 43                   | 2                   |
| BAT    | 1%         | 1%     | 0                    | 0                   |
| CRV    | 42%        | 38%    | 10                   | 1                   |
| CVX    | 33%        | 30%    | 0                    | 0                   |
| DPI    | 16%        | 14%    | 36                   | 1                   |
| ENJ    | 50%        | 50%    | 0                    | 0                   |
| ENS    | 50%        | 47%    | 2                    | 1                   |
| MANA   | 48%        | 37%    | 28                   | 1                   |
| MKR    | 35%        | 30%    | 149                  | 1                   |
| REN    | 27%        | 25%    | 57                   | 1                   |
| SNX    | 43%        | 41%    | 28                   | 1                   |
| UNI    | 70%        | 64%    | 0                    | 0                   |
| xSUSHI | 28%        | 1%     | 270                  | 9                   |
| YFI    | 45%        | 43%    | 0                    | 0                   |
| ZRX    | 37%        | 34%    | 315                  | 1                   |
| LINK   | 82%        | 81%    | 0                    | 0                   |

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

## Specification

Frozen Assets:

| Asset  | Current LT | Rec LT |
| ------ | ---------- | ------ |
| 1INCH  | 24%        | 1%     |
| BAL    | 25%        | 21%    |
| BAT    | 1%         | 1%     |
| CRV    | 42%        | 38%    |
| CVX    | 33%        | 30%    |
| DPI    | 16%        | 14%    |
| ENJ    | 50%        | 50%    |
| ENS    | 50%        | 47%    |
| MANA   | 48%        | 37%    |
| MKR    | 35%        | 30%    |
| REN    | 27%        | 25%    |
| SNX    | 43%        | 41%    |
| UNI    | 70%        | 64%    |
| xSUSHI | 28%        | 1%     |
| YFI    | 45%        | 43%    |
| ZRX    | 37%        | 34%    |
| LINK   | 82%        | 81%    |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231030_AaveV2Ethereum_AaveV2EthereumLTReduction/AaveV2Ethereum_AaveV2EthereumLTReduction_20231030.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231030_AaveV2Ethereum_AaveV2EthereumLTReduction/AaveV2Ethereum_AaveV2EthereumLTReduction_20231030.t.sol)
- [Snapshot](Direct to AIP)
- [Discussion](https://governance.aave.com/t/arfc-v2-ethereum-lt-reductions-10-27-2023/15249)

# Disclaimer

Chaos Labs and Gauntlet have not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
