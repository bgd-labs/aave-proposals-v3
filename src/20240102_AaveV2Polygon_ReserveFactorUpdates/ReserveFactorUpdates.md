---
title: "Polygon V2 Reserve Factor Updates"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937"
---

## Simple Summary

This AIP is a continuation of AIP-284 and increases the Reserve Factor (RF) for assets on Polygon v2 by 5.00%, up to a maximum of 99.99%.

## Motivation

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by 5%.

## Specification

The following parameters are to be updated as follows:

| Asset | Reserve Factor |
| ----- | -------------- |
| DAI   | 61.00%         |
| USDC  | 63.00%         |
| USDT  | 62.00%         |
| wBTC  | 95.00%         |
| wETH  | 85.00%         |
| MATIC | 81.00%         |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240102_AaveV2Polygon_ReserveFactorUpdates/AaveV2Polygon_ReserveFactorUpdates_20240102.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240102_AaveV2Polygon_ReserveFactorUpdates/AaveV2Polygon_ReserveFactorUpdates_20240102.t.sol)
- [Snapshot](No snapshot for Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/14)

## Disclaimer

TokenLogic and karpatkey receive no compensation beyond Aave protocol for the creation of this proposal. TokenLogic and karpatkey are both delegates within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
