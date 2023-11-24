---
title: "Freeze price feeds on v3 Harmony"
author: "BGD Labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/6"
---

## Simple Summary

Following Chainlink’s Harmony deprecation, replace all existing price feeds by Chainlink on Aave v3 Harmony with fixed price adapters (with the last known Chainlink price).

Additionally, update interest rate strategies to one with exact zero values.

## Motivation

As Harmony remains unstable following the bridge exploit, and [Chainlink is planning to shut down all the price feeds on the network](https://docs.chain.link/data-feeds/price-feeds/addresses?network=harmony&page=1), we believe that the most neutral solution (since there are still users who can withdraw) is to replace the Chainlink feeds with fixed adapters that return the last available price.

Additionally, since the pool dynamics are non-functional, accruing any debt makes no difference, even if it was already set to minimal. Therefore, we are going to replace the interest rate strategies for every asset with a zero-interest one.

## Specification

Call `AaveV3Harmony.ORACLE.setAssetSources()` passing the appropriate parameters to replace the price feeds of the assets on the Aave v3 Harmony Pool.
For each asset on the pool, call `PoolConfigurator.setReserveInterestRateStrategyAddress(asset, zeroInterestRateStrategy)` to replace their rate strategy.

## References

- Implementation: [AaveV3Harmony](https://github.com/bgd-labs/aave-proposals-v3/blob/a586fef4b2505f1a38d6eb9a9e68d3fd9f9d0465/src/20231122_AaveV3Harmony_FreezePriceFeedsOnV3Harmony/AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122.sol)
- Tests: [AaveV3Harmony](https://github.com/bgd-labs/aave-proposals-v3/blob/a586fef4b2505f1a38d6eb9a9e68d3fd9f9d0465/src/20231122_AaveV3Harmony_FreezePriceFeedsOnV3Harmony/AaveV3Harmony_FreezePriceFeedsOnV3Harmony_20231122.t.sol)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/6)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
