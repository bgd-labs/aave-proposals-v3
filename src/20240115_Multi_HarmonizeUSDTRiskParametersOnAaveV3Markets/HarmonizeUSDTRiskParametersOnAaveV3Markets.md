---
title: "Harmonize USDT Risk Parameters on Aave V3 Markets"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-harmonize-usdt-risk-parameters-on-aave-v3-markets/15815"
---

## Simple Summary

USDT has various risk parameters across the various Aave v3 markets. This proposals aims to harmonize the risk parameters to better align the markets by removing USDT from isolation mode and normalizing risk parameters.

## Motivation

USDT has seen strong borrow demand across networks with borrow utilization over 50% on Aave v3 Ethereum Mainnet and good utilization on secondary networks. However, the various markets currently have different risk parameters, leading to some inefficiency.

This proposal aims to bring the various USDT markets in line with a single set of LTV, liquidation threshold, and liquidation bonus parameters.

## Specification

The proposal sets the LT/LTV of USDT on all deployments at 80/77, matching that of DAI and USDC on v3 Ethereum. Regarding the LB, it will stay the same at 5% on the L2s and 4.5% on Ethereum.

| Asset  | Network   | Current Liquidation Threshold | New Liquidation Threshold | Current LTV | New LTV |
| ------ | --------- | ----------------------------- | ------------------------- | ----------- | ------- |
| USDT   | Mainnet   | 76%                           | 80%                       | 74%         | 77%     |
| USDT   | Optimism  | 80%                           | 80%                       | 75%         | 77%     |
| USDT   | Polygon   | 80%                           | 80%                       | 75%         | 77%     |
| USDT   | Arbitrum  | 80%                           | 80%                       | 75%         | 77%     |
| USDt   | Avalanche | 81%                           | 80%                       | 75%         | 77%     |
| m.USDT | Metis     | 80%                           | 80%                       | 75%         | 77%     |
| USDT   | BNB       | 80%                           | 80%                       | 75%         | 77%     |

This proposal will also remove USDT from isolation mode on the following markets (please notes that once an asset is removed from isolation mode it can't be added back again):

- Optimism
- Polygon
- Arbitrum

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Ethereum_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Polygon_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Avalanche_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Optimism_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Arbitrum_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Metis_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Ethereum_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Polygon_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Avalanche_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Optimism_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Arbitrum_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240115_Multi_HarmonizeUSDTRiskParametersOnAaveV3Markets/AaveV3Metis_HarmonizeUSDTRiskParametersOnAaveV3Markets_20240115.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x285c3f9ef8ae3e0286ce18b45dc7605174c3fb61edf1df34ed5d8f5aa621ab9d)
- [Discussion](https://governance.aave.com/t/arfc-harmonize-usdt-risk-parameters-on-aave-v3-markets/15815)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
