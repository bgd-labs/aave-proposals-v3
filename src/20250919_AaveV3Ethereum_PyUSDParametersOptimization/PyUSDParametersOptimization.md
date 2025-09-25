---
title: "pyUSD Parameters Optimization"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-pyusd-parameters-optimization/23082/2"
---

## Simple Summary

This proposal updates the pyUSD reserve configuration on Ethereum v3 Core.

## Motivation

This publication proposes aligning the Reserver Factor and Uoptimal for the pyUSD Reserve with various other stables ahead of a potential incentive campaign from PayPal.

The key changes include:

- Adjusting pyUSD Reserve Factor (RF) from 20% to 10%: With <$15M in liquidity within the Reserve, decreasing the RF routes a larger portion of the interest paid by users who borrow pyUSD to users who deposit pyUSD.
- Adjusting Optimal Utilization (Uoptimal) from 80% to 90%: We recommend to increasing the Uoptimal of pyUSD, to better reflect the borrow and supply dynamism for these assets.

## Specification

The following pyUSD Reserve parameters are to be updated:

| Parameters     | Current Value | Updated Value |
| -------------- | ------------- | ------------- |
| Asset          | PYUSD         | PYUSD         |
| UOptimal       | 80%           | 90%           |
| Reserve Factor | 20%           | 10%           |
| Slope 1        | 10.5%         | 6.5%          |
| LTV            | 75%           | 0%            |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250919_AaveV3Ethereum_PyUSDParametersOptimization/AaveV3Ethereum_PyUSDParametersOptimization_20250919.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250919_AaveV3Ethereum_PyUSDParametersOptimization/AaveV3Ethereum_PyUSDParametersOptimization_20250919.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-pyusd-parameters-optimization/23082/2)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
