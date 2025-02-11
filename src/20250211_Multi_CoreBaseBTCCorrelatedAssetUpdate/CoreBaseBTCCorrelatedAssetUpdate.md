---
title: "Core & Base - BTC Correlated Asset Update"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940"
snapshot: TODO
---

## Simple Summary

## Motivation

## Specification

The table below illustrates the configured risk parameters for **LBTC**

| Parameter                 |                                      Value |
| ------------------------- | -----------------------------------------: |
| Isolation Mode            |                                      false |
| Borrowable                |                                    ENABLED |
| Collateral Enabled        |                                       true |
| Supply Cap (LBTC)         |                                        800 |
| Borrow Cap (LBTC)         |                                         80 |
| Debt Ceiling              |                                      USD 0 |
| LTV                       |                                       70 % |
| LT                        |                                       75 % |
| Liquidation Bonus         |                                      8.5 % |
| Liquidation Protocol Fee  |                                       10 % |
| Reserve Factor            |                                       20 % |
| Base Variable Borrow Rate |                                        0 % |
| Variable Slope 1          |                                        4 % |
| Variable Slope 2          |                                      300 % |
| Uoptimal                  |                                       80 % |
| Flashloanable             |                                    ENABLED |
| Siloed Borrowing          |                                   DISABLED |
| Borrowable in Isolation   |                                   DISABLED |
| Oracle                    | 0x1E6c22AAA11F507af12034A5Dc4126A6A25DC8d2 |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Ethereum_CoreBaseBTCCorrelatedAssetUpdate_20250211.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Ethereum_CoreBaseBTCCorrelatedAssetUpdate_20250211.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250211_Multi_CoreBaseBTCCorrelatedAssetUpdate/AaveV3Base_CoreBaseBTCCorrelatedAssetUpdate_20250211.t.sol)
  [Snapshot](TODO)
- [Discussion](https://governance.aave.com/t/arfc-core-base-btc-correlated-asset-update/20940)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
