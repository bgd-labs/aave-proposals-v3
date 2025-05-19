---
title: "Configuration maintenance"
author: "BGD Labs @bgdlabs"
discussions: TODO
snapshot: TODO
---

## Simple Summary

This proposal aims to fix inconsistent / suboptimal configurations across various pools.

## Motivation

### eModes

When Aave v3.2 went live, the existing eModes were just migrated to liquid eModes. What this means that if an asset was flagged as e.g. eMode `1` on v3.2 it was enabled as borrowable and as collateral on eMode `1`.
This was done to not distrupt existing positions and also to isolate the upgrade from any configuration changes.
As some time has passed now, it is a good idea to disable unintended eMode configurations, namely we propose to:

- deprecate stablecoin eModes by disabling all borrowable assets
- deprecated LSTs from being borrowable in the "correlated" eModes category

This will not have any effects on existing positions, but will prevent increased borrows of the disabled assets within the eMode.

### Borrowable

Some assets that were originally listed as borrowable have later been "disabled" by setting their borrowCap to 1 via risk stewards.
While this workaround suits the needs, the "correct" thing to do, is to disable borrowing. Therefore this proposal permanently disables borrowing for:

- LBTC and rsETH on Mainnet
- sUSD on Optimism
- MaticX on Polygon

### v2 Rates

In [aip 261](https://vote.onaave.com/proposal/?proposalId=261) the rates for v2 assets were aligned to standartize interest rates.
This resulted in some unintended increase in interest rate on renFil, which has close to zero secondary market liquidity and thus makes it almost impossible for borrowers to repay their debt.
Therefore we recommend reverting to the previous ZeroInterestRateStrategy to cut growth.

## Specification

The proposal uses the config engine to implemented the described changes.
In addition it calls to revert the interest rate on Aave V2 Ethereum:

```
AaveV2Ethereum.POOL_CONFIGURATOR.setReserveInterestRateStrategyAddress(
      AaveV2EthereumAssets.renFIL_UNDERLYING,
      0x311C866D55456e465e314A3E9830276B438A73f0
);
```

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV2Ethereum_ConfigurationMaintenance_20250519.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Ethereum_ConfigurationMaintenance_20250519.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Polygon_ConfigurationMaintenance_20250519.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Avalanche_ConfigurationMaintenance_20250519.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Optimism_ConfigurationMaintenance_20250519.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Arbitrum_ConfigurationMaintenance_20250519.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Base_ConfigurationMaintenance_20250519.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Gnosis_ConfigurationMaintenance_20250519.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Scroll_ConfigurationMaintenance_20250519.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250519_Multi_ConfigurationMaintenance/AaveV3ZkSync_ConfigurationMaintenance_20250519.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV2Ethereum_ConfigurationMaintenance_20250519.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Ethereum_ConfigurationMaintenance_20250519.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Polygon_ConfigurationMaintenance_20250519.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Avalanche_ConfigurationMaintenance_20250519.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Optimism_ConfigurationMaintenance_20250519.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Arbitrum_ConfigurationMaintenance_20250519.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Base_ConfigurationMaintenance_20250519.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Gnosis_ConfigurationMaintenance_20250519.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250519_Multi_ConfigurationMaintenance/AaveV3Scroll_ConfigurationMaintenance_20250519.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250519_Multi_ConfigurationMaintenance/AaveV3ZkSync_ConfigurationMaintenance_20250519.t.sol)
  [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
