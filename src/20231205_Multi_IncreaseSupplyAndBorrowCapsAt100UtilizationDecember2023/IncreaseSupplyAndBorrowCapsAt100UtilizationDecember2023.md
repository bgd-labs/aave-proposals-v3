---
title: "Increase Polygon wstETH Supply Cap"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-at-100-utilization-december-2023/15754"
---

## Simple Summary

This AIP proposes to increase supply caps on assets that currently have 100% or close to 100% utilization.

## Motivation

The AIP proposes increasing supply caps to meet the ongoing market demand for depositing. This increase will enable new Aave users to join Aave V3 on Polygon and allow existing users to expand their positions. These changes will use the direct-to-AIP framework as those change have been greenlighted by Chaos Labs. Supply caps on assets at supply cap will be increased by 20%.

## Specification

| Asset | Chain ID | Current Supply Cap | New Supply Cap | Current Borrow Cap | New Borrow Cap |
| ----- | -------- | ------------------ | -------------- | ------------------ | -------------- |
| wsETH | Polygon  | 3.45k              | 4.37k          | 285.00             | No Change      |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Polygon_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Arbitrum_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Polygon_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Arbitrum_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.t.sol)
- [Snapshot](No snapshot for direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-at-100-utilization-december-2023/15754)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
