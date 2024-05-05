---
title: "Polygon V2 Reserve Factor Updates & Interest Rate Increases"
author: "@karpatkey_TokenLogic & @ChaosLabs"
discussions: "https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252"
---

## Simple Summary

This AIP is a continuation of proposal 68 on Governance v3 and increases the Reserve Factor (RF) for assets on Polygon v2 by 5.00%, up to a maximum of 99.99%.

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by up to 5%.

Because of the relation in this forum [post](https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252) to the topic of reserve factor updates, this publication also revises the Borrow Rate on Polygon v2 to provide further encouragement for users to migrate to Aave v3.

Over the last [8 months](https://governance-v2.aave.com/governance/proposal/284/) the Reserve Factor (RF) on Polygon v2 has gradually increased from as low as 21.00% to 99.99%. As a result, deposit yield converged to zero and the capital efficiency of Aave v2 has been reduced on Polygon.
With the RF now approaching the maximum across all reserves, this publication seek to gradually increase the cost of capital via periodic borrow rate adjustments, every two weeks in a predictable fashion.
Based upon recent borrow rates behaviour, the market has demonstrated the ability to withstand periods of elevated borrowing rates.

## Non Frozen Assets

For non-frozen assets, this proposal recommends increasing the Slope1 parameter by 75bps every two weeks, or 1.5% per month, to encourage further migration of users from v2 to v3. The outcome of this [vote](https://snapshot.org/#/aave.eth/proposal/0xe2dd228640c3cad93f5418c40c4b5743b3c6c85aa0aae9eee53cbdbca2ed5c2d) has been taken into consideration when drafting the current IR parameters included in this proposal. In the specific case of DAI, USDC and USDT the 75bps increase takes effect on the recently revised harmonized rate of 9% across all markets.
The Slope2 parameter is to be revised to 134.00% to discourage utilisation exceeding the Uoptimal value. Note, several reserves are experiencing utilisation marginally exceeding Uoptimal.
As utilisation of each reserve decreases over time, the Uoptimal will be periodically lowered to discourage new debt positions emerging. Any proposed changes to the Uoptimal parameter will be presented via a separate ARFC.
Upon implementation, this change will not trigger liquidation of any users funds and will gradually increase the cost for users who remain on v2. Please note, there is a Migration Tool that was developed by BGD to aid users migrating from v2 to v3.
Assets in scope: DAI, MATIC, wBTC, wETH, USDC and USDT.

## Frozen Assets

Each frozen reserve contains a small portion of funds with a very minimal amount of debt. For these assets we recommend a more aggressive implementation: reduce the Uoptimal to 10.00%, revise Slope1 to 50.00% and Slope2 to 134.00% - with the exception of BAL, which receives a Uoptimal of 20% due to current utilisation being around 15%.

## Specification

The following parameters are to be updated as follows:

| Asset | Reserve Factor |
| ----- | -------------- |
| DAI   | 96.00%         |
| USDC  | 98.00%         |
| USDT  | 97.00%         |

The following parameters are to be updated as follows in the Polygon V2 Market:
| Asset | Current Slope1 | Proposed Slope1 | Current Uoptimal | Proposed Uoptimal | Current Slope2 | Proposed Slope2 |
| :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| BAL | 22.00% | 50.00% | 65.00% | 20.00% | 236.00% | 134.00% |
| CRV | 14.00% | 50.00% | 25.00% | 10.00% | 392.00% | 134.00% |
| DAI | 12.00% | 9.75% | 71.00% | 71.00% | 105.00% | 134.00% |
| GHST | 7.00% | 50.00% | 23.00% | 10.00% | 413.00% | 134.00% |
| LINK | 7.00% | 50.00% | 25.00% | 10.00% | 402.00% | 134.00% |
| USDT | 12.00% | 9.75% | 52.00% | 52.00% | 236.00% | 134.00% |
| wBTC | 4.00% | 4.75% | 37.00% | 37.00% | 536.00% | 134.00% |
| wETH | 4.00% | 4.75% | 40.00% | 40.00% | 167.00% | 134.00% |
| wMATIC| 6.00% | 6.75% | 48.00% | 48.00% | 440.00% | 134.00% |
| USDC | 12.00% | 9.75% | 77.00% | 77.00% | 134.00% | 134.00% |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/7da007e0d03a34a6bdcc86b628f7d7840e07d41a/src/20240412_AaveV2Polygon_ReserveFactorAndBorrowRateUpdates/AaveV2Polygon_ReserveFactorAndBorrowRateUpdates_20240412.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/7da007e0d03a34a6bdcc86b628f7d7840e07d41a/src/20240412_AaveV2Polygon_ReserveFactorAndBorrowRateUpdates/AaveV2Polygon_ReserveFactorAndBorrowRateUpdates_20240412.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/22)
- [Discussion](https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x95643085ee16eb0eaa4110a9f0ea8223009f9521e596e1a958303705a5001363)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
