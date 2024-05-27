---
title: "Reserve Factor Upgrades"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-avalanche-v2-reserve-factor-adjustment/17040/4"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x770ff4e02634c77aaa09952345551168920f7878b32ab03fcef92763a5fb70ab"
---

## Simple Summary

This proposal suggests a progressive increase in the Reserve Factor (RF) and IR Slope 1 of Bridged USDC (USDC.e) to incentivize users to transition to native USDC on the Aave v3 markets deployed on Arbitrum, Optimism, and Polygon.

## Motivation

Presently, Bridged USDC (USDC.e) competes with native USDC on the listed markets. By gradually increasing the RF and IR slope 1 of USDC.e, the interest rate for supplying it on these markets becomes less attractive over time, thereby encouraging suppliers to switch to native USDC on the respective markets.
Upon implementing this proposal, a subsequent AIP will be submitted that increases the RF by 5.00% up to a maximum of 99.99% and IR Slope 1 by 100 bps every 2 weeks, subject to market conditions.

This method has already been implemented on Polygon v2 and Ethereum v2.

## Specification

| Market      | Asset  | Current Slope1 | New Slope1 | Current RF | New RF |
| ----------- | ------ | -------------- | ---------- | ---------- | ------ |
| Polygon V3  | USDC.e | 10%            | 11%        | 20%        | 25%    |
| Optimism V3 | USDC.e | 10%            | 11%        | 20%        | 25%    |
| Arbitrum V3 | USDC.e | 10%            | 11%        | 20%        | 25%    |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Polygon_StablecoinIRUpdates_20240424.sol),[AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Optimism_StablecoinIRUpdates_20240424.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Arbitrum_StablecoinIRUpdates_20240424.sol), [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Base_StablecoinIRUpdates_20240424.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Polygon_StablecoinIRUpdates_20240424.t.sol),[AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Optimism_StablecoinIRUpdates_20240424.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/f123b71c8f30c55710f199d7f377960705dd7993/src/20240424_Multi_StablecoinIRUpdates/AaveV3Arbitrum_StablecoinIRUpdates_20240424.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-stablecoin-ir-curve-amendment-on-aave-v2-and-v3-04-22-2024/17450)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
