---
title: "Stablecoin IR Curve Amendment"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-2024-08-15/18669"
---

## Simple Summary

A proposal to decrease stablecoin Interest Rate parameters across all Aave deployments.

## Motivation

Given the decrease in DSR — from 7% to 6% — it is prudent to update Aave stablecoin interest rates to best align with the broader market. Previously, we [recommended ](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-07-14-24/18252) reducing rates concurrent with the last DSR decrease from 8% to 7% in July.

The new parameters went into effect in mid-July and have continued to provide stable rates across Aave V3. We note that, following the announcement of the DSR decrease, there has been a notable drop in rates, converging around 5.5%.

Following our methodology laid out in previous [recommendations ](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3/16864/2), we recommend closely aligning Slope1 with the DSR to reduce the opportunity for rate arbitrage and ensure that Aave remains competitive. As a result, we propose decreasing Slope1 to 0.5% below the DSR, setting it at 5.5%.

### Caveats:

1. We do not recommend an update to lower-cap stablecoins on Ethereum V2, as they are currently being deprecated.
2. Similar to the previous proposals, we do not recommend a change on bridged USDC (USDC.e/USDbC) on all deployments. This way, they will have a higher Slope1 to motivate the borrowing of native USDC.

## Specification

| **Market**   | **Asset** | **Current Slope1** | **Recommended Slope1** |
| ------------ | --------- | ------------------ | ---------------------- |
| Ethereum V2  | USDC      | 6.5%               | 5.5%                   |
| Ethereum V2  | USDT      | 6.5%               | 5.5%                   |
| Ethereum V2  | DAI       | 6.5%               | 5.5%                   |
| Ethereum V3  | USDC      | 6.5%               | 5.5%                   |
| Ethereum V3  | USDT      | 6.5%               | 5.5%                   |
| Ethereum V3  | FRAX      | 6.5%               | 5.5%                   |
| Ethereum V3  | DAI       | 6.5%               | 5.5%                   |
| Ethereum V3  | LUSD      | 6.5%               | 5.5%                   |
| Ethereum V3  | pyUSD     | 6.5%               | 5.5%                   |
| Ethereum V3  | crvUSD    | 6.5%               | 5.5%                   |
| Avalanche V3 | USDC      | 6.5%               | 5.5%                   |
| Avalanche V3 | USDT      | 6.5%               | 5.5%                   |
| Avalanche V3 | DAI       | 6.5%               | 5.5%                   |
| Avalanche V3 | FRAX      | 6.5%               | 5.5%                   |
| Polygon V3   | USDC      | 6.5%               | 5.5%                   |
| Polygon V3   | USDT      | 6.5%               | 5.5%                   |
| Polygon V3   | DAI       | 6.5%               | 5.5%                   |
| Polygon V3   | EURA      | 6.5%               | 5.5%                   |
| Polygon V3   | EURS      | 6.5%               | 5.5%                   |
| Polygon V3   | jEUR      | 6.5%               | 5.5%                   |
| Optimism V3  | USDC      | 9%                 | 5.5%                   |
| Optimism V3  | USDT      | 6.5%               | 5.5%                   |
| Optimism V3  | DAI       | 6.5%               | 5.5%                   |
| Optimism V3  | sUSD      | 6.5%               | 5.5%                   |
| Optimism V3  | LUSD      | 6.5%               | 5.5%                   |
| Optimism V3  | MAI       | 6.5%               | 5.5%                   |
| Arbitrum V3  | USDC      | 9%                 | 5.5%                   |
| Arbitrum V3  | USDT      | 6.5%               | 5.5%                   |
| Arbitrum V3  | DAI       | 6.5%               | 5.5%                   |
| Arbitrum V3  | LUSD      | 6.5%               | 5.5%                   |
| Arbitrum V3  | FRAX      | 6.5%               | 5.5%                   |
| Arbitrum V3  | EURS      | 6.5%               | 5.5%                   |
| Base V3      | USDC      | 6.5%               | 5.5%                   |
| Metis V3     | m.USDC    | 6%                 | No Change              |
| Metis V3     | m.USDT    | 6%                 | No Change              |
| Metis V3     | m.DAI     | 7%                 | No Change              |
| BNB Chain V3 | USDT      | 6.5%               | 5.5%                   |
| BNB Chain V3 | USDC      | 6.5%               | 5.5%                   |
| BNB Chain V3 | FDUSD     | 6.5%               | 5.5%                   |
| Scroll V3    | USDC      | 6.5%               | 5.5%                   |
| Gnosis V3    | WXDAI     | 6.5%               | 5.5%                   |
| Gnosis V3    | USDC      | 6.5%               | 5.5%                   |
| Gnosis V3    | EURe      | 6.5%               | 5.5%                   |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV2Ethereum_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Ethereum_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Polygon_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Avalanche_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Optimism_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Arbitrum_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Base_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Gnosis_StablecoinIRCurveAmendment_20240829.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Scroll_StablecoinIRCurveAmendment_20240829.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3BNB_StablecoinIRCurveAmendment_20240829.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV2Ethereum_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Ethereum_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Polygon_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Avalanche_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Optimism_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Arbitrum_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Base_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Gnosis_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3Scroll_StablecoinIRCurveAmendment_20240829.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240829_Multi_StablecoinIRCurveAmendment/AaveV3BNB_StablecoinIRCurveAmendment_20240829.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-2024-08-15/18669)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
