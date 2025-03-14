---
title: "Stablecoins Interest Rate Curve Update"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-stablecoin-interest-rate-curve-update-03-04-2025/21269"
---

## Simple Summary

In light of recent market changes, Chaos Labs recommends setting the target borrow rate for most stablecoins to 6.50%. These changes would be implemented via the direct-to-AIP process.

## Motivation

The utilization for stablecoins across Aave has resumed falling after a brief improvement following the last IR curve adjustment, calling for a further reduction in target rates to better align with the market-priced interest rate.

A closer look at the largest stablecoin markets indicates that borrow rates have stabilized between 6% and 8%.

As a result, we recommend setting the target rate for all stablecoins to 6.5%;

Please note that GHO, USDS, and pyUSD are managed separately and, thus, are not included in these recommendations.

## Specification

| Protocol | Instance         | Asset  | **Current Slope1** | **Rec. Slope1** |
| -------- | ---------------- | ------ | ------------------ | --------------- |
| Aave V3  | Ethereum Core    | USDC   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Core    | DAI    | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Core    | USDT   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Core    | LUSD   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Core    | FRAX   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Core    | crvUSD | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Core    | USDe   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum Prime   | USDC   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum EtherFi | USDC   | 8.50%              | 6.50%           |
| Aave V3  | Ethereum EtherFi | FRAX   | 8.50%              | 6.50%           |
| Aave V3  | Arbitrum         | DAI    | 9%                 | 6.50%           |
| Aave V3  | Arbitrum         | USDT   | 9%                 | 6.50%           |
| Aave V3  | Arbitrum         | LUSD   | 9%                 | 6.50%           |
| Aave V3  | Arbitrum         | USDC   | 9%                 | 6.50%           |
| Aave V3  | Arbitrum         | FRAX   | 9%                 | 6.50%           |
| Aave V3  | Optimism         | DAI    | 9%                 | 6.50%           |
| Aave V3  | Optimism         | USDT   | 9%                 | 6.50%           |
| Aave V3  | Optimism         | sUSD   | 9%                 | 6.50%           |
| Aave V3  | Optimism         | LUSD   | 9%                 | 6.50%           |
| Aave V3  | Optimism         | USDC   | 9%                 | 6.50%           |
| Aave V3  | Base             | USDC   | 9%                 | 6.50%           |
| Aave V3  | Metis            | m.DAI  | 9.50%              | 6.50%           |
| Aave V3  | Metis            | m.USDC | 9.50%              | 6.50%           |
| Aave V3  | Metis            | m.USDT | 9.50%              | 6.50%           |
| Aave V3  | Avalanche        | DAI.e  | 8.50%              | 6.50%           |
| Aave V3  | Avalanche        | USDC   | 8.50%              | 6.50%           |
| Aave V3  | Avalanche        | USDt   | 8.50%              | 6.50%           |
| Aave V3  | Avalanche        | FRAX   | 8.50%              | 6.50%           |
| Aave V3  | Avalanche        | AUSD   | 8.50%              | 6.50%           |
| Aave V3  | Gnosis           | WXDAI  | 9%                 | 6.50%           |
| Aave V3  | Gnosis           | EURe   | 9%                 | 6.50%           |
| Aave V3  | Gnosis           | USDC.e | 9%                 | 6.50%           |
| Aave V3  | BNB              | USDC   | 8.50%              | 6.50%           |
| Aave V3  | BNB              | USDT   | 8.50%              | 6.50%           |
| Aave V3  | BNB              | FDUSD  | 8.50%              | 6.50%           |
| Aave V3  | Scroll           | USDC   | 8.50%              | 6.50%           |
| Aave V3  | ZkSync           | USDC   | 8.50%              | 6.50%           |
| Aave V3  | ZkSync           | USDT   | 8.50%              | 6.50%           |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Ethereum_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3EthereumLido_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Polygon_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Avalanche_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Optimism_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Arbitrum_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Metis_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Gnosis_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Scroll_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3BNB_StablecoinsInterestRateCurveUpdate_20250312.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3ZkSync_StablecoinsInterestRateCurveUpdate_20250312.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Ethereum_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3EthereumLido_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3EthereumEtherFi_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Polygon_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Avalanche_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Optimism_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Arbitrum_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Metis_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Base_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Gnosis_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3Scroll_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3BNB_StablecoinsInterestRateCurveUpdate_20250312.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/main/zksync/src/20250312_Multi_StablecoinsInterestRateCurveUpdate/AaveV3ZkSync_StablecoinsInterestRateCurveUpdate_20250312.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-stablecoin-interest-rate-curve-update-03-04-2025/21269)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
