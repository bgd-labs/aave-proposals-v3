---
title: "Add Fluid Protocol to flashBorrowers on Plasma"
author: "@TokenLogic"
discussions: "https://governance.aave.com/t/direct-to-aip-add-fluid-protocol-to-flashborrowers-on-plasma/23252"
---

## Simple Summary

This proposal includes Fluid Protocol on the Aave v3 Flashborrowers whitelist for Plasma.

## Motivation

Fluid has been a long-standing partner in the Aave ecosystem, providing valuable infrastructure and user interfaces. This publication extends the flashloan fee waiver to include recent Fluid deployment on Plasma.

Further details about Fluid Protocol: https://fluid.io/

## Specification

This proposal aims to implement a single AIP, which will call `addFlashBorrower()` on the `ACL_MANAGER` contract to whitelist `0x352423e2fA5D5c99343d371C9e3bC56C87723Cc7` as an eligible contract.

## References

- Implementation: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251014_AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma/AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma_20251014.sol)
- Tests: [AaveV3Plasma](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20251014_AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma/AaveV3Plasma_AddFluidProtocolToFlashBorrowersOnPlasma_20251014.t.sol)
- Snapshot: Direct-to-AIP
- [Discussion](https://governance.aave.com/t/direct-to-aip-add-fluid-protocol-to-flashborrowers-on-plasma/23252)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
