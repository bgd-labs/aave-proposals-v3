---
title: "Optimize ETH-correlated asset parameters"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-optimize-eth-correlated-asset-parameters/17886"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x3d79b416cfa6c70a85d03d07148d3a2025b88f294694d76fb101167af332c2fc"
---

## Simple Summary

This proposal seeks to update parameters on ETH-correlated assets and coordinate caps management to improve Aave efficiency.

## Motivation

ETH and ETH-correlated assets are the largest reserves in the Aave protocol, leading to their usage as collateral and being one of the protocol’s largest revenue drivers.

ETH is mainly used for two use cases:

1. Collateral to borrow stablecoins
2. Borrowed using ETH-correlated assets to leverage loop a staking/restaking yield.

This second use case is very sensible to the borrowing cost of wETH and, if kept unchecked, can lead to a negative yield experience for some long-term users having significant leverage positions.

To mitigate this, we propose to optimize the ETH-correlated assets parameters on all markets, and we seek governance greenlight on a cap management policy by risk stewards.

## Specification

wETH Slope 1 is optimized to 2.7% on all Aave instances, ensuring LST/wETH loops profitability

Caps & rate management policy (not enforced with this AIP payload):

- Maintain a minimum 25 bps discount between stETH 30-day avg APR and Slope 1 wETH borrow cost with monthly AIPs to enforce this policy
- Support research and development to create new InterestRateStrategy contracts for wETH implementing this policy algorithmically.
- Keep wETH borrow cap increases ceiling at 90% of currently supplied wETH on all networks

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Ethereum_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Polygon_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Avalanche_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Optimism_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Arbitrum_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Base_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Gnosis_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Ethereum_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Polygon_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Avalanche_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Optimism_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Arbitrum_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Metis_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Base_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Gnosis_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3Scroll_OptimizeETHCorrelatedAssetParameters_20240612.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240612_Multi_OptimizeETHCorrelatedAssetParameters/AaveV3BNB_OptimizeETHCorrelatedAssetParameters_20240612.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x3d79b416cfa6c70a85d03d07148d3a2025b88f294694d76fb101167af332c2fc)
- [Discussion](https://governance.aave.com/t/arfc-optimize-eth-correlated-asset-parameters/17886)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
