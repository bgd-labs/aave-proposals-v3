---
title: "Fixed REP price feed on AAVE v1"
author: "BGD labs (@bgdlabs)"
discussions: "https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/2"
---

## Simple Summary

Replace existing REP/ETH price feed by Chainlink on Aave v1 Ethereum with a fixed price adapter.

## Motivation

The REP asset listed on Aave 1 Ethereum is a legacy one, that long time ago has suffered a token migration.
With a total supply of this legacy `REP` on Aave v1 of less than $100, Chainlink is looking to shut down the REP/ETH price feed, but this can only be done if Aave stops using it.
Consequently, giving the size of the asset and that factually is off-boarded (frozen), we propose to replace the Chainlink price feed by an ad-hoc one that will return a constant value: the average price of the token for the period from 01/09/2023 till 31/10/2023.

## Specification

Average `REP` price to use: 0.0004625695693 ETH

- call `IAaveOracle(AAVE_V1_ORACLE).setAssetSources([0x1985365e9f78359a9B6AD760e32412f4a445E862], [0xc7751400F809cdB0C167F87985083C558a0610F7])` to replace the price feed of the `REP` on Aave v1 Pool.

## References

- Implementation: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231031_AaveV2Ethereum_FixedREPPriceFeed/AaveV2Ethereum_FixedREPPriceFeedOnAAVEV1_20231031.sol)
- Tests: [AaveV1Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231031_AaveV2Ethereum_FixedREPPriceFeedOnAAVEV1/AaveV1Ethereum_FixedREPPriceFeed_20231031.t)
- [Discussion](https://governance.aave.com/t/bgd-technical-maintenance-proposals/15274/2)

- [REP token](https://etherscan.io/address/0x1985365e9f78359a9B6AD760e32412f4a445E862)
- [REP / ETH adapter](https://github.com/bgd-labs/cl-synchronicity-price-adapter/blob/main/src/contracts/RepFixedPriceAdapter.sol)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
