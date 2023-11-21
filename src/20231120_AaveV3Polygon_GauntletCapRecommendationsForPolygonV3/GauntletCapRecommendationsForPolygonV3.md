---
title: "Gauntlet Cap Recommendations for Polygon v3"
author: "Gauntlet"
discussions: "https://governance.aave.com/t/arfc-gauntlet-cap-recommendations-for-polygon-v3-2023-11-03/15327"
---

## Summary

Gauntlet recommends parameter changes on Polygon Aave v3 market. For more details, see the full forum post [here](https://governance.aave.com/t/arfc-gauntlet-cap-recommendations-for-polygon-v3-2023-11-03/15327).

## Motivation

Per Gauntlet’s supply and borrow cap methodology, we recommend setting supply and borrow caps for agEUR and jEUR. Currently agEUR borrowing is disabled and cannot be used as collateral. jEUR is frozen. Despite this, all assets should have supply and borrow caps.

## Specification

| Chain   | Asset | Cap    | Current | Recommended |
| ------- | ----- | ------ | ------- | ----------- |
| Polygon | agEUR | Supply | -       | 300k        |
| Polygon | agEUR | Borrow | -       | 250k        |
| Polygon | jEUR  | Supply | -       | 120k        |
| Polygon | jEUR  | Borrow | -       | 100k        |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3933f440d8878ae9b21bc53e0afacdc2862882c3/src/20231120_AaveV3Polygon_GauntletCapRecommendationsForPolygonV3/AaveV3Polygon_GauntletCapRecommendationsForPolygonV3_20231120.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/3933f440d8878ae9b21bc53e0afacdc2862882c3/src/20231120_AaveV3Polygon_GauntletCapRecommendationsForPolygonV3/AaveV3Polygon_GauntletCapRecommendationsForPolygonV3_20231120.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xcab97d0cf0f484f3604f790234ca26b559b6c38c0b33ed1f7821b3d3340c9354)
- [Discussion](https://governance.aave.com/t/arfc-gauntlet-cap-recommendations-for-polygon-v3-2023-11-03/15327)

## Disclaimer

Gauntlet has not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
