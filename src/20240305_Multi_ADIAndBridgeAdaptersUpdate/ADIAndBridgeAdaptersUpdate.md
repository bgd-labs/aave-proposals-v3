---
title: "aDI and bridge adapters update"
author: "BGD Labs @bgdlabs"
discussions: ""
---

## Simple Summary

## Motivation

## Specification

Updates the implementation of CrossChainController on aDI on all supported networks:

| Network   | CrossChainController Impl                        |
| --------- | ------------------------------------------------ |
| Ethereum  | [](https://etherscan.io/address/)                |
| Polygon   | [](https://polygonscan.com/address/)             |
| Avalanche | [](https://snowscan.xyz/address/)                |
| Binance   | [](https://bscscan.com/address/)                 |
| Gnosis    | [](https://gnosisscan.io/address/)               |
| Arbitrum  | [](https://arbiscan.io/address/)                 |
| Optimism  | [](https://optimistic.etherscan.io/address/)     |
| Metis     | [](https://andromeda-explorer.metis.io/address/) |
| Base      | [](https://basescan.org/address/)                |
| Scroll    | [](https://scrollscan.com/address/)              |

Updates the bridge adapters used to connect Ethereum with all other networks and vice versa

| Network   | CCIP                                 | LayerZero                            | Hyperlane                            | Polygon Native                       | Gnosis Native                      | Metis Native                                     | Arbitrum Native                   | Optimism Native                              | Base Native                       | Scroll Native                       |
| --------- | ------------------------------------ | ------------------------------------ | ------------------------------------ | ------------------------------------ | ---------------------------------- | ------------------------------------------------ | --------------------------------- | -------------------------------------------- | --------------------------------- | ----------------------------------- |
| Ethereum  | [](https://etherscan.io/address/)    | [](https://etherscan.io/address/)    | [](https://etherscan.io/address/)    | [](https://etherscan.io/address/)    | [](https://etherscan.io/address/)  | [](https://etherscan.io/address/)                | [](https://etherscan.io/address/) | [](https://etherscan.io/address/)            | [](https://etherscan.io/address/) | [](https://etherscan.io/address/)   |
| Polygon   | [](https://polygonscan.com/address/) | [](https://polygonscan.com/address/) | [](https://polygonscan.com/address/) | [](https://polygonscan.com/address/) | -                                  | -                                                | -                                 | -                                            | -                                 | -                                   |
| Avalanche | [](https://snowscan.xyz/address/)    | [](https://snowscan.xyz/address/)    | [](https://snowscan.xyz/address/)    | -                                    | -                                  | -                                                | -                                 | -                                            | -                                 | -                                   |
| Binance   | [](https://bscscan.com/address/)     | [](https://bscscan.com/address/)     | [](https://bscscan.com/address/)     | -                                    | -                                  | -                                                | -                                 | -                                            | -                                 | -                                   |
| Gnosis    | -                                    | [](https://gnosisscan.io/address/)   | [](https://gnosisscan.io/address/)   | -                                    | [](https://gnosisscan.io/address/) | -                                                | -                                 | -                                            | -                                 | -                                   |
| Arbitrum  | -                                    | -                                    | -                                    | -                                    | -                                  | -                                                | [](https://arbiscan.io/address/)  | -                                            | -                                 | -                                   |
| Optimism  | -                                    | -                                    | -                                    | -                                    | -                                  | -                                                | -                                 | [](https://optimistic.etherscan.io/address/) | -                                 | -                                   |
| Metis     | -                                    | -                                    | -                                    | -                                    | -                                  | [](https://andromeda-explorer.metis.io/address/) | -                                 | -                                            | -                                 | -                                   |
| Base      | -                                    | -                                    | -                                    | -                                    | -                                  | -                                                | -                                 | -                                            | [](https://basescan.org/address/) | -                                   |
| Scroll    | -                                    | -                                    | -                                    | -                                    | -                                  | -                                                | -                                 | -                                            | -                                 | [](https://scrollscan.com/address/) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Ethereum_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Polygon_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Avalanche_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Optimism_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Arbitrum_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Metis_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Base_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Gnosis_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3Scroll_ADIAndBridgeAdaptersUpdate_20240305.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240305_Multi_ADIAndBridgeAdaptersUpdate/AaveV3BNB_ADIAndBridgeAdaptersUpdate_20240305.t.sol)
- [Snapshot](TODO)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
