---
title: " Remove USDe Debt Ceiling and Introduce USDe Stablecoins E-mode"
author: "Aave-Chan Initiative"
discussions: "https://governance.aave.com/t/arfc-remove-usde-debt-ceiling-and-introduce-usde-stablecoins-e-mode/21876"
---

## Simple Summary

Given the significant demand for USDe and its safe usage profile on Aave V3’s Ethereum Core deployment, Chaos Labs recommends removing the asset’s debt ceiling and introducing a new E-Mode configuration tailored to its current primary use case.

## Motivation

The proposal to lift the debt ceiling on USDe stems from its growing user demand and consistently strong risk profile. USDe’s appeal has been further amplified by the recent decline in the underlying yield of sUSDe, making the unstaked version (USDe) more attractive due to its deliberately enhanced points-earning potential in an effort to shift the incentive structure in accordance with aggregate revenue generation, earning 25x points as opposed to sUSDe’s 5x.

Over the past 30 days, the total supply of USDe has surged to 410M, led by two primary whitelisted USDe redemption addresses leveraging the reserve, periodically performing redemptions. However, its growth on Aave has been relatively capped at $86.4M due to the limitations imposed by the debt ceiling and its steward-governed constraints.

Conversely, due to dwindling yields, the sUSDe market has seen considerable outflows from Aave over the last 90 days, decreasing from nearly 1B to 175M today, with $135M in collateralized stablecoin debt.

Furthermore, USDe offers a lower risk profile compared to its staked counterpart, sUSDe, primarily due to the absence of the 7-day unstaking period as well as the use of an aggregate oracle that incorporates an exchange rate introduced through staking. This unstaking delay introduces liquidity constraints and potential exposure to short-term price volatility for sUSDe holders.

The initial implementation of a debt ceiling was intended as a protective measure to limit systemic exposure during the initial adoption period. However, historical data and recent [analyses](https://governance.aave.com/t/chaos-labs-update-on-bybit-security-event-and-usde-market-reaction/21158), including extensive stress tests and active redemption patterns, have shown robust stabilization mechanisms inherent to USDe, which effectively mitigate potential risks associated with price deviations. By eliminating the debt ceiling, Aave can better accommodate growing market demand and with the introduction of a custom E-Mode, provide users with greater flexibility to leverage USDe efficiently.

The recommended parameters for the USDe/Stablecoin E-Mode are slightly more aggressive than those for sUSDe/Stablecoin E-Mode, reflecting the lower risk profile.

## Specification

USDe on Aave V3 Ethereum Core

| Parameter      | Current Value | Recommended Value |
| -------------- | ------------- | ----------------- |
| Isolation-mode | Yes           | No                |
| Debt Ceiling   | 103,680,000   | -                 |

USDe/Stablecoin E-Mode

| Asset             | USDe | USDC | USDT | USDS |
| ----------------- | ---- | ---- | ---- | ---- |
| Collateral        | Yes  | No   | No   | No   |
| Borrowable        | No   | Yes  | Yes  | Yes  |
| LTV               | 90%  |      |      |      |
| LT                | 93%  |      |      |      |
| Liquidation Bonus | 2%   |      |      |      |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5013a4eb986252fb975a44a7841ccc490dbf7bb9/src/20250505_AaveV3Ethereum_RemoveUSDeDebtCeilingAndIntroduceUSDeStablecoinsEMode/AaveV3Ethereum_RemoveUSDeDebtCeilingAndIntroduceUSDeStablecoinsEMode_20250505.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/5013a4eb986252fb975a44a7841ccc490dbf7bb9/src/20250505_AaveV3Ethereum_RemoveUSDeDebtCeilingAndIntroduceUSDeStablecoinsEMode/AaveV3Ethereum_RemoveUSDeDebtCeilingAndIntroduceUSDeStablecoinsEMode_20250505.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/arfc-remove-usde-debt-ceiling-and-introduce-usde-stablecoins-e-mode/21876)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
