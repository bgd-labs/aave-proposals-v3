---
title: "Enhancing Market Granularity in Aave v3.6: Part 1"
author: "Chaos Labs (implemented by the ACI via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592"
---

## Simple Summary

This proposal leverages the configurability improvements introduced in [Aave v3.6](https://governance.aave.com/t/arfc-bgd-aave-v3-6/23172/2) to strengthen risk isolation and improve parameter clarity. Specifically, it introduces:

- LTV0 for assets not intended to serve as collateral outside of eModes.
- Non-borrowable status for assets whose use cases are restricted to within their respective eModes.
- Exclusive eMode participation, ensuring these assets are only active within targeted, high-correlation environments.

This aims to reduce systemic exposure, simplify risk management, and enable cleaner differentiation between general market assets and those intended for correlated or high-efficiency lending environments.

**This AIP is split into 2 parts, this one will only cover instances only instances covered by Aave V3.6 part 1. A second AIP will cover the rest of the instances**

## Motivation

## Specification

The following asset got their status as collateral removed:

| **Instance** | **Asset** |
| ------------ | --------- |
| Optimism     | LINK      |
| Optimism     | AAVE      |
| Optimism     | OP        |
| Optimism     | rETH      |
| Optimism     | USDC.e    |
| Optimism     | sUDC      |
| Gnosis       | sDAI      |
| ZKSync       | wstETH    |
| ZKSync       | sUSDe     |
| ZKSync       | wrsETH    |
| Metis        | mUSDC     |
| Metis        | mUSDT     |

The following asset got their status as borrowable asset removed:

| **Instance** | **Asset** |
| ------------ | --------- |
| Optimism     | USDC.e    |
| Optimism     | wstETH    |
| Optimism     | LINK      |
| Optimism     | LUSD      |
| Optimism     | OP        |
| Optimism     | rETH      |
| Gnosis       | wstETH    |
| Gnosis       | WETH      |
| Scroll       | wstETH    |
| Scroll       | weETH     |
| Scroll       | SCR       |
| ZKSync       | wstETH    |
| ZKSync       | WETH      |
| ZKSync       | ZK        |
| Celo         | Celo      |
| Metis        | mDAI      |
| Metis        | WETH      |

## Disclaimer

Chaos Labs requested disabling Optimism sUSD as collateral, but it was already disabled.
Disabling of weETH borrowing on ZkSync was also omitted as it is already disabled.

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Metis_EnhancingMarketGranularityInAaveV36_20260112.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Gnosis_EnhancingMarketGranularityInAaveV36_20260112.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Scroll_EnhancingMarketGranularityInAaveV36_20260112.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Optimism_EnhancingMarketGranularityInAaveV36_20260112.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Metis_EnhancingMarketGranularityInAaveV36_20260112.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Gnosis_EnhancingMarketGranularityInAaveV36_20260112.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Scroll_EnhancingMarketGranularityInAaveV36_20260112.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3ZkSync_EnhancingMarketGranularityInAaveV36_20260112.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260112_Multi_EnhancingMarketGranularityInAaveV36/AaveV3Celo_EnhancingMarketGranularityInAaveV36_20260112.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-enhancing-market-granularity-in-aave-v3-6-restricting-borrowability-and-collateralization-outside-of-liquid-emodes/23592)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
