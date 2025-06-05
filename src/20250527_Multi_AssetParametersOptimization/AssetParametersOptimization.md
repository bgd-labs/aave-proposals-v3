---
title: "Asset Parameters Optimization"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/direct-to-aip-asset-parameters-optimization/22178"
---

## Simple Summary

This proposal aims to optimize parameters of certain assets across networks where it is supported.

## Motivation

This proposal aims to optimize the Reserver Factor of various stables and also optimize the Optimal Utilization of various assets to better reflect the market mechanisms.

The key changes include:

* **Adjusting Reserve Factor (RF)** of various stables from 10% to 20%: increasing the RF routes a larger portion of the interest paid by users to Aave DAO’s Treasury. This does not impact users’ health factor directly while providing better cushion for assets at low utilization.
* **Adjusting Optimal Utilization (Uoptimal)** of various assets to 45%: We recommend to decrease Uoptimal of CRV, BAL and SNX to 45%, to better reflect the borrow and supply dynamism for these assets.

## Specification

|**Market**|**Asset**|**Current RF**|**Rec. RF**|
| --- | --- | --- | --- |
|Ethereum Core|crvUSD|10%|20%|
|Ethereum Core|RLUSD|10%|20%|
|Ethereum Core|USDtb|10%|20%|
|Celo|USDT|10%|20%|

|Deployment|Asset|Current UOptimal|Rec. UOptimal|Current Base|Rec. Base|Current Slope 1|Rec. Slope 1|Current Slope 2|Rec. Slope 2|
| --- | --- | --- | --- | --- | --- | --- | --- | --- | --- |
|Ethereum Core|CRV|70%|45%|3%|-|14%|10%|300%|150%|
|Ethereum Core|SNX|80%|45%|3%|-|15%|-|100%|150%|
|Ethereum Core|BAL|80%|45%|5%|-|22%|15%|150%|-|
|Ethereum Core|RLUSD|80%|-|0%|4%|6.5%|2.5%|50%|-|
|Polygon|CRV|70%|45%|3%|-|14%|10%|300%|150%|
|Polygon|BAL|80%|45%|5%|-|22%|15%|150%|-|

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Ethereum_AssetParametersOptimization_20250527.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Polygon_AssetParametersOptimization_20250527.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Celo_AssetParametersOptimization_20250527.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Ethereum_AssetParametersOptimization_20250527.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Polygon_AssetParametersOptimization_20250527.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250527_Multi_AssetParametersOptimization/AaveV3Celo_AssetParametersOptimization_20250527.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-asset-parameters-optimization/22178)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
