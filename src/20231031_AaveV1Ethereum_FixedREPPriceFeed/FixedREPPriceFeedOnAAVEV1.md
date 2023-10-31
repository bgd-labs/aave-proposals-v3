---
title: "Fixed REP price feed on AAVE v1"
author: "BGD labs (@bgdlabs)"
discussions: ""
---

## Simple Summary

Replace existing price feed by Chainlink with the fixed price adapter on Aave v1.

## Motivation

Chainlink is planning to shut down its price feed for the `REP` token as it is deprecated. Keeping in mind that the total supply of the `REP` on Aave v1 is less than 100$, we decided to replace the CL oracle by the custom adapter, which will return calculated average price of the token for the period from 01/09/2023 till 31/10/2023.

## Specification

Average `REP` value: 0.0004625695693 ETH

## References

- Implementation: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231031_AaveV2Ethereum_FixedREPPriceFeed/AaveV2Ethereum_FixedREPPriceFeedOnAAVEV1_20231031.sol)
- Tests: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231031_AaveV2Ethereum_FixedREPPriceFeedOnAAVEV1/AaveV1Ethereum_FixedREPPriceFeed_20231031.t)
- [Discussion](TODO)

- [REP / ETH adapter](TODO)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
