---
title: "Stablecoin IR Curve Amendment"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-07-14-24/18252"
snapshot: "Direct-to-AIP"
---

## Simple Summary

A proposal to decrease stablecoin Interest Rate parameters across all Aave deployments.

## Motivation

Following the anticipated decrease in DSR — from 8% to 7% — we believe it is prudent to update Aave stablecoin interest rates to best align with the broader market. Previously, we [recommended](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-04-22-2024/17450) reducing rates concurrent with the last DSR decrease from 13% to 10% in April.

The new parameters went into effect on May 6, 2024, and thus far have helped improve rate stability and utilization rates. As part of our ongoing monitoring of broader markets, we note that MakerDAO is in the process of reducing the DAI Savings Rate, which could impact stablecoin rates throughout DeFi.

Following our methodology laid out in previous [recommendations](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3/16864/2), we recommend closely aligning Slope1 with the DSR to reduce the opportunity of rate arbitrage and ensure that Aave remains competitive. As a result, we propose decreasing Slope1 to 0.5% below the DSR, setting it at 6.5%.

Caveats:

1. We do not recommend an update to lower-cap stablecoins on Ethereum V2, as they are currently being deprecated.
2. Similar to the previous proposals, we do not recommend a change on bridged USDC (USDC.e/USDbC) on all deployments. This way, they will have a higher Slope1 to motivate the borrowing of native USDC.

## Specification

| Market       | Asset  | Current Slope1 | Recommended Slope1 |
| ------------ | ------ | -------------- | ------------------ |
| Ethereum V2  | USDC   | 9%             | 6.5%               |
| Ethereum V2  | USDT   | 9%             | 6.5%               |
| Ethereum V2  | DAI    | 9%             | 6.5%               |
| Ethereum V3  | USDC   | 9%             | 6.5%               |
| Ethereum V3  | USDT   | 9%             | 6.5%               |
| Ethereum V3  | FRAX   | 9%             | 6.5%               |
| Ethereum V3  | DAI    | 9%             | 6.5%               |
| Ethereum V3  | LUSD   | 9%             | 6.5%               |
| Ethereum V3  | pyUSD  | 9%             | 6.5%               |
| Ethereum V3  | crvUSD | 9%             | 6.5%               |
| Avalanche V3 | USDC   | 9%             | 6.5%               |
| Avalanche V3 | USDT   | 9%             | 6.5%               |
| Avalanche V3 | DAI    | 9%             | 6.5%               |
| Avalanche V3 | FRAX   | 9%             | 6.5%               |
| Polygon V3   | USDC   | 9%             | 6.5%               |
| Polygon V3   | USDT   | 9%             | 6.5%               |
| Polygon V3   | DAI    | 9%             | 6.5%               |
| Polygon V3   | EURA   | 9%             | 6.5%               |
| Polygon V3   | EURS   | 9%             | 6.5%               |
| Polygon V3   | jEUR   | 9%             | 6.5%               |
| Optimism V3  | USDC   | 9%             | 6.5%               |
| Optimism V3  | USDT   | 9%             | 6.5%               |
| Optimism V3  | DAI    | 9%             | 6.5%               |
| Optimism V3  | sUSD   | 9%             | 6.5%               |
| Optimism V3  | LUSD   | 9%             | 6.5%               |
| Optimism V3  | MAI    | 9%             | 6.5%               |
| Arbitrum V3  | USDC   | 9%             | 6.5%               |
| Arbitrum V3  | USDT   | 9%             | 6.5%               |
| Arbitrum V3  | DAI    | 9%             | 6.5%               |
| Arbitrum V3  | LUSD   | 9%             | 6.5%               |
| Arbitrum V3  | FRAX   | 9%             | 6.5%               |
| Arbitrum V3  | EURS   | 9%             | 6.5%               |
| Base V3      | USDC   | 9%             | 6.5%               |
| Metis V3     | m.USDC | 6%             | No Change          |
| Metis V3     | m.USDT | 6%             | No Change          |
| Metis V3     | m.DAI  | 6%             | No Change          |
| BNB Chain V3 | USDT   | 9%             | 6.5%               |
| BNB Chain V3 | USDC   | 9%             | 6.5%               |
| BNB Chain V3 | FDUSD  | 9%             | 6.5%               |
| Scroll V3    | USDC   | 9%             | 6.5%               |
| Gnosis V3    | WXDAI  | 9%             | 6.5%               |
| Gnosis V3    | USDC   | 9%             | 6.5%               |
| Gnosis V3    | EURe   | 9%             | 6.5%               |

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV2Ethereum_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Ethereum_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Polygon_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Avalanche_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Optimism_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Arbitrum_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Base_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Gnosis_StablecoinIRCurveAmendment_20240714.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Scroll_StablecoinIRCurveAmendment_20240714.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3BNB_StablecoinIRCurveAmendment_20240714.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV2Ethereum_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Ethereum_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Polygon_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Avalanche_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Optimism_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Arbitrum_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Base_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Gnosis_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3Scroll_StablecoinIRCurveAmendment_20240714.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240714_Multi_StablecoinIRCurveAmendment/AaveV3BNB_StablecoinIRCurveAmendment_20240714.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-07-14-24/18252)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
