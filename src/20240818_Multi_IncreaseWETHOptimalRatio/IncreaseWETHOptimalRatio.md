---
title: "Increase WETH Optimal Ratio"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-increase-weth-optimal-ratio-to-90-on-all-aave-markets/18556"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x2930599cae3cec0a16bd0aef13524347e0c5e85cff7dd66ae9b2bed90fc5d1fe"
---

## Simple Summary

This proposal will increase the optimal usageRatio from 80% to 90% across all aave v3 deployments including Gnosis, Polygon, Metis, Base, Avalanche and Scroll

## Motivation

Currently, the optimal usage ratios vary across different Aave instances, reflecting a balance between liquidity utilization and risk management. By increasing the optimal usage ratio for WETH to 90%, higher returns for liquidity providers and improved borrowing conditions for users can be achieved.

## Specification

This proposal will increase WETH Optimal Usage Ratio to 90% on the following markets which are currently at 80%, in order to unify them all:

Gnosis V3

Polygon V3

Metis V3

Base V3

Avalanche V3

Scroll V3

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Polygon_IncreaseWETHOptimalRatio_20240818.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Avalanche_IncreaseWETHOptimalRatio_20240818.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Metis_IncreaseWETHOptimalRatio_20240818.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Base_IncreaseWETHOptimalRatio_20240818.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Scroll_IncreaseWETHOptimalRatio_20240818.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Polygon_IncreaseWETHOptimalRatio_20240818.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Avalanche_IncreaseWETHOptimalRatio_20240818.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Metis_IncreaseWETHOptimalRatio_20240818.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Base_IncreaseWETHOptimalRatio_20240818.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Gnosis_IncreaseWETHOptimalRatio_20240818.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/a0ddfdc8504eec2e76d47e918cb7ff3741a4b7b4/src/20240818_Multi_IncreaseWETHOptimalRatio/AaveV3Scroll_IncreaseWETHOptimalRatio_20240818.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2930599cae3cec0a16bd0aef13524347e0c5e85cff7dd66ae9b2bed90fc5d1fe)
- [Discussion](https://governance.aave.com/t/arfc-increase-weth-optimal-ratio-to-90-on-all-aave-markets/18556)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
