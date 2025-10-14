---
title: "Add Fluid Protocol to flashBorrowers on Plasma"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-add-fluid-protocol-to-flashborrowers-on-plasma/23252"
---

## Simple Summary

This proposal includes Fluid Protocol on the Aave v3 Flashborrowers whitelist for Plasma.

## Motivation

Fluid has been a long-standing partner in the Aave ecosystem, providing valuable infrastructure and user interfaces. This publication extends the flashloan fee waiver to include recent Fluid deployment on Plasma.

Futher details about Fluid Protocol: https://fluid.io/

## Specification

Whitelist Fluid Protocol as part of FlashBorrowers of Aave v3 on Plasma liquidity pools.

//https://plasmascan.to/address/0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7

0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7

This proposal aims to implement an AIP which will call addFlashBorrower() on the ACL_MANAGER contract.

The AIP when implemented grants permission to whitelist any Fluid Protocol contract for all use cases, such as leveraged positions, eMode, debt and collateral swaps, with one exception: no smart-contract that migrates a position outside of the Aave ecosystem is eligible for whitelisting.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251014_AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma/AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma_20251014.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251014_AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma/AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma_20251014.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-fluid-protocol-to-flashborrowers-on-plasma/23252)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
