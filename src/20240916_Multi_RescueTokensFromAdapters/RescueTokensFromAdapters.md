---
title: "RescueTokensFromAdapters"
author: "Aave Labs"
discussions: "https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821"
---

## Simple Summary

This proposal aims to rescue tokens with value >=$10 from the deprecated Paraswap debt swap adapters. This will be applied across all Aave networks where accumulated token value >=$10.

## Motivation

Due to the previous issue from August 28, 2024 where peripheral contracts used to perform swaps were exploited, we aim to rescue remaining tokens from the deprecated Paraswap debt swap adapters to remove attack vectors and preserve accumulated value.

## Specification

The Paraswap debt swap adapters have an emergency method for rescuing tokens stuck in the contract as a failsafe mechanism. Tokens will be rescued to the contract owner, then transferred to the treasury upon execution.

Summary (values approximate):

V2Ethereum - DEBT_SWAP_ADAPTER ([0x6A6FA664D4Fa49a6a780a1D6143f079f8dd7C33d](https://etherscan.io/address/0x6A6FA664D4Fa49a6a780a1D6143f079f8dd7C33d))

- Owner: [0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A](https://etherscan.io/address/0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A)
- Tokens to rescue:
  - sUSD: $52
  - USDC: $10

V3Ethereum - DEBT_SWAP_ADAPTER ([0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68](https://etherscan.io/address/0x8761e0370f94f68Db8EaA731f4fC581f6AD0Bd68))

- Owner: [0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A](https://etherscan.io/address/0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A)
- Tokens to rescue:
  - USDT: $78
  - crvUSD: $33

V3Ethereum - REPAY_WITH_COLLATERAL_ADAPTER ([0x02e7B8511831B1b02d9018215a0f8f500Ea5c6B3](https://etherscan.io/address/0x02e7B8511831B1b02d9018215a0f8f500Ea5c6B3))

- Owner: [0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A](https://etherscan.io/address/0x5300A1a15135EA4dc7aD5a167152C01EFc9b192A)
- Tokens to rescue:
  - GHO: $3,120
  - rETH: $31
  - WBTC: $23

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240916_Multi_RescueTokensFromAdapters/AaveV3Ethereum_RescueTokensFromAdapters_20240916.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240916_Multi_RescueTokensFromAdapters/AaveV3Ethereum_RescueTokensFromAdapters_20240916.t.sol), [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240916_Multi_RescueTokensFromAdapters/AaveV2Ethereum_RescueTokensFromAdapters_20240916.t.sol)
- [Discussion](https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
