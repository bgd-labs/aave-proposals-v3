---
title: "Increase Borrow Slope1 to all Stablecoins across all Aave Instances"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-increase-borrow-slope1-to-all-stablecoins-across-all-aave-instances/19979"
---

## Simple Summary

This proposal recommends increasing the **borrow slope1** parameter for stablecoins across all Aave V3 Instances to **12.5%**. This adjustment aims to align interest rate models with the updated **Stable Debt Reserve (SDR)** strategy, promoting sustainability, better risk management, and optimal utilization of the protocol’s resources.

## Motivation

The current market environment presents a unique opportunity to optimize Aave’s interest rate parameters. With the introduction of sUSDe as E-Mode collateral and general market sentiment leading to higher desire for borrowing, we are seeing significantly higher utilisation in the stablecoin market. This adjustment to the borrow slope1 will better align Aave’s interest rates with prevailing market conditions, potentially leading to:

- Increased protocol revenue through better rate optimization
- Enhanced capital efficiency by maintaining competitive lending rates at lower volatility.

Additionally, this change will ensure appropriate risk compensation for stablecoin lenders.

## Specification

| **Market**        | **Asset** | **Current Slope1** | **Recommended Slope1** |
| ----------------- | --------- | ------------------ | ---------------------- |
| Ethereum V2       | USDC      | 5.5%               | 9.5%                   |
| Ethereum V2       | USDT      | 5.5%               | 9.5%                   |
| Ethereum V2       | DAI       | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | USDC      | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | USDT      | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | USDe      | 9.0%               | 9.5%                   |
| Ethereum V3 Core  | FRAX      | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | DAI       | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | LUSD      | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | PYUSD     | 5.5%               | 9.5%                   |
| Ethereum V3 Core  | crvUSD    | 5.5%               | 9.5%                   |
| Ethereum V3 Prime | USDC      | 5.5%               | 9.5%                   |
| Avalanche V3      | USDC      | 5.5%               | 9.5%                   |
| Avalanche V3      | USDT      | 5.5%               | 9.5%                   |
| Avalanche V3      | DAI       | 5.5%               | 9.5%                   |
| Avalanche V3      | FRAX      | 5.5%               | 9.5%                   |
| Polygon V3        | USDC      | 5.5%               | 9.5%                   |
| Polygon V3        | USDC.e    | 10.0%              | 10.5%                  |
| Polygon V3        | USDT      | 5.5%               | 9.5%                   |
| Polygon V3        | DAI       | 5.5%               | 9.5%                   |
| Polygon V3        | EURS      | 5.5%               | 9.5%                   |
| Optimism V3       | USDC      | 5.5%               | 9.5%                   |
| Optimism V3       | USDT      | 5.5%               | 9.5%                   |
| Optimism V3       | DAI       | 5.5%               | 9.5%                   |
| Optimism V3       | sUSD      | 5.5%               | 9.5%                   |
| Optimism V3       | LUSD      | 5.5%               | 9.5%                   |
| Optimism V3       | USDC.e    | 6.5%               | 10.5%                  |
| Arbitrum V3       | USDC      | 5.5%               | 9.5%                   |
| Arbitrum V3       | USDC.e    | 6.5%               | 10.5%                  |
| Arbitrum V3       | USDT      | 5.5%               | 9.5%                   |
| Arbitrum V3       | DAI       | 5.5%               | 9.5%                   |
| Arbitrum V3       | LUSD      | 5.5%               | 9.5%                   |
| Arbitrum V3       | FRAX      | 5.5%               | 9.5%                   |
| Arbitrum V3       | GHO       | 12%                | 9.5%                   |
| Base V3           | USDC      | 5.5%               | 9.5%                   |
| Base V3           | USDbC     | 10.0%              | 10.5%                  |
| Metis V3          | m.USDC    | 6.0%               | 9.5%                   |
| Metis V3          | m.USDT    | 6.0%               | 9.5%                   |
| Metis V3          | m.DAI     | 7.0%               | 9.5%                   |
| BNB Chain V3      | USDT      | 5.5%               | 9.5%                   |
| BNB Chain V3      | USDC      | 5.5%               | 9.5%                   |
| BNB Chain V3      | FDUSD     | 5.5%               | 9.5%                   |
| Scroll V3         | USDC      | 5.5%               | 9.5%                   |
| Gnosis V3         | WXDAI     | 5.5%               | 9.5%                   |
| Gnosis V3         | USDC      | 5.5%               | 9.5%                   |
| Gnosis V3         | EURe      | 5.5%               | 9.5%                   |
| Gnosis V3         | USDC.e    | 9%                 | 10.5%                  |
| ZKSync V3         | USDC      | 5.5%               | 9.5%                   |
| ZKSync V3         | USDT      | 5.5%               | 9.5%                   |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV2Ethereum_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Ethereum_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3EthereumLido_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Polygon_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Avalanche_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Optimism_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Arbitrum_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Metis_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Base_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Gnosis_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Scroll_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3ZkSync_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV2Ethereum_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Ethereum_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3EthereumLido_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Polygon_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Avalanche_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Optimism_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Arbitrum_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Metis_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Base_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Gnosis_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3Scroll_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3BNB_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20241201_Multi_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances/AaveV3ZkSync_IncreaseBorrowSlope1ToAllStablecoinsAcrossAllAaveInstances_20241201.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-increase-borrow-slope1-to-all-stablecoins-across-all-aave-instances/19979)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
