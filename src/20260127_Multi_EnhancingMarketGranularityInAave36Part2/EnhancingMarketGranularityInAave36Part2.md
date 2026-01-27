---
title: "Enhancing Market Granularity in Aave 3.6: part 2"
author: "ChaosLabs (implemented by Aavechan Initiative @aci via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592"
---

## Simple Summary

## Motivation

## Specification

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Ethereum_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3EthereumLido_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Polygon_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Avalanche_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Arbitrum_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Base_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3BNB_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Linea_EnhancingMarketGranularityInAave36Part2_20260127.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Plasma_EnhancingMarketGranularityInAave36Part2_20260127.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Ethereum_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3EthereumLido_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Polygon_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Avalanche_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Arbitrum_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Base_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3BNB_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Linea_EnhancingMarketGranularityInAave36Part2_20260127.t.sol), [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260127_Multi_EnhancingMarketGranularityInAave36Part2/AaveV3Plasma_EnhancingMarketGranularityInAave36Part2_20260127.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
