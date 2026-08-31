---
title: "Add X Layer Loop Tool to FlashBorrowers"
author: "@TokenLogic"
discussions: TODO
---

## Simple Summary

This AIP adds the X Layer Loop Tool contracts to the Aave V3 X Layer FlashBorrowers whitelist, allowing them to access flash liquidity without incurring the Aave Flashloan Fee.

## Motivation

X Layer has developed a Loop Tool to simplify position management and looping activity on the Aave V3 X Layer instance. The tool will be integrated into OKX Wallet as a user facing product, allowing users to create leveraged positions on Aave without manually performing multiple supply, borrow and re-supply transactions.

Certain Loop Tool transactions rely on Aave flash liquidity to execute the required position changes. Whitelisting the contracts as FlashBorrowers removes the Flashloan Fee from these transactions, reducing execution costs for users and encouraging greater usage of Aave V3 on X Layer.

The X Layer team has confirmed that the whitelisted contracts will not be used by OKX's / X Layer's own liquidation bots; they are intended solely to support user facing looping and position management activity. This proposal does not change any reserve or risk parameters of the Aave V3 X Layer instance.

## Specification

The payload calls `addFlashBorrower` on the Aave V3 X Layer `ACL_MANAGER` for the following contracts:

| Contract                       | Address                                                                                                                         |
| ------------------------------ | ------------------------------------------------------------------------------------------------------------------------------- |
| X Layer Loop Tool - Test       | [0xAF1Fe8819F8e953391447A3fD3f27Db5b13b9f4d](https://www.oklink.com/x-layer/address/0xAF1Fe8819F8e953391447A3fD3f27Db5b13b9f4d) |
| X Layer Loop Tool - Production | [0x714A871d3B471FF7Ee6A1896B16c5f55884fd910](https://www.oklink.com/x-layer/address/0x714A871d3B471FF7Ee6A1896B16c5f55884fd910) |

Once whitelisted, the Loop Tool contracts are exempt from Flashloan Fees on the Aave V3 X Layer instance.

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260821_AaveV3XLayer_WhitelistXLayerFlashBorrower/AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260821_AaveV3XLayer_WhitelistXLayerFlashBorrower/AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
