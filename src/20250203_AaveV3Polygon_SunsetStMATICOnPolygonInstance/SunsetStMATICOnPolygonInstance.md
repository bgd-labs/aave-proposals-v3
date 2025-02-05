---
title: "Sunset stMATIC on Polygon instance"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-sunset-stmatic-on-polygon-instance/20668"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0xae420f7c844f2ef26dd74a1ed1b4b197aad5b15a8b9c1795a0c205025988fd66"
---

## Simple Summary

Given [Lido’s recent announcement to sunset stMATIC](https://blog.lido.fi/lido-on-polygon-sunset/) (their Liquid Staking Token implementation on Polygon), we propose freezing the stMATIC reserve on the Aave V3 Polygon market. This freeze would prevent users from increasing supply or creating new borrow positions, while maintaining functionality for repayments, withdrawals, and liquidations.

## Motivation

The Lido community, through [LDO token holder voting](https://snapshot.org/?ref=blog.lido.fi#/s:lido-snapshot.eth/proposal/0x2f745cb0147791cf656ab292f872f8277ff9df5c9585dbc6622dbda88362d402), has decided to discontinue the stMATIC token on Polygon for two main reasons: limited user adoption and insufficient staking fee revenue to offset maintenance costs.

Between January 15-22, 2025, stMATIC withdrawals will be temporarily paused. Effective immediately, stMATIC will cease to accrue any staking yield throughout the sunsetting process. Users can redeem stMATIC for POL/MATIC through the Lido UI until June 16th, 2025. After this date, redemptions will remain possible indefinitely through direct smart contract interaction, as stMATIC will maintain 100% collateralization at all times.

### Current presence on Aave

Due to the MATIC-correlated emode, stMATIC’s primary use case on Aave has been for leveraged positions. Following the suspension of yield accrual, this utility diminishes, leaving no advantages to holding stMATIC over POL directly. The current supply of 25.79M stMATIC (valued at $14.29M) represents a significant volume requiring transition. Notably, the current 0% supply rate indicates that borrow demand for stMATIC is insufficient to generate meaningful yield for suppliers.

## Specification

Freeze the stMATIC reserve on the Aave V3 Polygon market.

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/07d6b3ad264f9611fa9744b174aaa02cde5e3af5/src/20250203_AaveV3Polygon_SunsetStMATICOnPolygonInstance/AaveV3Polygon_SunsetStMATICOnPolygonInstance_20250203.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/07d6b3ad264f9611fa9744b174aaa02cde5e3af5/src/20250203_AaveV3Polygon_SunsetStMATICOnPolygonInstance/AaveV3Polygon_SunsetStMATICOnPolygonInstance_20250203.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0xae420f7c844f2ef26dd74a1ed1b4b197aad5b15a8b9c1795a0c205025988fd66)
- [Discussion](https://governance.aave.com/t/arfc-sunset-stmatic-on-polygon-instance/20668)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
