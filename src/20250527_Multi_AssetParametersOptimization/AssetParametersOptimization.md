---
title: "Asset Parameters Optimization"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-asset-parameters-optimization"
---

## Simple Summary

This proposal aims to optimize parameters of certain assets across networks where it is supported.

## Motivation

This proposal aims to optimize the Reserver Factor of various stables and also optimize the Optimal Utilization of various assets to better reflect the market mechanisms.

The key changes include:

* **Adjusting Reserve Factor (RF)** of various stables from 10% to 20%: increasing the RF routes a larger portion of the interest paid by users to Aave DAO’s Treasury. This does not impact users’ health factor directly while providing better cushion for assets at low utilization.
* **Adjusting Optimal Utilization (Uoptimal)** of various assets to 45%: We recommend to decrease Uoptimal of CRV, BAL and SNX to 45%, to better reflect the borrow and supply dynamism for these assets.

## Specification

|Market|**Asset**|Current Reserve Factor|Recommended Reserve Factor|
| --- | --- | --- | --- |
|Ethereum Core|crvUSD|10%|20%|
|Ethereum Core|rlUSD|10%|20%|
|Ethereum Core|USDtb|10%|20%|
|Celo|USDT|10%|20%|

|Market|**Asset**|Current Optimal Utilization|Recommended Optimal Utilization|
| --- | --- | --- | --- |
|Ethereum Core|CRV|70%|45%|
|Ethereum Core|BAL|80%|45%|
|Ethereum Core|SNX|80%|45%|
|Polygon|CRV|70%|45%|
|Polygon|BAL|80%|45%|

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Ethereum_AssetParametersOptimization_20250527.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Polygon_AssetParametersOptimization_20250527.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Celo_AssetParametersOptimization_20250527.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Ethereum_AssetParametersOptimization_20250527.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Polygon_AssetParametersOptimization_20250527.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Celo_AssetParametersOptimization_20250527.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-asset-parameters-optimization)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
