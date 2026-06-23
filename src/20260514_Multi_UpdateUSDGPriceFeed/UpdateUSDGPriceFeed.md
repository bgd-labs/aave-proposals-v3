---
title: "Update USDG Price Feed on Aave V3 Instances"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/technical-maintenance-proposals/15274/132"
---

### Simple Summary

Replace the existing `USDG` price feed on the applicable Aave V3 instances (Ethereum Core and X Layer) with a price cap adapter, set to a maximum price of 1.04 and using the Chainlink USDG feed as the underlying source. The same price adapter must also be used for the `PT-USDG-28MAY2026` asset, given that its maturity is now expired.

### Motivation

Per [LlamaRisk’s latest assessment](https://governance.aave.com/t/direct-to-aip-onboard-pt-usdg-24sep2026-to-aave-v4-on-ethereum/24942/6), liquidity conditions for USDG have improved such that the Chainlink feed now provides higher-quality pricing than the source currently in production. Following the same strategy already applied to other assets across the protocol, the proposal wraps this feed in a price adapter with a cap of 1.04, ensuring the reported price tracks Chainlink while remaining bounded on the upside.

### Specification

Upon execution, on each applicable instance the proposal will call `setAssetSources([USDG_ADDRESS], [PRICE_CAP_ADAPTER])` on the Aave V3 oracle, pointing USDG at the newly deployed price cap adapter for that network. Each adapter uses the corresponding Chainlink USDG feed as its underlying source and the cap price listed below.

Since the maturity of the PT-USDG-28MAY2026 asset is now expired, the same price adapter must be used as well.

| **Pamateter (Ethereum)** | **Value**                                  |
| ------------------------ | ------------------------------------------ |
| Chainlink Price Feed     | 0x14f0737d6b705259e521EA6E9E3506AC78dBd311 |
| Price Adapter            | 0x83D20dEEdcd4aC1313496c8CBcAad0fa298c0CE4 |
| Price cap                | 1.04                                       |

| **Pamateter (X Layer)** | **Value**                                  |
| ----------------------- | ------------------------------------------ |
| Chainlink Price Feed    | 0x385C6bDDE06b0E438319bF4ddBfFe51C521ABf3D |
| Price Adapter           | 0xe00B2732396a1f047d4A00e0165025A9cF400245 |
| Price cap               | 1.04                                       |

## References

- Implementation: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3XLayer_UpdateUSDGPriceFeed_20260514.sol)
- Tests: [AaveV3Ethereum](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3Ethereum_UpdateUSDGPriceFeed_20260514.t.sol), [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260514_Multi_UpdateUSDGPriceFeed/AaveV3XLayer_UpdateUSDGPriceFeed_20260514.t.sol)
- [Discussion](https://governance.aave.com/t/technical-maintenance-proposals/15274/132)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
