---
title: "Chaos Labs V2 Ethereum and Polygon LT Reductions"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-v2-ethereum-and-polygon-lt-reductions-12-04-2023/15747"
---

## Simple Summary

A proposal to reduce Liquidation Thresholds on Aave V2 Ethereum and Polygon.

## Motivation

Following the [v2 deprecation framework](https://governance.aave.com/t/arfc-aave-v2-markets-deprecation-plan/14870), Chaos Labs and Gauntlet advise implementing the subsequent parameter changes to the frozen assets on Aave v2 Ethereum and Polygon

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community at each step. We will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

The full governance post can be found [here](https://governance.aave.com/t/arfc-v2-ethereum-and-polygon-lt-reductions-12-04-2023/15747)

## Specification

Chaos and Gauntlet align on the aggressive approach to expedite the deprecation of several assets on V2, with a potential for ~$120K in total value eligible for liquidation, at the time of posting this proposal

### **Aave v2 Ethereum**

| Asset  | Current LT | Chaos Rec LT | Value Liquidated ($) | Accounts Liquidated |
| ------ | ---------- | ------------ | -------------------- | ------------------- |
| CRV    | 30%        | 25%          | 126                  | 1                   |
| CVX    | 24%        | 0.05%        | 33.24K               | 2                   |
| DPI    | 5%         | 0.05%        | -                    | -                   |
| ENJ    | 44%        | 0.05%        | 4.64K                | 14                  |
| ENS    | 38%        | 30%          | 2.7K                 | 9                   |
| LINK   | 80%        | 75%          | 3.63K                | 9                   |
| MANA   | 29%        | 0.05%        | 25.55K               | 13                  |
| MKR    | 28%        | 26%          | 72                   | 2                   |
| REN    | 18%        | 0.05%        | 2.24K                | 6                   |
| SNX    | 30%        | 0.05%        | 10.55K               | 20                  |
| UNI    | 55%        | 40%          | 2.16K                | 14                  |
| YFI    | 32%        | 0.05%        | 20.24K               | 10                  |
| ZRX    | 24%        | 18%          | -                    | -                   |
| 1INCH  | 1%         | 0.05%        | -                    | -                   |
| BAL    | 1%         | 0.05%        | -                    | -                   |
| BAT    | 1%         | 0.05%        | -                    | -                   |
| KNC    | 1%         | 0.05%        | -                    | -                   |
| FEI    | 1%         | 0.05%        | -                    | -                   |
| xSUSHI | 1%         | 0.05%        | -                    | -                   |

|       | Value liquidated | Accounts liquidated |
| ----- | ---------------- | ------------------- |
| Total | $106,024         | 103                 |

### **Aave v2 Polygon**

| Asset | Current LT | Chaos Rec LT | Chaos Rec LTV | Value Liquidated ($) | Accounts Liquidated |
| ----- | ---------- | ------------ | ------------- | -------------------- | ------------------- |
| SUSHI | 45%        | 0.05%        | 0%            | 13                   | 3                   |
| DPI   | 45%        | 0.05%        | 0%            | 40                   | 2                   |
| BAL   | 45%        | 0.05%        | 0%            | 1.2K                 | 15                  |
| CRV   | 45%        | 0.05%        | 0%            | 127                  | 11                  |
| GHST  | 40%        | 0.05%        | 0%            | 7.7K                 | 10                  |
| LINK  | 65%        | 0.05%        | 0%            | 6.6K                 | 26                  |

|       | Value liquidated | Accounts liquidated |
| ----- | ---------------- | ------------------- |
| Total | $15,600          | 69                  |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/AaveV2Ethereum_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_ChaosLabsV2EthereumAndPolygonLTReductions/AaveV2Polygon_ChaosLabsV2EthereumAndPolygonLTReductions_20231205.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-v2-ethereum-and-polygon-lt-reductions-12-04-2023/15747)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
