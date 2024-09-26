---
title: " Chaos Labs Risk Parameter Updates - LTV and LT Alignment"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-ltv-and-lt-alignment/18997"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x153c14691fb5056bc30f53be19f04647c24d206149d2bc5a6752d7548f72ca0b"
---

## Simple Summary

A proposal to adjust LTs and LTVs for similar assets listed on multiple Aave deployments.

## Motivation

As part of Chaos Labs’ regular monitoring of the Aave protocol, we have identified a number of assets with differing LTs and LTVs across deployments. To improve the user experience and optimize the protocol, we propose aligning these parameters across the chains, generally targeting slightly more lenient parameters on Ethereum because of its strong liquidity. For all recommendations to increase LT, our simulations have indicated these changes will create minimal increases in VAR.

### AAVE

We recommend increasing the LT on Arbitrum and Optimism to match that on other L2s while decreasing the LT on Avalanche to align with the other deployments. We recommend aligning LTVs at 63% on these networks, slightly lower than on Ethereum.

### cbETH

We recommend increasing the LT and LTV for both cbETH markets and aligning them on both Base and Ethereum, given the strong liquidity on both networks.

### LINK

We recommend aligning LINK parameters at 71% LT and 66% LTV. We note that Arbitrum’s LT cannot be decreased to 71% without causing significant liquidations, thus we propose a decrease to 75%; we note that the two proposed LT decreases would induce under $1 of liquidations given the current market structure. We may propose additional increases to LINK - Ethereum’s LT and LTV in the future.

### rETH

We recommend increasing rETH’s LT on Ethereum, while increasing its LTV on all networks, maintaining slightly more conservative parameters on Arbitrum and Optimism.

### USDC

We recommend decreasing the LT on Avalanche and Metis, noting that we cannot reach our target of 78% without large liquidations. We also recommend reducing the LTV of m.USDC on Metis.

### USDT

We recommend reducing the LT and LTV of m.USDT on Metis to bring it in line with parameters on other networks.

### WETH

We recommend targeting an 83% LT and 80% LTV across all deployments. Our simulations find that the proposed increases generate minimal additional VAR. We note that we are unable to reduce WETH on Arbitrum to the target without significant liquidations; thus, we recommend reducing to 84%.

### wstETH

We recommend an LT of 79% and LTV of 75% on all non-Ethereum networks. We note that this involves a small LT reduction on Optimism, inducing just $24 in new liquidations under current market conditions.

## Specification

Given these observations, we recommend making the following changes:

| Asset  | Chain          | Current LT | Rec. LT | Potential Liqs. | Current LTV | Rec. LTV |
| ------ | -------------- | ---------- | ------- | --------------- | ----------- | -------- |
| AAVE   | Arbitrum-main  | 65.0%      | 70.0%   | -               | 50.0%       | 63.0%    |
| AAVE   | Optimism-main  | 65.0%      | 70.0%   | -               | 50.0%       | 63.0%    |
| AAVE   | Polygon-main   | 70.0%      | -       | -               | 60.0%       | 63.0%    |
| AAVE   | Ethereum-main  | 73.0%      | -       | -               | 66.0%       | -        |
| AAVE.e | Avalanche-main | 71.3%      | 70.0%   | $0              | 60.0%       | 63.0%    |
| cbETH  | Ethereum-main  | 77.0%      | 79.0%   | -               | 74.5%       | 75.0%    |
| cbETH  | Base-main      | 74.0%      | 79.0%   | -               | 67.0%       | 75.0%    |
| LINK   | Ethereum-main  | 68.0%      | 71.0%   | -               | 53.0%       | 66.0%    |
| LINK   | Arbitrum-main  | 77.5%      | 75.0%   | $0.50           | 70.0%       | 66.0%    |
| LINK   | Optimism-main  | 75.0%      | 71.0%   | $0.30           | 70.0%       | 66.0%    |
| LINK   | Polygon-main   | 68.0%      | 71.0%   | -               | 53.0%       | 66.0%    |
| LINK.e | Avalanche-main | 71.0%      | -       | -               | 56.0%       | 66.0%    |
| rETH   | Ethereum-main  | 77.0%      | 79.0%   | -               | 74.5%       | 75.0%    |
| rETH   | Arbitrum-main  | 74.0%      | -       | -               | 67.0%       | 69.0%    |
| rETH   | Optimism-main  | 74.0%      | -       | -               | 67.0%       | 69.0%    |
| USDbC  | Base-main      | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Arbitrum-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Optimism-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Polygon-main   | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Ethereum-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Base-main      | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Avalanche-main | 81.0%      | 79.5%   | $511            | 75.0%       | -        |
| USDC   | Gnosis-main    | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | BNB-main       | 78.0%      | -       | -               | 75.0%       | -        |
| USDC   | Scroll-main    | 78.0%      | -       | -               | 75.0%       | -        |
| m.USDC | Metis-main     | 85.0%      | 83.0%   | $21.90          | 80.0%       | 75.0%    |
| USDC.e | Arbitrum-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDC.e | Optimism-main  | 80.0%      | 78.5%   | $62             | 75.0%       | -        |
| USDC.e | Polygon-main   | 78.0%      | -       | -               | 75.0%       | -        |
| USDC.e | Gnosis-main    | 78.0%      | -       | -               | 75.0%       | -        |
| USDT   | Arbitrum-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDT   | Optimism-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDT   | Polygon-main   | 78.0%      | -       | -               | 75.0%       | -        |
| USDT   | Ethereum-main  | 78.0%      | -       | -               | 75.0%       | -        |
| USDt   | Avalanche-main | 78.0%      | -       | -               | 75.0%       | -        |
| USDT   | BNB-main       | 78.0%      | -       | -               | 75.0%       | -        |
| m.USDT | Metis-main     | 80.0%      | 78.0%   | $11.20          | 77.0%       | 75.0%    |
| WETH   | Arbitrum-main  | 85.0%      | 84.0%   | $241.90         | 82.5%       | 80.0%    |
| WETH   | Optimism-main  | 82.5%      | 83.0%   | -               | 80.0%       | -        |
| WETH   | Polygon-main   | 82.5%      | 83.0%   | -               | 80.0%       | -        |
| WETH   | Ethereum-main  | 83.0%      | -       | -               | 80.5%       | -        |
| WETH   | Base-main      | 83.0%      | -       | -               | 80.0%       | -        |
| WETH   | Metis-main     | 82.5%      | 83.0%   | -               | 80.0%       | -        |
| WETH   | Gnosis-main    | 78.0%      | 83.0%   | -               | 75.0%       | 80.0%    |
| WETH   | Scroll-main    | 78.0%      | 83.0%   | -               | 75.0%       | 80.0%    |
| ETH    | BNB-main       | 82.5%      | 83.0%   | -               | 80.0%       | -        |
| WETH.e | Avalanche-main | 82.5%      | 83.0%   | -               | 80.0%       | -        |
| wstETH | Ethereum-main  | 81.0%      | -       | -               | 78.5%       | -        |
| wstETH | Arbitrum-main  | 79.0%      | -       | -               | 70.0%       | 75.0%    |
| wstETH | Optimism-main  | 80.0%      | 79.0%   | $24             | 71.0%       | 75.0%    |
| wstETH | Polygon-main   | 79.0%      | -       | -               | 70.0%       | 75.0%    |
| wstETH | Base-main      | 76.0%      | 79.0%   | -               | 71.0%       | 75.0%    |
| wstETH | Gnosis-main    | 78.0%      | 79.0%   | -               | 75.0%       | -        |
| wstETH | Scroll-main    | 78.0%      | 79.0%   | -               | 75.0%       | -        |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Polygon_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Optimism_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Metis_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Base_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Gnosis_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Scroll_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3BNB_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Ethereum_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Polygon_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Optimism_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Metis](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Metis_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Base_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Gnosis_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3Scroll](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3Scroll_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol), [AaveV3BNB](https://github.com/bgd-labs/aave-proposals-v3/blob/30f0b5b24561bfb2887b9d86f85f65b3e4480f46/src/20240913_Multi_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment/AaveV3BNB_ChaosLabsRiskParameterUpdatesLTVAndLTAlignment_20240913.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x153c14691fb5056bc30f53be19f04647c24d206149d2bc5a6752d7548f72ca0b)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-ltv-and-lt-alignment/18997)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
