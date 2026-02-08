---
title: "Increase WBTC Liquidation Bonus and EURS Reserve Factor on Polygon V3 "
author: "Chaos Labs (implemented by Aavechan Initiative @aci via Skyward)"
discussions: "https://governance.aave.com/t/direct-to-aip-increase-wbtc-liquidation-bonus-and-eurs-reserve-factor-on-polygon-v3/24029"
---

## Overview

This proposal recommends (i) increasing the liquidation bonus (LB) for WBTC on Aave v3 Polygon from 6.5% to 8.5%, and (ii) increasing the EURS reserve factor from 50% to 99%. The primary motivation is not general liquidation efficiency, but rather a specific and persistent mode observed in the Polygon market: a large EURS-denominated debt position has remained liquidatable for an extended period of time without being meaningfully resolved due to EURS liquidity constraints. In this context, the liquidation bonus is best understood as a mechanism to import cross-chain arbitrage capacity, rather than a purely local incentive adjustment, while the reserve factor adjustment minimizes continued value leakage to deprecated suppliers and incentivizes capital reallocation toward peg-arbitrage activity that can increase EURS liquidity availability for liquidation flow.

## Context and Motivation

During the recent market drawdown over the past few days, we have observed a particularly large WBTC collateralized EURS debt position on Polygon v3 become eligible for liquidation, at an initial sheer size of 1.06M EURS ($1.167M). Notably, EURS has been effectively **deprecated** on Aave since July 2025, which increases the importance of resolving residual exposure efficiently rather than allowing it to persist as a long-lived tail risk.

In practice, however, EURS debt on Polygon has proven difficult to liquidate at a meaningful size. Rather than clearing in meaningful chunks, liquidations have occurred almost exclusively through high-frequency, low-notional events, often only a few hundred dollars, indicating that liquidators are constrained to operate at the margin. This has produced a prolonged “trickle liquidation” regime in which the position remains below threshold and is reduced only incrementally through repeated micro-liquidations, rather than through decisive deleveraging. Since its eligibility on January 31st, nearly 477K EURS ($562K) has been liquidated thus far, stemming from 1814 liquidations with an average liquidation size of $262.71, with an effective marginal “bad debt” BTC price of $63K.

![position_history_0x1fa5b0_04b137_millions_wide (1)|1897x1372](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/e/e4e96b4b543082164750992e55f8ae46f42dedea.png)

![eurs_liquidation_size_distribution_polygon_v3 (1)|2000x1600](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/c/c209648f0369c5a2c2ceb9e7c36505702c44ded6.png)

Among other marginal EURS debt positions following the same fate, the aggregate debt size of this reserve has fallen to nearly $900K worth, a near 36% dropoff since liquidations commenced.

![image - 2026-02-08T151316.731|958x646](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/d/d6af287d1e5c0ff01fc7a965a414938129756fe3.png)

### EURS Peg Behavior

Uniquely, the EURS market price has effectively converged to an endogenous clearing level created by the interaction of the oracle and liquidation incentives. EURS debt is valued using the EUR/USD feed (currently ~1.186), and liquidation profitability is determined by the collateral-side discount, currently 6.5% for WBTC. In an environment where EURS spot liquidity is relatively thin and supply-increasing arbitrage is limited, the accumulated liquidation flow itself becomes price-setting: the market clears when liquidators repeatedly source and recycle limited EURS liquidity while still extracting the liquidation spread. Empirically, this has produced a stable convergence point around ~$1.24 per EURS, i.e., approximately the oracle-implied USD value adjusted by the existing liquidation bonus.

![image - 2026-02-08T151319.373|1860x678](https://europe1.discourse-cdn.com/flex013/uploads/aave/original/2X/c/ccb257750fad6bea15ba87ace6397494d4081436.png)

At current, exhausted liquidity levels, this equilibrium manifests as reactive, flow-dependent liquidations; trickle liquidations occur primarily when an external user sells EURS into available depth, and that sell is frequently followed by a near-equivalent EURS buy from liquidators to execute a marginal liquidation and recycle the limited liquidity.

As a result, the liquidation opportunity is structurally more complex than typical stablecoin cases, as observed by the lack of an efficient arbitrage market due to the absence of EURS minting: profitability is highly sensitive to the liquidation bonus, slippage, and cross-venue execution overhead. Under these conditions, the liquidation bonus is one of the few controllable levers available to shift the equilibrium in a way that increases the feasibility of resolving debt at a meaningful size; a higher bonus raises the effective clearing level at which EURS can be sourced while still supporting positive liquidation economics, which in turn enables cross-chain arbitrageurs to acquire EURS from deeper venues (notably the $4M TVL EURS crypto-swap [Curve pool](https://www.curve.finance/dex/ethereum/pools/eursusd/deposit) on Ethereum) and route it into liquidation flow, overcoming local depth constraints and materially increasing potential liquidation throughput while simultaneously creating a larger theoretical economic incentive to “sell” EURS on the market.

## Recommendation

Given the observed behavior of EURS liquidations on Polygon, the persistence of a large liquidatable EURS debt position, and the structural constraints preventing liquidation at a meaningful size, temporarily increasing the WBTC liquidation bonus to 8.5% is a reasonable risk-mitigating adjustment. The intent is not merely to marginally improve liquidation profitability, but to shift the effective clearing level upward, raising the expected market price at which EURS can be sourced for liquidations and making cross-chain liquidation pathways economically viable at scale.

In parallel, we propose increasing the EURS reserve factor from 50% to 99% to minimize value leakage to deprecated EURS suppliers (1.95M EURS) and discourage residual supply from remaining in the market. Under the current market structure, continuing to remunerate legacy supply effectively subsidizes inactive liquidity while doing little to improve liquidation throughput. Raising the reserve factor materially reduces this subsidy, encouraging suppliers to unwind their positions and redeploy capital toward peg-arbitrage activity; hypothetically increasing the availability of EURS liquidity and improving the feasibility of liquidation-driven flows. Simultaneously, a 99% reserve factor renders EURS debt growth effectively virtual by preventing ongoing interest accrual from being meaningfully transferred to suppliers while the market remains in a liquidation-dominated equilibrium.

## Specification

| **Parameter**     | **Instance** | **Asset** | **Current Value** | **Recommended Value** |
| ----------------- | ------------ | --------- | ----------------- | --------------------- |
| Liquidation Bonus | Polygon v3   | WBTC      | 6.5%              | 8.5%                  |
| Reserve Factor    | Polygon v3   | EURS      | 50%               | 99%                   |

## Next Steps

We will proceed with implementing an immediate 0.5% increase in the liquidation bonus to 7% via the Risk Steward process, subject to its constraint.

## Disclosure

Chaos Labs has not been compensated by any third party for publishing this proposal.

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260208_AaveV3Polygon_IncreaseWBTCLiquidationBonusAndEURSReserveFactorOnPolygonV3/AaveV3Polygon_IncreaseWBTCLiquidationBonusAndEURSReserveFactorOnPolygonV3_20260208.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20260208_AaveV3Polygon_IncreaseWBTCLiquidationBonusAndEURSReserveFactorOnPolygonV3/AaveV3Polygon_IncreaseWBTCLiquidationBonusAndEURSReserveFactorOnPolygonV3_20260208.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-increase-wbtc-liquidation-bonus-and-eurs-reserve-factor-on-polygon-v3/24029)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain).
