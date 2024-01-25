---
title: "Update ETH EMode and WETH Risk Params on Aave v3 Ethereum, Optimism and Arbitrum"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-update-steth-and-weth-risk-params-on-aave-v3-ethereum-optimism-and-arbitrum/16168"
---

## Simple Summary

This AIP proposes to update ETH LSTs (wstETH, rETH, cbETH) and WETH risk parameters on the Aave V3 Ethereum Mainnet, OP Mainnet and Arbitrum.

## Motivation

We propose updating the ETH LSTs and WETH risk parameters to be optimal and competitive in the current market landscape. This will maintain Aave’s position as the prime liquidity protocol by increasing our protocol attractiveness for users looking to maximize their capital efficiency.

## Specification

The proposed changes update some risk parameters on ETH LSTs and WETH.

**ETH correlated E-Mode Ethereum**

Update ETH-correlated E-Mode parameters with the following values.

| Risk Parameter        | Current Value | Proposed Value |
| --------------------- | ------------- | -------------- |
| Loan To Value (LTV)   | 90%           | 93%            |
| Liquidation Threshold | 93%           | 95%            |

We propose no changes to the ETH LSTs non-E-Mode parameters.

**ETH correlated E-Mode Arbitrum**

Update ETH-correlated E-Mode parameters with the following values.

| Risk Parameter        | Current Value | Proposed Value |
| --------------------- | ------------- | -------------- |
| Loan To Value (LTV)   | 90%           | 93%            |
| Liquidation Threshold | 93%           | 95%            |
| Liquidation Bonus     | 2%            | 1%             |

We propose no changes to the ETH LSTs non-E-Mode parameters.

**ETH correlated E-Mode Optimism**

| Risk Parameter        | Current Value | Proposed Value |
| --------------------- | ------------- | -------------- |
| Loan To Value (LTV)   | 90%           | 93%            |
| Liquidation Threshold | 93%           | 95%            |

We propose no changes to the stETH non-E-Mode parameters.

**WETH Ethereum**

| Risk Parameter | Current Value | Proposed Value |
| -------------- | ------------- | -------------- |
| Optimal Ratio  | 80%           | 90%            |

Other parameters will remain unchanged.

**WETH Arbitrum**

| Risk Parameter | Current Value | Proposed Value |
| -------------- | ------------- | -------------- |
| Optimal Ratio  | 80%           | 90%            |

Other parameters will remain unchanged.

**WETH Optimism**

| Risk Parameter | Current Value | Proposed Value |
| -------------- | ------------- | -------------- |
| Optimal Ratio  | 80%           | 90%            |

Other parameters will remain unchanged

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240121_Multi_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum/AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240121_Multi_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum/AaveV3Optimism_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240121_Multi_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum/AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240121_Multi_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum/AaveV3Ethereum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240121_Multi_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum/AaveV3Optimism_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240121_Multi_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum/AaveV3Arbitrum_UpdateStETHAndWETHRiskParamsOnAaveV3EthereumOptimismAndArbitrum_20240121.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xb8790aeb32267062c1500deb613ad15ebd5deac4d78d1786cb1690c12d0512c9)
- [Discussion](https://governance.aave.com/t/arfc-update-steth-and-weth-risk-params-on-aave-v3-ethereum-optimism-and-arbitrum/16168)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
