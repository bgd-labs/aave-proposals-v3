---
title: "Recreate wrstETH eMode on Base"
author: "BGD Labs @bgdlabs"
discussions: TODO
---

## Simple Summary

Create a new eMode for wrsETH/wstETH and unfreeze wrsETH & LBTC.

## Motivation

## Specification

The proposal will:

- remove wstETH from the borrowable assets on `` eMode
- remove wrsETH from the collateral assets on `` eMode
- create a new `` eMode with the following configuration:
  - ltv 92.5 %
  - lt 94.5 %
  - lb 1%
  - borrowable: wstETH
  - collaterals: wrsETH
- unfreeze LBTC and wrsETH

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250311_AaveV3Base_RecreateWrstETHEModeOnBase/AaveV3Base_RecreateWrstETHEModeOnBase_20250311.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250311_AaveV3Base_RecreateWrstETHEModeOnBase/AaveV3Base_RecreateWrstETHEModeOnBase_20250311.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
