---
title: "Increase Bridged USDC Reserve Factor Across All Deployments"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787"
snapshot: ""
---

## Simple Summary

This publication proposes progressively increasing the Reserve Factor (RF) for Bridged USDC(USDC.e & USDbC) across Arbitrum, Optimism, Polygon and Base Aave deployments.

## Motivation

Presently, Bridged USDC (USDC.e & USDbC) competes with native USDC on the listed markets. By gradually increasing the RF for Bridged USDC(USDC.e & USDbC), the deposit rate on these markets will become less attractive over time. Similar to other proposals, this action is expected to encourage users to switch to native USDC on the respective market.

Upon implementing this proposal, a subsequent AIP will be submitted that increases the RF by 5.00% up to a maximum of 99.99% every 2 weeks, subject to market conditions. The RF amendments will be incorporated into the fortnightly RF and Borrow Rate adjustment AIP to reduce voting overhead.

This method has already been implemented on Polygon v2, Ethereum v2 and also Avalanche.

## Specification

| Market      | Asset  | Current RF | New RF |
| ----------- | ------ | ---------- | ------ |
| Polygon V3  | USDC.e | 20%        | 25%    |
| Optimism V3 | USDC.e | 20%        | 25%    |
| Arbitrum V3 | USDC.e | 20%        | 25%    |
| Base V3     | USDC.e | 20%        | 25%    |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Polygon_IncreaseUSDCeRF_20240528.sol),[AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Optimism_IncreaseUSDCeRF_20240528.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Arbitrum_IncreaseUSDCeRF_20240528.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Base_IncreaseUSDCeRF_20240528.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Polygon_IncreaseUSDCeRF_20240528.t.sol),[AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Optimism_IncreaseUSDCeRF_20240528.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240528_Multi_BridgedUSDCeUpdateRF/AaveV3Arbitrum_IncreaseUSDCeRF_20240528.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-increase-bridged-usdc-reserve-factor-across-all-deployments/17787)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
