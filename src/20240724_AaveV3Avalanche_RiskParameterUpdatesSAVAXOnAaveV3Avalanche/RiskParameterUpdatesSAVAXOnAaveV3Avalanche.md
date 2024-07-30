---
title: "Risk Parameter Updates - sAVAX on Aave V3 Avalanche"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-on-aave-v3-avalanche-07-16-2024/18277"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x471ab55b0091043963c744f228befd842aeb354b0d04c76da3c9eb2b401934a4"
---

## Simple Summary

A proposal to adjust sAVAX’s LT and LTV on Aave V3 Avalanche.

## Motivation

Increasing the liquidation threshold and LTV for assets allows Aave to enhance users’ capital efficiency. However, this must be balanced with proper risk management to ensure that there is a sufficient buffer in the event of large drawdowns and/or liquidations. The analysis below was conducted utilizing our LT simulations, which showed either minimal or no increases in VaR at the recommended LT levels while also considering user distribution and on-chain liquidity.

### sAVAX

sAVAX’s LTV and LT are currently set to 30% and 40%, respectively (its E-Mode parameters are 92.5% and 95%). The top suppliers are primarily looping sAVAX and WAVAX, reducing the risk of large-scale liquidations in this market.
However, there is a small amount of non-WAVAX borrows against sAVAX, primarily WETH.e and stablecoins.
Moreover, sAVAX maintains strong liquidity against AVAX, meaning that potential liquidations of sAVAX collateralized debt are likely to be completed efficiently.
Given user distribution and liquidity, we recommend increasing LTV to 40% and LT to 45%.

## Specification

Given these observations, we recommend making the following changes:

| Chain     | Asset | Parameter             | Current | Recommended |
| --------- | ----- | --------------------- | ------- | ----------- |
| Avalanche | sAVAX | LTV                   | 30%     | 40%         |
| Avalanche | sAVAX | Liquidation Threshold | 40%     | 45%         |

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240724_AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche/AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240724_AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche/AaveV3Avalanche_RiskParameterUpdatesSAVAXOnAaveV3Avalanche_20240724.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x471ab55b0091043963c744f228befd842aeb354b0d04c76da3c9eb2b401934a4)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-on-aave-v3-avalanche-07-16-2024/18277)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
