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

List of affected accounts:

| Account                                    | Total Supply (USD) | Total CRV Supplied | Total Borrows (USD) | Health | Health After Change |
| ------------------------------------------ | ------------------ | ------------------ | ------------------- | ------ | ------------------- |
| 0x9ce21324617b6b573e75d28580dcd5a88c41b4bb | 106                | 29.16              | 86.47               | 1.01   | 0.99                |
| 0xa21fa160a63993d06daf2cb22f66b9a118a25ed4 | 97                 | 200.43             | 59.14               | 1.07   | 0.83                |
| 0xf36375ef8ef450476541f6326631cac44f9f0a49 | 58                 | 40.18              | 41.22               | 1.07   | 0.99                |
| 0xe9784ffc614fe5cc57939cc7b21cdd2cf8f61c86 | 17                 | 34.88              | 10.60               | 1.09   | 0.86                |
| 0x6c62b64c4e1a4702a41c47d5cdafc29fcba0ebad | 12                 | 25.77              | 6.63                | 1.23   | 0.95                |
| 0xdb79b400a31997ebc6816f002f2b622fe186056a | 12                 | 25.57              | 6.63                | 1.22   | 0.94                |
| 0x0906f3f07c7211bdce20d8a7cf9bdd7c3306532d | 4                  | 6.7                | 2.65                | 1.14   | 0.96                |
| 0x304481771f4922b60a759ac363da3a7da6372cc1 | 4                  | 0.83               | 3.5                 | 1.02   | 1.00                |

## Specification

| Asset | Parameter | Current Value | Recommendation | Change |
| ----- | --------- | ------------- | -------------- | ------ |
| CRV   | LT        | 65%           | 50%            | -15%   |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231106_AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction/AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231106_AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction/AaveV3Polygon_ChaosLabsCRVAaveV3PolygonLTReduction_20231106.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0851676384aa4adc836ac6d4f001d1ec7683d5142380a2499bc5ac8b56bb8593)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-crv-aave-v3-polygon-lt-reduction-10-28-2023/15259)

# Disclaimer

Chaos Labs have not been compensated by any third party for publishing this ARFC.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
