---
title: "Reserve Factor Updates - Polygon Aave v2"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/5"
---

## Simple Summary

This AIP is a continuation of [AIP 284](https://app.aave.com/governance/proposal/284/) and increases the Reserve Factor (RF) for assets on Polygon v2 by 5%, up to a maximum of 99.99%.

## Motivation

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by 5%.

## Specification

The following parameters are to be updated as follows:

| Asset | Reserve Factor |
| ----- | -------------- |
| DAI   | 46.00%         |
| USDC  | 48.00%         |
| USDT  | 47.00%         |
| wBTC  | 80.00%         |
| wETH  | 70.00%         |
| MATIC | 66.00%         |
| BAL   | 57.00%         |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/7f6a99298d8f5cb95d05d80ec03e5090014071be/src/20231103_AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2/AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/7f6a99298d8f5cb95d05d80ec03e5090014071be/src/20231103_AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2/AaveV2Polygon_ReserveFactorUpdatesPolygonAaveV2_20231103.t.sol)
- Snapshot: No snapshot for Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/5)

# Disclaimer

The author, TokenLogic, receives no payment from anyone, including Aave DAO, for this proposal. TokenLogic is a delegate within the Aave community.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
