---
title: "Reserve Factor Updates (February 15, 2024)"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/16"
snapshot: "No snapshot for Direct-to-AIP"
---

## Simple Summary

This AIP is a continuation of continuation of proposal 24 on Governance v3 and increases the Reserve Factor (RF) for assets on Polygon v2 by 5.00%, up to a maximum of 99.99%.

## Motivation

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by 5%.

## Specification

The following parameters are to be updated as follows:

| Asset | Reserve Factor |
| ----- | -------------- |
| DAI   | 76.00%         |
| USDC  | 78.00%         |
| USDT  | 77.00%         |
| wETH  | 99.99%         |
| MATIC | 96.00%         |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3e7494b0846e337e24c982a13c0645a3c57b00e5/src/20240208_AaveV2Polygon_ReserveFactorUpdatesFebruary152024/AaveV2Polygon_ReserveFactorUpdatesFebruary152024_20240208.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3e7494b0846e337e24c982a13c0645a3c57b00e5/src/20240208_AaveV2Polygon_ReserveFactorUpdatesFebruary152024/AaveV2Polygon_ReserveFactorUpdatesFebruary152024_20240208.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/16)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
