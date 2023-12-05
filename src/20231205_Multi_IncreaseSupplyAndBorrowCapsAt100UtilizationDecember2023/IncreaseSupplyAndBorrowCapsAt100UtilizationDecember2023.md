---
title: "Increase Supply and Borrow Caps at 100% Utilization - December 2023"
author: "Alice Rozengarden (@Rozengarden - Aave-chan initiative)"
discussions: "https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-at-100-utilization-december-2023/15754"
---

## Simple Summary

This ARFC proposes to increase supply and borrow caps on assets that currently have 100% or close to 100% utilization.

## Motivation

The ARFC proposes increasing supply and borrow caps on a number of assets to meet the ongoing market demand for depositing and borrowing. This increase will enable new Aave users to join Aave V3 and allow existing users to expand their positions. We will use the caps update framework and institute these changes as a direct-to-AIP proposal after review from risk managers. Supply caps on assets at supply cap will be increased by 50%. Borrow caps on 100% borrow utilization assets will be increased by 50%.

After a review from Chaos Labs, we propose changes on the following assets.

## Specification

|Asset|Chain ID|Current Supply Cap|New Supply Cap|Current Borrow Cap|New Borrow Cap|
| --- | --- | --- | --- | --- | --- |
|LINK|Arbitrum|1.45m|1.575m|242.25k|484.5k|
|wsETH|Polygon|3.45k|4.37k|285.00|No Change|

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Polygon_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Arbitrum_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Polygon_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231205_Multi_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023/AaveV3Arbitrum_IncreaseSupplyAndBorrowCapsAt100UtilizationDecember2023_20231205.t.sol)
- [Snapshot](No snapshot for direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-increase-supply-and-borrow-caps-at-100-utilization-december-2023/15754)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
