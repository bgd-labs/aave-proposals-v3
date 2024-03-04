---
title: "Update WETH IR on V3 Arbitrum and Optimism"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-update-weth-ir-on-v3-arbitrum-and-optimism-02-16-2024/16644"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xef56befdec2abf0bc9611f033c2cec62447f148369a075829664f2de6bc0ae77"
---

## Simple Summary

Decrease slope1 on Arbitrum and Optimism from 3.3% to 3%.

## Motivation

Over the last eight months, we have observed a drop-off in WETH interest rates on Ethereum and, thus, relative demand for ETH borrowing.

This phenomenon can be explained by the drop-off in ETH staking yield, as we can deduce through the relatively strong correlation between WETH borrow APY and stETH staking APY on Ethereum due to profitable looping strategies. Additionally, given Aave prices stETH:ETH 1:1 with the underlying exchange rate, minimal liquidation risk exists in potential wstETH market price movements

Based on the observed trend, it’s evident that Arbitrum and Optimism could benefit from a reduction in slope1 to enhance utilization rates and consequently increase revenues. While the decrease in base_rate on both chains did positively impact utilization, it remains suboptimal. Thus, we simply take the P95 of the stETH APY differential vs WETH borrow APY since the base_rate decrease, which returned 0.6%, to derive the decrease in slope1. Considering the UOptimal rate is projected to be below the current stETH APY with a 0.6% variance, any prolonged convergence above UOptimal could lead to interest rate volatility. In such a scenario, it would be prudent to revert slope1. However, given the current trend and staking APY, this adjustment would likely result in higher utilization rates and greater profits for the Aave DAO.

## Specification

| Chain    | Asset | Parameter | Current | Recommended |
| -------- | ----- | --------- | ------- | ----------- |
| Arbitrum | WETH  | Slope1    | 3.3%    | 3%          |
| Optimism | WETH  | Slope1    | 3.3%    | 3%          |

## References

- Implementation: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240216_Multi_UpdateWETHIROnV3ArbitrumAndOptimism/AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240216_Multi_UpdateWETHIROnV3ArbitrumAndOptimism/AaveV3Arbitrum_UpdateWETHIROnV3ArbitrumAndOptimism_20240216.sol)
- Tests: [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240216_Multi_UpdateWETHIROnV3ArbitrumAndOptimism/AaveV3Optimism_UpdateWETHIROnV3ArbitrumAndOptimism_20240216.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240216_Multi_UpdateWETHIROnV3ArbitrumAndOptimism/AaveV3Arbitrum_UpdateWETHIROnV3ArbitrumAndOptimism_20240216.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xef56befdec2abf0bc9611f033c2cec62447f148369a075829664f2de6bc0ae77)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-update-weth-ir-on-v3-arbitrum-and-optimism-02-16-2024/16644)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
