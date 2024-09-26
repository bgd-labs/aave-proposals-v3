---
title: "Chaos Labs Risk Parameter Updates - sAVAX LT/LTV Adjustment"
author: "Aave Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-lt-ltv-adjustment/18995"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x79d53b646cbada43fca9468df9c9ecbbaab42f9f4f17691cbdf216b21f6c21bb"
---

## Simple Summary

A proposal to increase sAVAX’s liquidation threshold and LTV on Aave V3 Avalanche.

## Motivation

sAVAX is currently configured with a liquidation threshold (LT) of 45% and max loan-to-value (LTV) of 40%. Following our observations and simulations, we believe increasing the LT and LTV for this market is prudent.

sAVAX's average market cap over the past 180 days is $257M, and its daily average volume is $3.1M. It has registered a daily annualized volatility of 90.88%, a 30-day annualized volatility of 74.11%, and its largest single-day price drop was 14.5%.

Its supply is well distributed, with all but two of the top 10 suppliers leveraging the asset with WAVAX.

Supply has been trending upward since the end of July.

95.6% of the value of assets borrowed against sAVAX is WAVAX in E-Mode. USDC is the most popular non-E-Mode asset borrowed.

## Specification

Given these observations, we recommend increasing sAVAX’s LTV and LT and increasing its LTV in E-Mode by a small amount.

| Asset | Chain     | Market | Current LTV | Recommended LTV | Current LT | Recommended LT |
| ----- | --------- | ------ | ----------- | --------------- | ---------- | -------------- |
| sAVAX | Avalanche | Main   | 40%         | 50%             | 45%        | 55%            |
| sAVAX | Avalanche | E-Mode | 92.5%       | 93%             | 95%        | -              |
| WAVAX | Avalanche | E-Mode | 92.5%       | 93%             | 95%        | -              |

## References

- Implementation: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/e87585b08712d5df242eb2efabcde526f67a32df/src/20240920_AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920.sol)
- Tests: [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/e87585b08712d5df242eb2efabcde526f67a32df/src/20240920_AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesSAVAXLTLTVAdjustment_20240920.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x79d53b646cbada43fca9468df9c9ecbbaab42f9f4f17691cbdf216b21f6c21bb)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-savax-lt-ltv-adjustment/18995)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
