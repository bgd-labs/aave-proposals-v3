---
title: "Aave V3 Mantle – XAUt Listing"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-aave-v3-mantle-collateral-enablement-emode-expansion-and-isolation-updates-usdt0-usde-eth-xaut/24153"
---

## Simple Summary

This AIP lists XAUt (Tether Gold) on Aave V3 Mantle as a non-borrowable asset, usable as collateral exclusively within a dedicated XAUt/stablecoin eMode.

## Motivation

Listing XAUt gives Mantle users exposure to tokenized gold as collateral against stablecoin debt. Parameters follow the Chaos Labs recommendation in the discussion thread; per LlamaRisk, the asset launch is contingent on the Mantle team deploying the committed $5M of XAUt seed liquidity.

XAUt is priced via the Chainlink XAU/USD feed on Mantle ([0x23A1105fd2C26BCc9EA691725Bbda3f5F1bC0b78](https://mantlescan.xyz/address/0x23A1105fd2C26BCc9EA691725Bbda3f5F1bC0b78)). A small seed amount is supplied to the DustBin as part of execution.

## Specification

**XAUt listing:**

| Parameter         | Value           |
| ----------------- | --------------- |
| Borrowable        | No              |
| Collateral (core) | No (eMode only) |
| Supply Cap        | 4,000 XAUt      |
| Reserve Factor    | 20%             |

**New eMode** (borrowables: USDT0, USDC, GHO):

| eMode            | Collateral | LTV | LT  | Liq. Bonus |
| ---------------- | ---------- | --- | --- | ---------- |
| XAUt Stablecoins | XAUt       | 70% | 75% | 6%         |

## References

- Implementation: [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260805_AaveV3Mantle_XAUtListing/AaveV3Mantle_XAUtListing_20260805.sol)
- Tests: [AaveV3Mantle](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260805_AaveV3Mantle_XAUtListing/AaveV3Mantle_XAUtListing_20260805.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-aave-v3-mantle-collateral-enablement-emode-expansion-and-isolation-updates-usdt0-usde-eth-xaut/24153)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
