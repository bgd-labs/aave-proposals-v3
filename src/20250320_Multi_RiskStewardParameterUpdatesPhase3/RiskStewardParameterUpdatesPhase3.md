---
title: "Risk Steward Parameter Updates Phase 3"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-risk-steward-parameter-updates-phase-3/21135"
snapshot: "https://snapshot.box/#/s:aave.eth/proposal/0x29d176e4d36f38c665ac39775577982339c6a3fcc488a36af73fbd5edfd422ff"
---

## Simple Summary

This proposal aims to update the Risk Steward parameters to enhance the efficiency of risk parameter management and reduce governance overhead.

## Motivation

The Risk Steward mechanism has proven to be an effective tool for managing risk parameters without requiring full governance proposals. After several months of successful operation, we propose updating the parameters to allow for more responsive risk management while maintaining appropriate safety constraints.

Technical service providers spend significant time reviewing risk parameter update AIPs, which could be more efficiently handled through the Risk Steward mechanism. With well-defined processes in place and months of successful operation, we can safely expand the scope of parameter adjustments allowed through this system.

## Specification

| Parameter                 | Current        | Proposed      |
| ------------------------- | -------------- | ------------- |
| Supply & Borrow Caps      | 100% relative  | (no change)   |
| Debt Ceiling              | 20% relative   | (no change)   |
| LST Cap adapter params    | 5% relative    | (no change)   |
| Stable price cap          | 0.5% relative  | (no change)   |
| Base Variable Borrow Rate | 0.5% absolute  | 1% absolute   |
| Slope 1                   | 0.5% absolute  | 1% absolute   |
| Slope 2                   | 5% absolute    | 20% absolute  |
| Optimal Point (Kink)      | 3% absolute    | (no change)   |
| Loan to Value (LTV)       | 0.25% absolute | 0.5% absolute |
| Liquidation Threshold     | 0.25% absolute | 0.5% absolute |
| Liquidation Bonus         | 0.5% absolute  | (no change)   |

(no change to minimum delay)

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Ethereum_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3EthereumLido_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3EthereumEtherFi_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Polygon_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Avalanche_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Optimism_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Arbitrum_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Gnosis_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Base_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Scroll_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3BNB_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Linea_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Celo_RiskStewardParameterUpdatesPhase3_20250320.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Sonic_RiskStewardParameterUpdatesPhase3_20250320.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Ethereum_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3EthereumLido_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3EthereumEtherFi_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Polygon_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Avalanche_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Optimism_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Arbitrum_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Metis_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Gnosis_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Base_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Scroll_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3BNB_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3ZkSync_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Linea_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Celo](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Celo_RiskStewardParameterUpdatesPhase3_20250320.t.sol), [AaveV3Sonic](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250320_Multi_RiskStewardParameterUpdatesPhase3/AaveV3Sonic_RiskStewardParameterUpdatesPhase3_20250320.t.sol)
- [Snapshot](https://snapshot.box/#/s:aave.eth/proposal/0x29d176e4d36f38c665ac39775577982339c6a3fcc488a36af73fbd5edfd422ff)
- [Discussion](https://governance.aave.com/t/arfc-risk-steward-parameter-updates-phase-3/21135)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
