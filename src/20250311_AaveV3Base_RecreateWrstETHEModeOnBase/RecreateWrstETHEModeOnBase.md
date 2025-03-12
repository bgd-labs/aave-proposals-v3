---
title: "Recreate wrstETH eMode on Base"
author: "BGD Labs @bgdlabs"
discussions: TODO
---

## Simple Summary

Create a new eMode for wrsETH/wstETH and unfreeze wrsETH & LBTC.

## Motivation

Both proposal [263](https://vote.onaave.com/proposal/?proposalId=263&ipfsHash=0x6fba0be9251581b6628c378a8cfef6bba51a0a902528bfc4b0eff92ed14635b8) and [264](https://vote.onaave.com/proposal/?proposalId=264&ipfsHash=0xe8cf37c4fe2b24cbbf6296ff230af6e84185d3749bb8af9c056243bfa1c7188d) proposed listing new assets in combination with creating new eModes.
As Emodes on Aave are accessed via a static id, both proposals specified `eMode 4` which ultimately lead to 264 overwriting part of the 263 config.
In response to that the guardian coordinated an immediate freeze of `LBTC` and `wrsETH`, which prevents unintended usage (e.g. borrowing wstETH against LBTC).
This proposal aims to restore the configuration as it was originally intended by the proposal authors.

## Specification

The proposal will:

- remove wstETH from the borrowable assets on `LBTC_cbBTC` eMode
- remove wrsETH from the collateral assets on `LBTC_cbBTC` eMode
- create a new `rsETH/wstETH` eMode with the following configuration:
  - ltv 92.5 %
  - lt 94.5 %
  - lb 1%
  - borrowable: wstETH
  - collaterals: wrsETH
- unfreeze LBTC and wrsETH

## References

- Implementation: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/e4e94f4b2908df422b49361096c7b0b65952552e/src/20250311_AaveV3Base_RecreateWrstETHEModeOnBase/AaveV3Base_RecreateWrstETHEModeOnBase_20250311.sol)
- Tests: [AaveV3Base](https://github.com/bgd-labs/aave-proposals-v3/blob/e4e94f4b2908df422b49361096c7b0b65952552e/src/20250311_AaveV3Base_RecreateWrstETHEModeOnBase/AaveV3Base_RecreateWrstETHEModeOnBase_20250311.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
