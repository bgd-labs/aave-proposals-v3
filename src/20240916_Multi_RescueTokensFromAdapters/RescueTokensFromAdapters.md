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

The Paraswap debt swap adapters have an emergency method for rescuing tokens stuck in the contract as a failsafe mechanism. Tokens will be transferred to the contract owner upon execution.

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240916_Multi_RescueTokensFromAdapters/AaveV3Ethereum_RescueTokensFromAdapters_20240916.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240916_Multi_RescueTokensFromAdapters/AaveV3Ethereum_RescueTokensFromAdapters_20240916.t.sol), [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20240916_Multi_RescueTokensFromAdapters/AaveV2Ethereum_RescueTokensFromAdapters_20240916.t.sol)
- [Discussion](https://governance.aave.com/t/periphery-contracts-incident-august-28-2024/18821)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
