---
title: "Generalized LT/LTV Reduction on Aave"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x4067d91ef5864925136d10ec9419f032a70f7e6489740386e348488426656274"
---

## Simple Summary

Reduce stablecoin LTs and LTVs across all markets.

## Motivation

In response to the volatility risks highlighted by the UNI incident on Compound, this proposal aims to mitigate theoretical debt asset volatility by proposing a reduction in collateral asset borrowing power for stablecoins. While the UNI debacle was attributed to inadequate dual-bounded fallback oracle logic, a property not employed by Aave, leading to mispriced UNI debt and subsequent arbitrage activities, the observed upward volatility in longer-tailed assets suggests a prevailing “risk-on” market sentiment. Therefore, we advocate for minimizing borrowing power concerning shorting these assets to prevent potential short squeezes and liquidation shortfalls. Subsequent recommendations will address borrow cap reductions for relevant long-tailed assets, which generate minimal revenue relative to the theoretical risks, especially in edge-case scenarios. Additionally, presently only 2.4%, 3.7% and 5.8% of supplied DAI, USDT and USDC on Ethereum are being utilized as collateral, indicating the generalized lack of demand (and thus revenue).

## Specification

| Assets | Chain     | Current LT | Recommended LT | Current LTV | Recommended LTV |
| ------ | --------- | ---------- | -------------- | ----------- | --------------- |
| USDC   | Arbitrum  | 80%        | 79%            | 77%         | 76%             |
| USDT   | Arbitrum  | 80%        | 79%            | 77%         | 76%             |
| DAI    | Arbitrum  | 82%        | 79%            | 77%         | 76%             |
| USDC.e | Arbitrum  | 80%        | 79%            | 77%         | 76%             |
| USDC   | Avalanche | 86.25%     | 85%            | 82.5%       | 80%             |
| USDT   | Avalanche | 80%        | 78%            | 77%         | 75%             |
| DAI    | Avalanche | 82%        | 80%            | 75%         | -               |
| USDC   | BNBChain  | 80%        | 79%            | 77%         | 76%             |
| USDT   | BNBChain  | 80%        | 79%            | 77%         | 76%             |
| USDC   | Base      | 80%        | 79%            | 77%         | 76%             |
| USDbC  | Base      | 80%        | 79%            | 77%         | 76%             |
| USDC   | Ethereum  | 80%        | 79%            | 77%         | 76%             |
| USDT   | Ethereum  | 80%        | 79%            | 77%         | 76%             |
| DAI    | Ethereum  | 80%        | 79%            | 77%         | 76%             |
| sDAI   | Ethereum  | 80%        | 79%            | 77%         | 76%             |
| USDC   | Gnosis    | 80%        | 79%            | 77%         | 76%             |
| sDAI   | Gnosis    | 80%        | 79%            | 77%         | 76%             |
| xDAI   | Gnosis    | 80%        | 79%            | 77%         | 76%             |
| USDC   | Optimism  | 80%        | 79%            | 77%         | 76%             |
| USDT   | Optimism  | 80%        | 79%            | 77%         | 76%             |
| USDC.e | Optimism  | 85%        | 84%            | 80%         | 78%             |
| DAI    | Optimism  | 83%        | 80%            | 78%         | 75%             |
| USDC   | Polygon   | 80%        | 79%            | 77%         | 76%             |
| USDT   | Polygon   | 80%        | 79%            | 77%         | 76%             |
| DAI    | Polygon   | 81%        | 79%            | 76%         | -               |
| USDC.e | Polygon   | 80%        | 79%            | 77%         | 76%             |
| USDC   | Scroll    | 80%        | 79%            | 77%         | 76%             |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Ethereum_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Polygon_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Avalanche_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Optimism_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Arbitrum_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Base_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Gnosis_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3BNB_GeneralizedLTLTVReductionOnAave_20240324.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Scroll_GeneralizedLTLTVReductionOnAave_20240324.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Ethereum_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Polygon_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Avalanche_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Optimism_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Arbitrum_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Base_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Gnosis_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3BNB_GeneralizedLTLTVReductionOnAave_20240324.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240324_Multi_GeneralizedLTLTVReductionOnAave/AaveV3Scroll_GeneralizedLTLTVReductionOnAave_20240324.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x4067d91ef5864925136d10ec9419f032a70f7e6489740386e348488426656274)
- [Discussion](https://governance.aave.com/t/generalized-lt-ltv-reduction-on-aave/16766)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
