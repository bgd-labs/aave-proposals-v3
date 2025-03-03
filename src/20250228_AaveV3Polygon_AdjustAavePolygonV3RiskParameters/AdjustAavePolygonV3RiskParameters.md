---
title: "Adjust Aave Polygon V3 Risk Parameters"
author: "ACI"
discussions: "https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211/60"
---

## Simple Summary

This proposal addendum seeks governance approval for adjustment of the [AIP-254](https://vote.onaave.com/proposal/?proposalId=254&ipfsHash=0x9a0342bc6f37687ea20210c3a1664de1949d9e3e967ff87467501d4d00116aab) to reintroduce LTV for non-bridged stablecoins in Aave Polygon V3.

## Motivation

Based on service provider and community feedback, this proposal aims to adjust AIP-254 to reintroduce LTV for non-bridged stablecoins in Aave Polygon V3, as they carry no rehypothecation risk. It also reduces stablecoin E-mode LT in Aave Polygon V3 due to insufficient stablecoin/stablecoin trading volume to justify the current risk level.

USDT is scheduled to migrate to the USDT0 standard soon, as recently implemented on networks like Arbitrum. To promote stablecoin diversity and taking an optimistic view on the reduction of bridge risk for this asset, this proposal aims to restore an LTV for USDT.

## Specification

Aave Polygon V3 stablecoins suggested risk parameters

| Deployment | Asset | Current LTV | Proposed LTV |
| ---------- | ----- | ----------- | ------------ |
| Polygon V3 | USDT  | 0%          | 70%          |
| Polygon V3 | USDC  | 0%          | 70%          |

---

Aave Polygon Stablecoin E-mode

- Make all stablecoins non-borrowable in the stablecoin E-mode category

| Current LTV | Proposed LTV | Current LT | Proposed LT |
| ----------- | ------------ | ---------- | ----------- |
| 93%         | 91.25%       | 95%        | 94.25%      |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250228_AaveV3Polygon_AdjustAavePolygonV3RiskParameters/AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250228_AaveV3Polygon_AdjustAavePolygonV3RiskParameters/AaveV3Polygon_AdjustAavePolygonV3RiskParameters_20250228.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-adjust-risk-parameters-for-aave-v2-and-v3-on-polygon/20211/60)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
