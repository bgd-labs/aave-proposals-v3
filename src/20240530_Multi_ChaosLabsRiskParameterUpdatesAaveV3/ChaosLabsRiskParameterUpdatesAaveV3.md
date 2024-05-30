---
title: "Chaos Labs Risk Parameter Updates AaveV3"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-05-24-2024/17788"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x9674191acdb3cae244e010069df7637d6b7b3e30849f91570f0349323c5330d9"
---

## Simple Summary

A proposal to adjust ten (10) total risk parameters, including Loan-to-Value and Liquidation Threshold, across five (5) Aave V3 assets.

## Motivation

Increasing the liquidation threshold and LTV for assets allows Aave to enhance users’ capital efficiency. However, this must be balanced with proper risk management to ensure that there is a sufficient buffer in the event of large drawdowns and/or liquidations. The analyses below were conducted utilizing our LT simulations, which showed either minimal or no increases in VaR at the recommended LT levels, while also considering user distribution and on-chain liquidity.

## Specification

### Gnosis

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT |
| ----- | ----------- | --------------- | ---------- | -------------- |
| GNO   | 45%         | 48%             | 50%        | 53%            |

### Optimism

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT |
| ----- | ----------- | --------------- | ---------- | -------------- |
| OP    | 50%         | 58%             | 60%        | 63%            |

### Arbitrum

| Asset | Current LTV | Recommended LTV | Current LT | Recommended LT |
| ----- | ----------- | --------------- | ---------- | -------------- |
| ARB   | 50%         | 58%             | 60%        | 63%            |

### Polygon

| Asset   | Current LTV | Recommended LTV | Current LT | Recommended LT |
| ------- | ----------- | --------------- | ---------- | -------------- |
| stMATIC | 45%         | 48%             | 56%        | 58%            |
| MaticX  | 45%         | 50%             | 58%        | 60%            |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Optimism_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Polygon_ChaosLabsRiskParameterUpdatesAaveV3_20240530.t.sol), [AaveV3Optimism](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Optimism_ChaosLabsRiskParameterUpdatesAaveV3_20240530.t.sol), [AaveV3Arbitrum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Arbitrum_ChaosLabsRiskParameterUpdatesAaveV3_20240530.t.sol), [AaveV3Gnosis](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240530_Multi_ChaosLabsRiskParameterUpdatesAaveV3/AaveV3Gnosis_ChaosLabsRiskParameterUpdatesAaveV3_20240530.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x9674191acdb3cae244e010069df7637d6b7b3e30849f91570f0349323c5330d9)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-aave-v3-05-24-2024/17788)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
