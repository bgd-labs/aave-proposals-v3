---
title: "Amend Safety Module Emissions"
author: "karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640"
snapshot: "https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d"
---

## Simple Summary

This publication proposes amending daily AAVE emissions across the three Safety Module (SM) categories to support GHO stability.

## Motivation

With the introduction of stkGHO, GHO went through a positive price action and recovered the 1:1 peg.

Since then, however, the price of GHO has been drifting. There is additional risk of GHO being redeemed from the SM and sold in the market. There are currently around 5.2M GHO cooling off from the stkGHO module.

To support the GHO peg and to pave the way for future GHO supply expansion, this publication proposes increasing the daily AAVE emissions going to stkGHO holders.

This publication also proposes to offset this increase in AAVE emissions by reducing the emissions directed to stkAAVE and stkBPT holders. The overall amount of AAVE per day is to remain unchanged.

## Specification

This proposal will implement the following changes to the AAVE emissions across the three SM categories:

| Asset Current        | AAVE/Day | Proposed AAVE/Day |
| -------------------- | -------- | ----------------- |
| stkAAVE              | 385      | 360               |
| stkGHO               | 50       | 100               |
| stkBPT (AAVE/wstETH) | 385      | 360               |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240229_AaveV3Ethereum_AmendSafetyModuleEmissions/AaveV3Ethereum_AmendSafetyModuleEmissions_20240229.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240229_AaveV3Ethereum_AmendSafetyModuleEmissions/AaveV3Ethereum_AmendSafetyModuleEmissions_20240229.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x0f73500d0f65c72482d352080ea9aa0aa92264eb059b8f646cf6f0e86556bc3d)
- [Discussion](https://governance.aave.com/t/arfc-amend-safety-module-emissions/16640)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
