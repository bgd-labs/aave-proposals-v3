---
title: "Risk Parameter Updates - Increase USDe Debt Ceiling on V3 Ethereum"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-usde-debt-ceiling-on-v3-ethereum-07-22-2024/18325"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0xea1012aaf1fe660148cfe6265cbadf23b19bb44af609caaa51ab8d7194259c28"
---

## Simple Summary

A proposal to increase USDe’s debt ceiling.

## Motivation

USDe has reached its debt ceiling following rapid deposits and borrows against these deposits on Ethereum.

### Positions Analysis

There is currently one major user utilizing USDe as collateral on V3 Ethereum.
Account 0x8607a7d180de23645db594d90621d837749408d5 is borrowing $33.26 M in stables (USDC and USDT) against his $45.72 M in USDe. The user’s current health score is 1.03.

While this market is heavily concentrated, simulated transactions indicate that this position could be liquidated efficiently.

Borrows of USDe are more distributed and are against a variety of collateral.

### Liquidity

USDe liquidity has improved since the asset’s listing, with especially large growth on Curve, related to ENA token incentives provided in multiple pools.

It is critical to note that on-chain liquidity — as well as the ratio of sUSDe to USDe, amongst other things — is being shaped by ongoing ENA token incentives. While there is still ongoing speculative activity, our recommendations remain cautious, given that dynamics could change rapidly following this period of speculative activity.

We also note that USDe grew rapidly through May, reaching a high of over 3.6B, but has since declined to 3.4B. The reserve fund has also grown, though its size relative to USDe’s supply has fallen since the asset was listed, from 1.34% of total USDe supply to 1.33%.

We also note that the reserve fund has not grown in accordance with our recommendations following a detailed assessment of Ethena’s mechanism, which called for the fund to maintain “sufficient capital to cover a 4.3% drawdown at all times.”

### Recommendation

The current debt ceiling for USDe on V3 Ethereum, set at $40 M, has reached 100% utilization.

Given current market conditions, our Isolation Mode Methodology supports increasing the debt ceiling to $50 M.

It is important to note that the majority of USDe debt positions are concentrated within just one user, accounting for over 83% of the total debt (see Positions Analysis above).
While this concentration does not affect the current recommendation, it is something to continue monitoring and will be considered in future recommendations and cases of significant market changes.

## Specification

| Chain    | Asset | Parameter | Current Debt Ceiling | Recommended Debt Ceiling |
| -------- | ----- | --------- | -------------------- | ------------------------ |
| Ethereum | USDe  | LTV       | $40,000,000          | $50,000,000              |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240801_AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum/AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240801_AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum/AaveV3Ethereum_RiskParameterUpdatesIncreaseUSDeDebtCeilingOnV3Ethereum_20240801.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0xea1012aaf1fe660148cfe6265cbadf23b19bb44af609caaa51ab8d7194259c28)
- [Discussion](https://governance.aave.com/t/arfc-chaos-labs-risk-parameter-updates-increase-usde-debt-ceiling-on-v3-ethereum-07-22-2024/18325)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
