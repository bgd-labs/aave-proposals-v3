---
title: "Decrease Slope1 Parameter for Stablecoins on Aave V3"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-stewards-decrease-slope1-parameter-for-stablecoins-on-aave-v3-01-29-25/20841"
---

## Simple Summary

In light of recent market changes, Chaos Labs recommends setting the target borrow rate for all stablecoins to 9.50%. These changes will be implemented via the direct-to-AIP process.

## Motivation

The utilization for stablecoins across Aave has continued to fall, calling for a further reduction in target rates to better align utilization. The chart below shows the average stablecoin utilization on Aave, weighted by the amount of total borrows of each asset.

Utilization across the largest markets remains relatively low; the same has held true on all deployments, with none registering an average weighted utilization above 80%.

As a result, we recommend setting the target rate for all stablecoins to 9.50%; bridged stablecoins on networks where native versions are available should be set to 10.50%. Please note that GHO, USDS, and pyUSD are managed separately and thus are not included in these recommendations.

## Specification

| Protocol | Instance         | Asset  | **Current Slope1** | **Rec. Slope1** |
| -------- | ---------------- | ------ | ------------------ | --------------- |
| Aave V3  | Ethereum Core    | USDC   | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Core    | DAI    | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Core    | USDT   | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Core    | LUSD   | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Core    | FRAX   | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Core    | crvUSD | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Core    | USDe   | 11.50%             | 9.50%           |
| Aave V3  | Ethereum Prime   | USDC   | 11.50%             | 9.50%           |
| Aave V3  | Ethereum EtherFi | USDC   | 12.50%             | 9.50%           |
| Aave V3  | Ethereum EtherFi | FRAX   | 12.50%             | 9.50%           |
| Aave V3  | Arbitrum         | DAI    | 11.50%             | 9.50%           |
| Aave V3  | Arbitrum         | USDC.e | 12.50%             | 10.50%          |
| Aave V3  | Arbitrum         | USDT   | 11.50%             | 9.50%           |
| Aave V3  | Arbitrum         | LUSD   | 11.50%             | 9.50%           |
| Aave V3  | Arbitrum         | USDC   | 11.50%             | 9.50%           |
| Aave V3  | Arbitrum         | FRAX   | 11.50%             | 9.50%           |
| Aave V3  | Optimism         | DAI    | 11.50%             | 9.50%           |
| Aave V3  | Optimism         | USDC.e | 12.50%             | 10.50%          |
| Aave V3  | Optimism         | USDT   | 11.50%             | 9.50%           |
| Aave V3  | Optimism         | sUSD   | 11.50%             | 9.50%           |
| Aave V3  | Optimism         | LUSD   | 11.50%             | 9.50%           |
| Aave V3  | Optimism         | USDC   | 11.50%             | 9.50%           |
| Aave V3  | Polygon          | DAI    | 11.50%             | 9.50%           |
| Aave V3  | Polygon          | USDC.e | 12.50%             | 10.50%          |
| Aave V3  | Polygon          | USDT   | 11.50%             | 9.50%           |
| Aave V3  | Polygon          | EURS   | 11.50%             | 9.50%           |
| Aave V3  | Polygon          | USDC   | 11.50%             | 9.50%           |
| Aave V3  | Base             | USDbC  | 12.50%             | 10.50%          |
| Aave V3  | Base             | USDC   | 11.50%             | 9.50%           |
| Aave V3  | Metis            | m.DAI  | 12.50%             | 9.50%           |
| Aave V3  | Metis            | m.USDC | 12.50%             | 9.50%           |
| Aave V3  | Metis            | m.USDT | 12.50%             | 9.50%           |
| Aave V3  | Avalanche        | DAI.e  | 12.00%             | 9.50%           |
| Aave V3  | Avalanche        | USDC   | 12.00%             | 9.50%           |
| Aave V3  | Avalanche        | USDt   | 12.00%             | 9.50%           |
| Aave V3  | Avalanche        | FRAX   | 12.00%             | 9.50%           |
| Aave V3  | Avalanche        | AUSD   | 5.50%              | 9.50%           |
| Aave V3  | Gnosis           | USD//C | 13.00%             | 10.50%          |
| Aave V3  | Gnosis           | WXDAI  | 11.50%             | 9.50%           |
| Aave V3  | Gnosis           | EURe   | 11.50%             | 9.50%           |
| Aave V3  | Gnosis           | USDC.e | 12.00%             | 9.50%           |
| Aave V3  | BNB              | USDC   | 11.50%             | 9.50%           |
| Aave V3  | BNB              | USDT   | 11.50%             | 9.50%           |
| Aave V3  | BNB              | FDUSD  | 11.50%             | 9.50%           |
| Aave V3  | Scroll           | USDC   | 11.50%             | 9.50%           |
| Aave V3  | ZkSync           | USDC   | 11.50%             | 9.50%           |
| Aave V3  | ZkSync           | USDT   | 11.50%             | 9.50%           |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Ethereum_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3EthereumLido_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3EthereumEtherFi_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Polygon_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Avalanche_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Optimism_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Arbitrum_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Metis_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Base_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Gnosis_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Scroll_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3BNB_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/zksync/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3ZkSync_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Ethereum_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3EthereumLido](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3EthereumLido_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3EthereumEtherFi](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3EthereumEtherFi_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Polygon_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Avalanche_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Optimism_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Arbitrum_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Metis_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Base_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Gnosis_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3Scroll_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3BNB_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol), [AaveV3ZkSync](https://github.com/bgd-labs/aave-proposals-v3/blob/374fe743a590705a61ff28be1f3060f1b16b251e/zksync/src/20250203_Multi_DecreaseSlope1ParameterforStablecoinsonAaveV3/AaveV3ZkSync_DecreaseSlope1ParameterforStablecoinsonAaveV3_20250203.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-stewards-decrease-slope1-parameter-for-stablecoins-on-aave-v3-01-29-25/20841)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
