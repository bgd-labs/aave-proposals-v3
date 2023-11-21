---
title: "Gauntlet recommendation to lower stMATIC, MaticX non-emode LT, pt 2"
author: "Gauntlet"
discussions: "https://governance.aave.com/t/arfc-gauntlet-recommendation-to-lower-stmatic-maticx-non-emode-lt-pt-2/15314"
---

## Summary

Gauntlet recommends follow-ups to our previous recommendations on lowering stMATIC / MaticX non-emode LT. These recommendations are geared towards the following:

- Reducing risks associated with increased stablecoin borrowing against LST collateral, amidst lower MATIC LST liquidity
- Lower risks of reduced WMATIC supply in the future, which may cause long-term growth risk for Polygon v3
- Encourage WMATIC borrowing against MATIC LST collateral

## Specification

| Asset   | Parameter            | Current Value | Recommended Value |
| ------- | -------------------- | ------------- | ----------------- |
| stMATIC | LiquidationThreshold | 60%           | 56%               |
| MaticX  | LiquidationThreshold | 62%           | 58%               |

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0b832342a79ecd704e399fad3567e2dd146bfd9a/src/20231117_AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2/AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/0b832342a79ecd704e399fad3567e2dd146bfd9a/src/20231117_AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2/AaveV3Polygon_GauntletRecommendationToLowerStMATICMaticXNonEmodeLTPt2_20231117.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xc59f0e1bd1463285d1fca9c3771d92dc227915615e475b84e6e4033f281ff079)
- [Discussion](https://governance.aave.com/t/arfc-gauntlet-recommendation-to-lower-stmatic-maticx-non-emode-lt-pt-2/15314)

## Disclaimer

Gauntlet has not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
