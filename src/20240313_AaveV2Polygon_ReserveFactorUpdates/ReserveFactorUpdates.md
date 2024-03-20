---
title: "Reserve Factor Updates (March 13, 2024)"
author: "dd0sxx_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/20"
---

## Simple Summary

This AIP is a continuation of proposal 41 on Governance v3 and increases the Reserve Factor (RF) for assets on Polygon v2 by 5.00%, up to a maximum of 99.99%.

## Motivation

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by up to 5%.

## Specification

The following parameters are to be updated as follows:

| Asset | Reserve Factor |
| ----- | -------------- |
| DAI   | 86.00%         |
| USDC  | 88.00%         |
| USDT  | 87.00%         |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/c4169a2ff29cc8aa83a4e954bcf0459cae422c4a/src/20240229_AaveV2Polygon_ReserveFactorUpdatesFebruary292024/AaveV2Polygon_ReserveFactorUpdatesFebruary292024_20240229.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/c4169a2ff29cc8aa83a4e954bcf0459cae422c4a/src/20240229_AaveV2Polygon_ReserveFactorUpdatesFebruary292024/AaveV2Polygon_ReserveFactorUpdatesFebruary292024_20240229.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/16)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
