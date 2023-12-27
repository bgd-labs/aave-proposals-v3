---
title: "Chaos Labs Risk Parameter Updates - WBTC.e on V2 and V3 Avalanche"
author: "Chaos Labs - Eyal Ovadya"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-e-on-v2-and-v3-avalanche/15824"
---

## Simple Summary

A proposal to adjust risk parameters for WBTC.e on Avalanche deployments, to limit further exposure and promote user migration to BTC.b:

- V2
  - Freeze asset
  - Reduce Liquidation Threshold and LTV
- V3
  - Freeze asset
  - Reduce Liquidation Threshold and LTV

## Motivation

As the Avalanche network is transitioning away from WBTC.e, we are observing an ongoing decrease in WBTC.e liquidity on-chain, with approximately 30% of the liquidity diminishing over the past few months. At this time, the total circulating supply on Avalanche is 1,731 WBTC.e. A considerable portion, nearly 67%, of the circulating supply is concentrated on Aave Avalanche V2 and V3, with ~496 and ~664 tokens, respectively.

Given the persistence of this trend, we suggest reducing exposure on Aave and proactively modifying risk parameters for the asset. This strategy aims to:

1.  Avert a potential scenario where there is inadequate liquidity to facilitate liquidations in Aave deployments.
2.  Motivate new and existing users on Aave to transition to BTC.b, which has a stronger liquidity profile on Avalanche.

### Limit New Supply

Freeze the WBTC.e reserves on V2 and V3 Avalanche.

### Reduce Capital Efficiency

Additionally, as a precautionary measure and to further reduce exposure to the asset, we recommend reducing LTs and LTV, without impacting current holders:

- V3 - reduce LT to 70 % and LTV to 0.
- V2 - reduce LT to 70% and LTV to 0.
  - at this time, this will lead to 6 accounts totaling $15 to be liquidated.

## Usage Analysis

Currently, about 31% of the WBTC.e supply serves as collateral, primarily utilized for borrowing stablecoins, WETH, and WAVAX. A detailed breakdown of borrowing distribution is highlighted below.

In addition, in both Avalanche deployments, we haven't detected any risky positions, nor is there a significant concentration of funds in individual wallets.

## Specification

### V3 Avalanche

| Asset  | Parameter             | Current | Recommendations |
| ------ | --------------------- | ------- | --------------- |
| WBTC.e | Liquidation Threshold | 75%     | 70%             |
| WBTC.e | LTV                   | 70%     | 0%              |
| WBTC.e | Freeze Reserve        | NO      | YES             |

### V2 Avalanche

| Asset  | Parameter             | Current | Recommendations |
| ------ | --------------------- | ------- | --------------- |
| WBTC.e | Liquidation Threshold | 75%     | 70%             |
| WBTC.e | LTV                   | 60%     | 0%              |
| WBTC.e | Freeze Reserve        | NO      | YES             |

## References

- Implementation: [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231221_Multi_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche/AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231221_Multi_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221.sol)
- Tests: [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231221_Multi_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche/AaveV2Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231221_Multi_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche/AaveV3Avalanche_ChaosLabsRiskParameterUpdatesWBTCEOnV2AndV3Avalanche_20231221.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0e496f9cb98fb887e9c0e1b4669607a2b99a0675b23ad152c7aedbe28f8dc08d)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-wbtc-e-on-v2-and-v3-avalanche/15824)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
