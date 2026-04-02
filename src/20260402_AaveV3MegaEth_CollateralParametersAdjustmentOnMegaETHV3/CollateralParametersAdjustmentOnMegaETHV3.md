---
title: "Collateral Parameters Adjustment on MegaETH v3"
author: "Chaos Labs (implemented by Aave Labs)"
discussions: "https://governance.aave.com/t/direct-to-aip-collateral-parameters-adjustment-on-aave-v3-megaeth-instance/24334"
snapshot: direct-to-aip
---

## Simple Summary

This proposal recommends enabling general market (non-eMode) collateral parameters for WETH, BTC.b, and wstETH on the MegaETH Aave deployment. The proposed configurations carry slightly more conservative LTV and liquidation threshold values relative to their respective eMode configurations, reflecting the unconstrained collateral environment of the main pool, and are intended to support cross-margin use cases without compromising the risk isolation benefits of the existing eMode structure.

## Motivation

The MegaETH deployment was configured at launch with WETH, BTC.b, and wstETH as collateral-enabled exclusively within their respective eModes, with no general market collateral parameters assigned. The rationale is grounded in the configurability improvements introduced by Aave v3.6, which, for the first time, allows assets to carry eMode-specific collateral roles independently of their base reserve configuration. Under prior versions of the protocol, enabling an asset as collateral within an eMode required it to also be collateralizable in the main pool, coupling general market risk exposure to correlated-asset use cases. The eMode-only approach leverages the decoupling afforded by v3.6 to scope each asset’s collateral role to the environments where its risk is best understood and bounded: tightly parameterized, high-correlation sub-markets where liquidation dynamics, oracle behavior, and collateral composition can be monitored and adjusted independently.

The consequence of this configuration is that users seeking to post a combination of WETH, BTC.b, and wstETH as collateral against a single borrow position are currently unable to do so. Aave restricts each account to one active eMode at a time, meaning a user cannot simultaneously hold positions across the WETH/Stablecoins and BTC.b/Stablecoins eModes. While cross-margin demand has historically represented a small fraction of activity on new Aave deployments, this constraint effectively excludes a segment of users whose borrowing needs do not map cleanly onto a single correlated asset pair.

To address this without reverting the risk isolation improvements introduced at launch, Chaos Labs recommends assigning general market collateral parameters to WETH, BTC.b, and wstETH. These parameters will be set at a more conservative LTV and liquidation threshold than their eMode equivalents, reflecting the fact that collateral composition in the main pool is unconstrained and liquidation pathways are consequently less predictable. This configuration preserves the eMode structure and its associated parameterization advantages in full; eMode users retain access to higher capital efficiency within their designated correlated environments, while opening a functional cross-margin path for users who prefer flexibility over efficiency.

#### On-Chain Liquidity

A key input to the parameterization of general market configurations is the accessible liquidity available to liquidators under stressed conditions. While the reported TVL figures for WETH and BTC.b pools on MegaETH appear meaningful in nominal terms, approximately $30M and $2M TVL respectively, both AMM pools are deployed with full-range liquidity, which materially reduces the effective depth available at price levels relevant to liquidation execution.

In a full-range pool, liquidity is distributed uniformly across all price ticks, meaning only a small fraction of the total TVL is concentrated around the current market price. As a result, the slippage-adjusted liquidity accessible within a liquidation bonus is substantially lower than the reported TVL implies. Based on current pool composition and price levels, the effective liquidation capacity is approximately 250 WETH and 1 BTC.b before price impact materially erodes liquidation profitability.

However, wstETH liquidity profile, thanks to its highly concentrated wstETH/WETH pool, presents a similar liquidity profile as WETH. As such, Chaos Labs recommends setting the general market LTV and liquidation threshold for wstETH equal to its current eMode parameters, rather than applying the conservative haircut proposed for WETH and BTC.b. Concurrently, we recommend a modest increase to the wstETH eMode parameters to preserve the capital efficiency differential that incentivizes users to operate within the correlated environment.

## Specification

The specification below outlines the proposed parameter values.

| Parameter             | WETH   | BTC.b  | wstETH |
| --------------------- | ------ | ------ | ------ |
| Borrowable            | No     | No     | No     |
| Collateral Enabled    | Yes    | Yes    | Yes    |
| LTV                   | 78.00% | 68.00% | 75.00% |
| Liquidation Threshold | 81.00% | 73.00% | 79.00% |
| Liquidation Bonus     | 5.50%  | 6.50%  | 6.50%  |

wstETH Stablecoins #3

| Parameter             | wstETH | USDT0 | USDM |
| --------------------- | ------ | ----- | ---- |
| Collateral            | Yes    | No    | No   |
| Borrowable            | No     | Yes   | Yes  |
| Max LTV               | 78.50% | -     | -    |
| Liquidation Threshold | 81.00% | -     | -    |
| Liquidation Bonus     | 6.50%  | -     | -    |

## References

- Implementation: [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260402_AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3/AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402.sol)
- Tests: [AaveV3MegaEth](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260402_AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3/AaveV3MegaEth_CollateralParametersAdjustmentOnMegaETHV3_20260402.t.sol)
- Snapshot: Direct-To-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-collateral-parameters-adjustment-on-aave-v3-megaeth-instance/24334)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
