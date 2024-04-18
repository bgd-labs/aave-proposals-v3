---
title: "Temporary Freeze of Long-Tail V2 Assets"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/arfc-temporary-freeze-of-long-tail-v2-assets/17403"
---

## Simple Summary

A proposal to freeze USDP, GUSD, LUSD, FRAX, sUSD and AAVE on Aave V2.

## Motivation

As part of the deprecation plan for V2 markets, and given the recent market volatility and specifically the [USDP price spike](https://governance.aave.com/t/usdp-price-spike-impact-04-16-2024/17391), we advise reducing additional exposure to all non-major assets across V2, disabling new supply and borrows.

To minimize the governance overhead, we recommend a temporary freeze vote of all non-major assets across V2, namely USDP, GUSD, LUSD, FRAX, sUSD, and AAVE, via the [direct-to-AIP framework](https://governance.aave.com/t/arfc-direct-to-aip-framework/13913).

We plan to submit a follow-up proposal to deprecate these assets through the standard governance process so that the community can decide on the future utilization of these assets.

Furthermore, we would like to highlight the [upcoming implementation of CAPO on v2 assets](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/30), mitigating the risk of upward Oracle manipulation. This enhancement aims to protect borrowers from unexpected liquidations due to price spikes or potential manipulation incidents, such as the recent surge in USDP prices

## Specification

The proposal will call the freezeReserve() function for USDP, GUSD, LUSD, FRAX, sUSD and AAVE.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ded7b56d9d2b3cb66a23ba9fa42cf9514a75a2ef/src/20240418_Multi_TemporaryFreezeOfLongTailV2Assets/AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/ded7b56d9d2b3cb66a23ba9fa42cf9514a75a2ef/src/20240418_Multi_TemporaryFreezeOfLongTailV2Assets/AaveV2Polygon_TemporaryFreezeOfLongTailV2Assets_20240418.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/ded7b56d9d2b3cb66a23ba9fa42cf9514a75a2ef/src/20240418_Multi_TemporaryFreezeOfLongTailV2Assets/AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/ded7b56d9d2b3cb66a23ba9fa42cf9514a75a2ef/src/20240418_Multi_TemporaryFreezeOfLongTailV2Assets/AaveV2Ethereum_TemporaryFreezeOfLongTailV2Assets_20240418.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/ded7b56d9d2b3cb66a23ba9fa42cf9514a75a2ef/src/20240418_Multi_TemporaryFreezeOfLongTailV2Assets/AaveV2Polygon_TemporaryFreezeOfLongTailV2Assets_20240418.t.sol), [AaveV2Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/ded7b56d9d2b3cb66a23ba9fa42cf9514a75a2ef/src/20240418_Multi_TemporaryFreezeOfLongTailV2Assets/AaveV2Avalanche_TemporaryFreezeOfLongTailV2Assets_20240418.t.sol)
- [Discussion](https://governance.aave.com/t/arfc-temporary-freeze-of-long-tail-v2-assets/17403)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
