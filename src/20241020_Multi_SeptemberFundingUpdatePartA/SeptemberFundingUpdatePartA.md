---
title: "September Funding Update Part A"
author: "@karpatkey_TokenLogic"
discussions: "https://governance.aave.com/t/arfc-september-funding-update/19162"
---

## Simple Summary

This publication proposes rescuing funds from Paraswap as per the incident in August of 2024, and paying the gas rebate to Karpatkey as guardians.

## Motivation

In response to the events in August of 2024, funds currently locked in the Paraswap adapter contracts on Mainnet will be sent to the Collector. Other chains don't hold enough to justify claiming.

The gas rebate is part of the Aave Guardian Signers as can be found [here](https://governance.aave.com/t/arfc-renewal-of-aave-guardian-2024/17523/32).

## Specification

- Rescue funds held in the Paraswap adapter contracts on Mainnet and send back to Treasury.
- Pay gas rebate to Karpatkey.

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241020_Multi_SeptemberFundingUpdatePartA/AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20241020_Multi_SeptemberFundingUpdatePartA/AaveV2Ethereum_SeptemberFundingUpdatePartA_20241020.t.sol)
- [Snapshot](Direct-to-AIP)
- [Discussion](https://governance.aave.com/t/arfc-september-funding-update/19162)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
