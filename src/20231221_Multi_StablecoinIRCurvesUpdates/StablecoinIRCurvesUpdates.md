---
title: "Stablecoin IR Curves Updates"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curves-updates/15838"
---

## Simple Summary

A proposal to increase stablecoin Interest Rate parameters across all Aave deployments.

## Motivation

Following the implementation of [AIP-375](https://app.aave.com/governance/proposal/375/) to increase stablecoin borrow rates across Aave V2 and V3 deployments, we continue to observe volatility in borrow rates across Aave deployments. As we [highlighted](https://governance.aave.com/t/arfc-increase-optimal-borrow-rates-for-ethereum-stablecoin-markets/15096/3) in the recent proposal, we recommend a more aggressive increase of the Slope1 parameter to stabilize borrows under the UOptimal point.

**Adjust Slope1 of stablecoins to 6%**

The [analysis](https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curves-updates/15838) indicates a necessity for further refinement of stablecoin interest rates, to achieve a more predictable and stable borrowing rate with an equilibrium utilization under the UOptimal point.
Therefore, we propose increasing Slope1 to 6% for stablecoins across all Aave deployments, in this iteration. Following this increase, we will continue monitoring the usage and equilibrium rate and make additional recommendations as necessary.

## Specification

| Market       | Asset  | Current Slope1 | Rec Slope1 |
| ------------ | ------ | -------------- | ---------- |
| Ethereum V2  | USDC   | 5%             | 6%         |
| Ethereum V2  | USDT   | 5%             | 6%         |
| Ethereum V2  | DAI    | 5%             | 6%         |
| Ethereum V2  | FRAX   | 5%             | 6%         |
| Ethereum V2  | sUSD   | 5%             | 6%         |
| Ethereum V2  | GUSD   | 5%             | 6%         |
| Ethereum V2  | LUSD   | 5%             | 6%         |
| Ethereum V2  | USDP   | 5%             | 6%         |
| Ethereum V3  | USDC   | 5%             | 6%         |
| Ethereum V3  | USDT   | 5%             | 6%         |
| Ethereum V3  | DAI    | 5%             | 6%         |
| Ethereum V3  | FRAX   | 5%             | 6%         |
| Ethereum V3  | LUSD   | 5%             | 6%         |
| Avalanche V2 | USDC   | 5%             | 6%         |
| Avalanche V2 | USDT   | 5%             | 6%         |
| Avalanche V2 | DAI    | 5%             | 6%         |
| Avalanche V3 | USDC   | 5%             | 6%         |
| Avalanche V3 | USDT   | 5%             | 6%         |
| Avalanche V3 | DAI    | 5%             | 6%         |
| Avalanche V3 | MAI    | 5%             | 6%         |
| Avalanche V3 | FRAX   | 5%             | 6%         |
| Polygon V2   | USDC   | 5%             | 6%         |
| Polygon V2   | USDT   | 5%             | 6%         |
| Polygon V2   | DAI    | 5%             | 6%         |
| Polygon V3   | USDC.e | 7%             | No Change  |
| Polygon V3   | USDC   | 5%             | 6%         |
| Polygon V3   | USDT   | 5%             | 6%         |
| Polygon V3   | DAI    | 5%             | 6%         |
| Polygon V3   | MAI    | 5%             | 6%         |
| Optimism V3  | USDC.e | 7%             | No Change  |
| Optimism V3  | USDC   | 5%             | 6%         |
| Optimism V3  | USDT   | 5%             | 6%         |
| Optimism V3  | DAI    | 5%             | 6%         |
| Optimism V3  | sUSD   | 5%             | 6%         |
| Optimism V3  | LUSD   | 5%             | 6%         |
| Optimism V3  | MAI    | 5%             | 6%         |
| Arbitrum V3  | USDC   | 5%             | 6%         |
| Arbitrum V3  | USDC.e | 7%             | No Change  |
| Arbitrum V3  | USDT   | 5%             | 6%         |
| Arbitrum V3  | DAI    | 5%             | 6%         |
| Arbitrum V3  | LUSD   | 5%             | 6%         |
| Arbitrum V3  | FRAX   | 5%             | 6%         |
| Arbitrum V3  | MAI    | 5%             | 6%         |
| Base V3      | USDC   | 5%             | 6%         |
| Base V3      | USDbC  | 7%             | No Change  |
| Metis V3     | USDC   | 5%             | 6%         |
| Metis V3     | USDT   | 5%             | 6%         |
| Gnosis V3    | USDC   | 5%             | 6%         |
| Gnosis V3    | xDAI   | 5%             | 6%         |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV2Ethereum_StablecoinIRCurvesUpdates_20231221.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV2Polygon_StablecoinIRCurvesUpdates_20231221.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV2Avalanche_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Ethereum_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Polygon_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Avalanche_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Optimism_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Metis_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Base_StablecoinIRCurvesUpdates_20231221.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Gnosis_StablecoinIRCurvesUpdates_20231221.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV2Ethereum_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV2Polygon_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV2Avalanche_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Ethereum_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Polygon_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Avalanche_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Optimism_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Arbitrum_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Metis_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Base_StablecoinIRCurvesUpdates_20231221.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/cfbcf8fce5a168a5bd17d9dae385e0ca7d39d560/src/20231221_Multi_StablecoinIRCurvesUpdates/AaveV3Gnosis_StablecoinIRCurvesUpdates_20231221.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x7c158085e4aa7de3a337d0a84a31eed65a7f7f9e3dce45ec90205b448e6f7ab9)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curves-updates/15838)

# Disclaimer

Chaos Labs has not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
