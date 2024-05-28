---
title: "Generalized LT/LTV Reductions on Aave V3 Step 2"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-generalized-lt-ltv-reductions-on-aave-v3-step-2-04-23-2024/17455"
---

## Simple Summary

Reduce stablecoin LTs and LTVs across all markets.

## Motivation

Following a successful implementation of [Phase I](https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766) of our plan to reduce stablecoin LTs and LTVs, we would like to propose the next phase. Additionally, we have updated our recommended final state for all associated stablecoins, with LTVs and LTs harmonized across all chains at 75% and 78%, respectively.

Please note that given the [proposal](https://governance.aave.com/t/arfc-risk-parameters-for-dai-update/17211) to adjust DAI and sDAI risk parameters, it has been excluded from this proposal.

## Specification

### Ethereum

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ----- | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC  | 76%         | 75%             | 79%        | 78%            | $2,600           |
| USDT  | 76%         | 75%             | 79%        | 78%            | $0               |
| sDAI  | 63%         | 75%             | 77%        | 78%            |                  |

### Gnosis

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ----- | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC  | 76%         | 75%             | 79%        | 78%            | $0               |
| sDAI  | 63%         | 75%             | 77%        | 78%            |                  |

### Base

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ----- | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC  | 76%         | 75%             | 79%        | 78%            | $3.80            |
| USDbC | 76%         | 75%             | 79%        | 78%            | $0.40            |

### Scroll

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ----- | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC  | 76%         | 75%             | 79%        | 78%            | $103             |

### Polygon

| Asset  | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ------ | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC   | 76%         | 75%             | 79%        | 78%            | $0               |
| USDT   | 76%         | 75%             | 79%        | 78%            | $833             |
| USDC.e | 76%         | 75%             | 79%        | 78%            | $4,700           |

### Arbitrum

| Asset  | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ------ | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC   | 76%         | 75%             | 79%        | 78%            | $0               |
| USDT   | 76%         | 75%             | 79%        | 78%            | $5.30            |
| USDC.e | 76%         | 75%             | 79%        | 78%            | $1,000           |

### Optimism

| Asset  | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ------ | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC   | 76%         | 75%             | 79%        | 78%            | $3,700           |
| USDT   | 76%         | 75%             | 79%        | 78%            | $63              |
| USDC.e | 78%         | 75%             | 84%        | 80%            | $5,800           |

### BNB

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ----- | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC  | 76%         | 75%             | 79%        | 78%            | $3,700           |
| USDT  | 76%         | 75%             | 79%        | 78%            | $0               |

### Avalanche

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT | New Liquidations |
| ----- | ----------- | --------------- | ---------- | -------------- | ---------------- |
| USDC  | 80%         | 75%             | 85%        | 81%            | $23,700          |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Polygon_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Optimism_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Arbitrum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Base_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Gnosis_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Scroll_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3BNB_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Ethereum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Polygon_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Avalanche_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Optimism_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Arbitrum_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Base_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Gnosis_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3Scroll_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/781a82ff1d61529dc6d76da76cc47b524976f6c0/src/20240425_Multi_GeneralizedLTLTVReductionsOnAaveV3Step2/AaveV3BNB_GeneralizedLTLTVReductionsOnAaveV3Step2_20240425.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4067d91ef5864925136d10ec9419f032a70f7e6489740386e348488426656274)
- [Discussion](https://governance.aave.com/t/arfc-generalized-lt-ltv-reductions-on-aave-v3-step-2-04-23-2024/17455)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
