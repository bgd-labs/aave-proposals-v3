---
title: "Asset Listing - Pendle PT-AUSD Monad"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-onboard-pt-ausd-8oct2026-to-aave-v3-monad-instance/25331"
snapshot: "https://snapshot.org/#/s:aavedao.eth/proposal/0x1d5029f1b99b62843590e28d027a1a5aa21f4fe19f175284197c58779db14027"
---

## Simple Summary

This AIP lists PT-AUSD-8OCT2026, the Pendle Principal Token for AUSD maturing on 8 October 2026, on the Aave V3 Monad instance as a non-borrowable asset, usable as collateral exclusively within a dedicated PT-AUSD/stablecoin eMode.

## Motivation

AUSD is already a live reserve on Aave V3 Monad and Pendle operates a liquid PT-AUSD market on the network. Listing the PT enables fixed-yield AUSD positions as collateral against stablecoin debt, mirroring the treatment of Pendle PT stablecoin assets on other Aave instances.

The proposal was approved via ARFC and Snapshot (99.99% For), with final risk parameters provided by LlamaRisk, including the linear discount oracle rates: `initialDiscountRatePerYear` 6.661% and `maxDiscountRatePerYear` 8.829%. The PT is priced via the deployed linear discount oracle [0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127](https://monadscan.com/address/0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127) (`PT Capped AUSD AUSD/USD linear discount 8OCT2026`).

## Specification

| Field             | Value                                                                                                                  |
| ----------------- | ---------------------------------------------------------------------------------------------------------------------- |
| Asset             | PT-AUSD-8OCT2026                                                                                                       |
| PT token          | [0x9FC74f8Ed616B5BaF52a170caa97d6d3898602d1](https://monadscan.com/address/0x9FC74f8Ed616B5BaF52a170caa97d6d3898602d1) |
| Pendle market     | [0x6f99CF00ee7290aE78a072Bb6910eF72D1129fE7](https://monadscan.com/address/0x6f99CF00ee7290aE78a072Bb6910eF72D1129fE7) |
| SY token          | [0xBA3d60f5000f472aef947FB8020a3E6319F9a0B7](https://monadscan.com/address/0xBA3d60f5000f472aef947FB8020a3E6319F9a0B7) |
| YT token          | [0xEdDeE9C0B56248d70A9BFdD103f8bD97C35DfD89](https://monadscan.com/address/0xEdDeE9C0B56248d70A9BFdD103f8bD97C35DfD89) |
| Underlying (AUSD) | [0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a](https://monadscan.com/address/0x00000000eFE302BEAA2b3e6e1b18d08D69a9012a) |
| Maturity          | 8 October 2026                                                                                                         |

**New eMode** (per LlamaRisk's final recommendation):

| eMode                   | Collateral       | Borrowable             | LTV | LT  | Liq. Bonus | Isolated |
| ----------------------- | ---------------- | ---------------------- | --- | --- | ---------- | -------- |
| PT_Agora\_\_Stablecoins | PT-AUSD-8OCT2026 | USDT0, USDC, GHO, USDe | 93% | 95% | 2.44%      | Yes      |

The table below illustrates the configured risk parameters for **PT_AUSD_8OCT2026**

| Parameter                 |                                                                                                       PT-AUSD-8OCT2026 |
| ------------------------- | ---------------------------------------------------------------------------------------------------------------------: |
| Isolation Mode            |                                                                                                                     No |
| Borrowable                |                                                                                                                     No |
| Collateral Enabled        |                                                                                                       No (E-Mode only) |
| Supply Cap                |                                                                                                             20,000,000 |
| Borrow Cap                |                                                                                                                      1 |
| Debt Ceiling              |                                                                                                                    N/A |
| LTV                       |                                                                                                                     0% |
| Liquidation Threshold     |                                                                                                                     0% |
| Liquidation Bonus         |                                                                                                                     0% |
| Liquidation Protocol Fee  |                                                                                                                    10% |
| Reserve Factor            |                                                                                                                    20% |
| Base Variable Borrow Rate |                                                                                                                     0% |
| Variable Rate Slope 1     |                                                                                                                    10% |
| Variable Rate Slope 2     |                                                                                                                   300% |
| Optimal Utilization       |                                                                                                                    45% |
| Flashloanable             |                                                                                                                    Yes |
| Oracle                    | [0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127](https://monadscan.com/address/0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127) |

**Linear Discount Rate Oracle**

| Parameter                  | Value                                                                                                                  |
| -------------------------- | ---------------------------------------------------------------------------------------------------------------------- |
| initialDiscountRatePerYear | 6.661%                                                                                                                 |
| maxDiscountRatePerYear     | 8.829%                                                                                                                 |
| Oracle                     | [0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127](https://monadscan.com/address/0x6D8f31268E94Bec0b0E07bc06b561b8B749F3127) |

## References

- Implementation: [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/d7730f38ffd9b19b5a05c96b5a12e731148b627f/src/20260811_AaveV3Monad_AssetListingPendlePTAUSDMonad/AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811.sol)
- Tests: [AaveV3Monad](https://github.com/aave-dao/aave-proposals-v3/blob/d7730f38ffd9b19b5a05c96b5a12e731148b627f/src/20260811_AaveV3Monad_AssetListingPendlePTAUSDMonad/AaveV3Monad_AssetListingPendlePTAUSDMonad_20260811.t.sol)
- [Snapshot](https://snapshot.org/#/s:aavedao.eth/proposal/0x1d5029f1b99b62843590e28d027a1a5aa21f4fe19f175284197c58779db14027)
- [Discussion](https://governance.aave.com/t/arfc-onboard-pt-ausd-8oct2026-to-aave-v3-monad-instance/25331)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
