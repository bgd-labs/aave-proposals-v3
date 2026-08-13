---
title: "Asset Listing - Pendle PT-USDG X Layer"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-pt-usdg-x-layer/25464"
---

## Simple Summary

This AIP lists PT-USDG-29OCT2026, the Pendle Principal Token for USDG maturing on 29 October 2026, on the Aave V3 X Layer instance as a non-borrowable asset, usable as collateral exclusively within a dedicated PT-USDG/stablecoin eMode.

## Motivation

USDG is already a live reserve on Aave V3 X Layer, and Pendle has deployed a PT-USDG market on the network. Listing the PT enables fixed-yield USDG positions as collateral against stablecoin debt, mirroring the treatment of Pendle PT stablecoin assets on other Aave instances. X Layer is allocating incentives toward PT-USDG supplied on Aave.

The PT is priced via the dynamic linear discount rate oracle used for Pendle PTs across Aave V3; the oracle deployment and its discount parameters, along with final risk parameters, will be provided by the Risk Service Provider prior to the AIP stage.

## Specification

| Field             | Value                                                                                                                           |
| ----------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Asset             | PT-USDG-29OCT2026                                                                                                               |
| PT token          | [0x9a09a9E491DB3dd8Ada5B1B889991AC9Ad5fd362](https://www.oklink.com/x-layer/address/0x9a09a9E491DB3dd8Ada5B1B889991AC9Ad5fd362) |
| Pendle market     | [0xcFB506cb34DD340e80d3dF8764182a5187636032](https://www.oklink.com/x-layer/address/0xcFB506cb34DD340e80d3dF8764182a5187636032) |
| SY token          | [0x1F336F899f77B084133bc14a81170837ED618D1b](https://www.oklink.com/x-layer/address/0x1F336F899f77B084133bc14a81170837ED618D1b) |
| YT token          | [0x5E67C8D19EEa0Fd0d0Da35E4008b56e87C931724](https://www.oklink.com/x-layer/address/0x5E67C8D19EEa0Fd0d0Da35E4008b56e87C931724) |
| Underlying (USDG) | [0x4ae46a509F6b1D9056937BA4500cb143933D2dc8](https://www.oklink.com/x-layer/address/0x4ae46a509F6b1D9056937BA4500cb143933D2dc8) |
| Maturity          | 29 October 2026                                                                                                                 |

**New eMode** (indicative target, subject to Risk Service Provider assessment):

| eMode               | Collateral        | Borrowable       | LTV | LT  | Liq. Bonus |
| ------------------- | ----------------- | ---------------- | --- | --- | ---------- |
| PT USDG Stablecoins | PT-USDG-29OCT2026 | USDT0, USDG, GHO | 93% | 95% | 2.44%      |

The table below illustrates the configured risk parameters for **PT_USDG_29OCT2026**

| Parameter                 |                                       PT-USDG-29OCT2026 |
| ------------------------- | ------------------------------------------------------: |
| Isolation Mode            |                                                      No |
| Borrowable                |                                                      No |
| Collateral Enabled        |                                        No (E-Mode only) |
| Supply Cap                |                                              35,000,000 |
| Borrow Cap                |                                                       1 |
| Debt Ceiling              |                                                     N/A |
| LTV                       |                                                      0% |
| Liquidation Threshold     |                                                      0% |
| Liquidation Bonus         |                                                      0% |
| Liquidation Protocol Fee  |                                                     10% |
| Reserve Factor            |                                                     20% |
| Base Variable Borrow Rate |                                                      0% |
| Variable Rate Slope 1     |                                                     10% |
| Variable Rate Slope 2     |                                                    300% |
| Optimal Utilization       |                                                     45% |
| Flashloanable             |                                                     Yes |
| Oracle                    | Placeholder — pending linear discount oracle deployment |

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260811_AaveV3XLayer_AssetListingPendlePTUSDGXLayer/AaveV3XLayer_AssetListingPendlePTUSDGXLayer_20260811.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260811_AaveV3XLayer_AssetListingPendlePTUSDGXLayer/AaveV3XLayer_AssetListingPendlePTUSDGXLayer_20260811.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-pt-usdg-x-layer/25464)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
