---
title: "Whitelist X Layer Flash Borrowers"
author: "@TokenLogic"
discussions: TODO
---

## Simple Summary

This AIP registers two X Layer team contracts as approved flash borrowers on the Aave V3 X Layer instance, enabling them to access flash liquidity with zero flash loan fees.

## Motivation

The X Layer team is launching a looping product built on Aave V3 X Layer flash loans. The executor contracts implement the standard Aave `executeOperation` flash loan receiver interface, are wired to the Aave V3 X Layer Pool, and include an owner-controlled pause mechanism with authorized reporters as an operational kill-switch.

Whitelisting these contracts removes the flash loan premium from every loop, improving the pricing of leveraged positions built on Aave V3 X Layer and driving borrowing volume to the instance.

## Specification

The proposal calls `ACLManager.addFlashBorrower` on Aave V3 X Layer for the following contracts:

| Contract         | Address                                                                                                                         |
| ---------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| Flash Borrower A | [0xAF1Fe8819F8e953391447A3fD3f27Db5b13b9f4d](https://www.oklink.com/x-layer/address/0xAF1Fe8819F8e953391447A3fD3f27Db5b13b9f4d) |
| Flash Borrower B | [0x714A871d3B471FF7Ee6A1896B16c5f55884fd910](https://www.oklink.com/x-layer/address/0x714A871d3B471FF7Ee6A1896B16c5f55884fd910) |

Once registered, these contracts are exempt from flash loan fees when sourcing flash liquidity from the Aave V3 X Layer Pool.

## References

- Implementation: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260821_AaveV3XLayer_WhitelistXLayerFlashBorrower/AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821.sol)
- Tests: [AaveV3XLayer](https://github.com/aave-dao/aave-proposals-v3/blob/main/src/20260821_AaveV3XLayer_WhitelistXLayerFlashBorrower/AaveV3XLayer_WhitelistXLayerFlashBorrower_20260821.t.sol)
- [Discussion](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
