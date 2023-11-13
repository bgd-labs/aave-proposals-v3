---
title: "Chaos Labs CRV Aave V3 Polygon LT Reduction"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-crv-aave-v3-polygon-lt-reduction-10-28-2023/15259"
---

## Simple Summary

A proposal to reduce the Liquidation Threshold (LT) for CRV on Aave V3 Polygon.

## Motivation

As the market liquidity of CRV has seen a substantial decline, this proposal seeks to address this by decreasing the liquidation threshold (LT) for CRV on Polygon V3. The objective is to mitigate the risk exposure associated with CRV and diminish its borrowing power, thereby aligning it more accurately with the existing market conditions and its parameters on other deployments.

_As Liquidation Threshold reductions may lead to user accounts being eligible for liquidations upon their approval, we want to clarify the full implications to the community. Chaos Labs will publicly communicate the planned amendments and list of affected accounts leading to the on-chain execution._

### Analysis

Chaos Labs recommends a 15% reduction. As of October 25, seven total accounts amounting to ~$141 are at risk of liquidation following the proposed changes.

| Asset | Current LT | Rec LT | Value Liquidated ($) | Accounts Liquidated |
| ----- | ---------- | ------ | -------------------- | ------------------- |
| CRV   | 65%        | 50%    | 141                  | 8                   |

## Specification

| Asset | Parameter | Current Value | Recommendation | Change |
| ----- | --------- | ------------- | -------------- | ------ |
| CRV   | LT        | 65%           | 50%            | -15%   |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/32feb0ecad0dd7e872929d42accba09b7f44b902/src/20231106_AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction/AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/32feb0ecad0dd7e872929d42accba09b7f44b902/src/20231106_AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction/AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0851676384aa4adc836ac6d4f001d1ec7683d5142380a2499bc5ac8b56bb8593)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-crv-aave-v3-polygon-lt-reduction-10-28-2023/15259)

# Disclaimer

Chaos Labs have not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
