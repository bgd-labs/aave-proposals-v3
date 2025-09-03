---
title: "Add Fluid Protocol to flashBorrowers"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/arfc-add-fluid-protocol-to-flashborrowers/23007"
snapshot: "https://snapshot.box/#/s:aavedao.eth/proposal/0x5e13f3e63fd9a2d4d00ff9f7915644e48d4b8b35fe03b52a599b4bc1c95914d0"
---

## Simple Summary

This publication proposes including Fluid Protocol on the Aave v3 Flashborrowers whitelist for Polygon and Avalanche.

## Motivation

Fluid has been a long-standing partner in the Aave ecosystem, providing valuable infrastructure and user interfaces. After the recent tokenswap proposal, the Fluid and TokenLogic teams have been able to grow GHO to 80M in user deposits. This publication extends the flashloan fee waiver to include recent Fluid deployments on Avalanche and Polygon.

## Specification

Whitelist Fluid Protocol as part of FlashBorrowers of Aave v3 on Polygon & Avalanche liquidity pools.

- Polygon: [0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7](https://polygonscan.com/address/0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7)
- Avalanche: [0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7](https://snowtrace.io/address/0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7)

This proposal aims to implement a single AIP, utilizing two similar payloads (one for each network), which will call addFlashBorrower() on the ACL_MANAGER contract.

The AIP when implemented grants permission to whitelist any Fluid Protocol contract for all use cases, such as leveraged positions, eMode, debt and collateral swaps, with one exception: no smart-contract that migrates a position outside of the Aave ecosystem is eligible for whitelisting.

## References

- Implementation: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250903_Multi_AddFluidProtocolToFlashBorrowers/AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250903_Multi_AddFluidProtocolToFlashBorrowers/AaveV3Avalanche_AddFluidProtocolToFlashBorrowers_20250903.sol)
- Tests: [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250903_Multi_AddFluidProtocolToFlashBorrowers/AaveV3Polygon_AddFluidProtocolToFlashBorrowers_20250903.t.sol), [AaveV3Avalanche](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20250903_Multi_AddFluidProtocolToFlashBorrowers/AaveV3Avalanche_AddFluidProtocolToFlashBorrowers_20250903.t.sol)
- [Snapshot](https://snapshot.box/#/s:aavedao.eth/proposal/0x5e13f3e63fd9a2d4d00ff9f7915644e48d4b8b35fe03b52a599b4bc1c95914d0)
- [Discussion](https://governance.aave.com/t/arfc-add-fluid-protocol-to-flashborrowers/23007)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
