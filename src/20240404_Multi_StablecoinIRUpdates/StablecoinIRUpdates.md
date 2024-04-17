---
title: "StablecoinIRUpdates"
author: "Chaos Labs, ACI"
discussions: "https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3/16864/5"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xe2dd228640c3cad93f5418c40c4b5743b3c6c85aa0aae9eee53cbdbca2ed5c2d"
---

## Simple Summary

A proposal to increase stablecoin Interest Rate parameters across all Aave deployments.

## Motivation

To adapt to the current market conditions and optimize the utilization of stablecoins on Aave, we propose to update the Interest Rate parameters of stablecoins across all Aave deployments.

This will help to maintain the competitiveness of Aave's stablecoin markets and ensure that the interest rates are aligned with the market conditions.

This will also increase Aave DAO revenue by increasing the utilization of stablecoins and cost of borrowing them.

## Specification

This AIP update the Slope1 parameters of Aave stablecoins to 12% Bridged USDC is raised to 13% to enable native USDC a competitive advantage. It also increase the uOptimal parameter of DAI, USDC & USDT assets to 92% on Aave V3 Ethereum.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV2Ethereum_StablecoinIRUpdates_20240404.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV2Polygon_StablecoinIRUpdates_20240404.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV2Avalanche_StablecoinIRUpdates_20240404.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Ethereum_StablecoinIRUpdates_20240404.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Polygon_StablecoinIRUpdates_20240404.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Avalanche_StablecoinIRUpdates_20240404.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Optimism_StablecoinIRUpdates_20240404.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Arbitrum_StablecoinIRUpdates_20240404.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Base_StablecoinIRUpdates_20240404.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Gnosis_StablecoinIRUpdates_20240404.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Scroll_StablecoinIRUpdates_20240404.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3BNB_StablecoinIRUpdates_20240404.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV2Ethereum_StablecoinIRUpdates_20240404.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV2Polygon_StablecoinIRUpdates_20240404.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV2Avalanche_StablecoinIRUpdates_20240404.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Ethereum_StablecoinIRUpdates_20240404.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Polygon_StablecoinIRUpdates_20240404.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Avalanche_StablecoinIRUpdates_20240404.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Optimism_StablecoinIRUpdates_20240404.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Arbitrum_StablecoinIRUpdates_20240404.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Base_StablecoinIRUpdates_20240404.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Gnosis_StablecoinIRUpdates_20240404.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3Scroll_StablecoinIRUpdates_20240404.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/0c854761280d75cb92e4218a43e7997c205f03d3/src/20240404_Multi_StablecoinIRUpdates/AaveV3BNB_StablecoinIRUpdates_20240404.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xe2dd228640c3cad93f5418c40c4b5743b3c6c85aa0aae9eee53cbdbca2ed5c2d)
- [Discussion](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3/16864)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
