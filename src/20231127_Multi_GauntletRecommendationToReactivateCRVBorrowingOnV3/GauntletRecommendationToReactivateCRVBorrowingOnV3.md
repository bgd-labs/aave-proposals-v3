---
title: "Gauntlet recommendation to reactivate CRV borrowing on v3"
author: "Gauntlet"
discussions: "https://governance.aave.com/t/arfc-gauntlet-recommendation-to-re-enable-crv-borrowing-on-v3-ethereum-polygon/15513"
---

## Simple Summary

During the Vyper exploit, CRV borrowing was disabled on Ethereum and Polygon v3 with the hope of mitigating downward CRV price movement in light of excess CRV positions on Aave v2.

Given that a large majority of those CRV positions with excess risk have left the system, Gauntlet recommends reactivating CRV borrowing. In order to do so, we recommend a few other changes to CRV parameterization.

## Specification

| Chain       | Asset | Parameter    | Current Value | Recommended Value |
| ----------- | ----- | ------------ | ------------- | ----------------- |
| Ethereum v3 | CRV   | supplyCap    | 51m           | 7.5m              |
| Ethereum v3 | CRV   | borrowCap    | 7.7m          | 5m                |
| Ethereum v3 | CRV   | debtCeiling  | $5m           | $1m               |
| Ethereum v3 | CRV   | isBorrowable | False         | True              |
| Polygon v3  | CRV   | borrowCap    | 900k          | 300k              |
| Polygon v3  | CRV   | isBorrowable | False         | True              |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/AaveV3Ethereum_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/AaveV3Ethereum_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231127_Multi_GauntletRecommendationToReactivateCRVBorrowingOnV3/AaveV3Polygon_GauntletRecommendationToReactivateCRVBorrowingOnV3_20231127.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x2db7ffd336637173a5c58f6bbb3609c17bba1b16740d8b3b0ea23a694f4c7b52)
- [Discussion](https://governance.aave.com/t/arfc-gauntlet-recommendation-to-re-enable-crv-borrowing-on-v3-ethereum-polygon/15513)

## Disclaimer

Gauntlet has not received any compensation from any third-party in exchange for recommending any of the actions contained in this proposal.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).

_By approving this proposal, you agree that any services provided by Gauntlet shall be governed by the terms of service available at gauntlet.network/tos._
