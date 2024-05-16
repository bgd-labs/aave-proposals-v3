---
title: "ReserveFactorUpdate"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/23?u=dd0sxx"
---

## Simple Summary

This AIP is composed of two actions:

- A continuation of proposal 96 on Governance v3 and increases the Reserve Factor (RF) for assets on Polygon v2 by 5.00%, up to a maximum of 99.99%
- And gradually revising the Borrow Rate, by increasing the Slope1 parameter by 75bps every two weeks, or 1.5% per month, on Polygon v2 to provide further encouragement for users to migrate to Aave v3.

## Motivation

This AIP will reduce deposit yield for assets on Polygon v2 by increasing the RF. With this upgrade being passed, users will be further encouraged to migrate from Polygon v2 to v3.

Increasing the RF routes a larger portion of the interest paid by users to Aave DAO's Treasury. User's funds are not at risk of liquidation and the borrowing rate remains unchanged.

Of the assets with an RF set at 99.99%, there is no change. All other asset reserves will have the RF increased by up to 5%.

For the borrow rate update:

Over the last 8 months 4 the Reserve Factor (RF) on Polygon v2 has gradually increased from as low as 21.00% to 99.99%. As a result, deposit yield converged to zero and the capital efficiency of Aave v2 has been reduced on Polygon.

With the RF now approaching the maximum across all reserves, this publication seek to gradually increase the cost of capital via periodic borrow rate adjustments, every two weeks in a predictable fashion.

Based upon recent borrow rates behaviour, the market has demonstrated the ability to withstand periods of elevated borrowing rates.

## Specification

The following parameters are to be updated as follows:

| Asset | Reserve Factor |
| ----- | -------------- |
| DAI   | 99.99%         |
| USDC  | 99.99%         |
| USDT  | 99.99%         |

| Asset | Current Slope1 | Proposed Slope1 |
| ----- | -------------- | --------------- |
| DAI   | 9.75%          | 10.50%          |
| USDT  | 9.75%          | 10.50%          |
| wBTC  | 4.75%          | 5.50%           |
| wETH  | 4.75%          | 5.50%           |
| wUSDC | 9.75%          | 10.50%          |

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240429_AaveV2Polygon_ReserveFactorUpdate/AaveV2Polygon_ReserveFactorUpdate_20240429.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240429_AaveV2Polygon_ReserveFactorUpdate/AaveV2Polygon_ReserveFactorUpdate_20240429.t.sol)
- [Discussion for the RF update](https://governance.aave.com/t/arfc-reserve-factor-updates-polygon-aave-v2/13937/23?u=dd0sxx)
- [Discussion for the BR update](https://governance.aave.com/t/arfc-polygon-v2-borrow-rate-adjustments/17252/5?u=dd0sxx)
- [Snapshot for the BR update](https://snapshot.org/#/aave.eth/proposal/0x95643085ee16eb0eaa4110a9f0ea8223009f9521e596e1a958303705a5001363)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
