---
title: "Deprecation of Low Demand Volatile Assets on Aave V3 Instances"
author: "Aave-chan Initiative"
discussions: "https://governance.aave.com/t/arfc-deprecation-of-low-demand-volatile-assets-on-aave-v3-instances/23261"
snapshot: Direct-to-AIP
---

## Simple Summary

This AIP is the second part of the deprecation of low demand asset proposed by Chaos Labs. It sets the LTV of some of them to 0%.

## Motivation

A full run down of the motivation is available on the [governance forum](https://governance.aave.com/t/arfc-deprecation-of-low-demand-volatile-assets-on-aave-v3-instances/23261/1).

## Specification

| **Instance**  | **Asset** | **Current LTV** | **Recommended LTV** |
| ------------- | --------- | --------------- | ------------------- |
| ZkSync        | ZK        | 40%             | 0                   |
| Ethereum Core | UNI       | 65%             | 0                   |
| Ethereum Core | CRV       | 35%             | 0                   |
| Ethereum Core | BAL       | 57%             | 0                   |
| Ethereum Core | ENS       | 39%             | 0                   |
| Ethereum Core | LDO       | 40%             | 0                   |
| BNB           | Cake      | 55%             | 0                   |
| Ethereum Core | 1INCH     | 57%             | 0                   |
| Metis         | METIS     | 30%             | 0                   |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3Ethereum_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3BNB_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/zksync/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3ZkSync_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3Ethereum_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3Metis_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3BNB_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/f926ee63f67b3d1be858797063fafe9078eae67d/zksync/src/20251023_Multi_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances/AaveV3ZkSync_DeprecationOfLowDemandVolatileAssetsOnAaveV3Instances_20251023.t.sol)
  Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-deprecation-of-low-demand-volatile-assets-on-aave-v3-instances/23261)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
