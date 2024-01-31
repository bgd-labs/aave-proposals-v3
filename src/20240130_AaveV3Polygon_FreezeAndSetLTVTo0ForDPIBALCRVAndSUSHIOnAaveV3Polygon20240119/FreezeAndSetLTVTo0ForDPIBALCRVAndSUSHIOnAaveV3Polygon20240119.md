---
title: "Freeze and set LTV to 0 for DPI, BAL, CRV, and SUSHI on Aave v3 Polygon, 2024.01.19"
author: "Gauntlet"
discussions: "https://governance.aave.com/t/arfc-recommendation-to-freeze-and-set-ltv-to-0-on-low-cap-aave-v3-polygon-collateral-assets/16311"
snapshot: https://snapshot.org/#/aave.eth/proposal/0x8a190af80cffafcbca70727c807ef86933b2e08b5212b447eafab976a9612e75
---

## Simple Summary

A proposal to freeze and set LTV to 0 for DPI, BAL, CRV, and SUSHI on Aave v3 Polygon. For more details, see the full forum post [here](https://governance.aave.com/t/arfc-recommendation-to-freeze-and-set-ltv-to-0-on-low-cap-aave-v3-polygon-collateral-assets/16311).

## Motivation

The primary reason for keeping smaller-cap assets like DPI, BAL, CRV, and SUSHI is to offer a diverse range of assets to Aave. To prioritize capital efficiency, Gauntlet advises freezing these assets and setting their Loan-to-Value (LTV) to 0 on Aave v3 Polygon.

## Specification

| Asset | Current LTV | Rec LTV | Current is_frozen | Rec is_frozen |
| :---- | ----------: | ------: | ----------------: | ------------: |
| DPI   |       2,000 |       0 |             False |          True |
| BAL   |       2,000 |       0 |             False |          True |
| CRV   |       3,500 |       0 |             False |          True |
| SUSHI |       2,000 |       0 |             False |          True |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240130_AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119/AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240130_AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119/AaveV3Polygon_FreezeAndSetLTVTo0ForDPIBALCRVAndSUSHIOnAaveV3Polygon20240119_20240130.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x598f04c1f4fb2acba0a9bdaeb2b18e6e1f43b4c62845ee4b81ae5596a6fc2076)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x049fc4fea64a71937882047f1c0e3f39eb96c332f016a7a4b04320846ba55e59)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x04a921887dcb54ec68ceb231e7cc2f64eac443b8cde47f0f5eecbd51b3cffef1)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x8a190af80cffafcbca70727c807ef86933b2e08b5212b447eafab976a9612e75)
- [Discussion](https://governance.aave.com/t/arfc-recommendation-to-freeze-and-set-ltv-to-0-on-low-cap-aave-v3-polygon-collateral-assets/16311)

## Disclaimer

Gauntlet has not been compensated by any third party for publishing this ARFC.

## Copyright

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
