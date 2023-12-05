---
title: "Aave Funding Updates"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-aave-funding-update/15194"
---

## Simple Summary

This AIP aims to consolidate Aave DAO's stablecoin holdings. It is divided into different parts that are detailed below. Part one is depositing DAI into aEthDAI, part two is migrating aDAI and aUSDT into aEthDAI and aEthUSDT, part three bridges assets from Polygon to Mainnet and part four swaps some holdings into GHO.

## Motivation

This proposal intends to ensure the DAO is well capitalised. A separate DAO budget publication will be shared during Q4 2023.

The DAO has sufficient USDC, DAI and USDT deposited across the various instances of Aave Protocol to support existing streams and the AURA purchase 3.

However, with the emergence of new service provider proposal expected, the DAO needs to adjust its stable coin holdings. This publication supports transferring additional funds from Polygon to Mainnet and acquiring GHO on the market to ensure the DAO is well capitalised for the next 6 months. It also aims to move assets from the old V2 to the newer V3 aToken.

## Specification

- Deposit 1M units of DAI from treasury (Aave V3 Ethereum Collector) into Aave v3 Ethereum
- Migrate all aDAI from Aave v2 Ethereum to Aave v3 Ethereum

- Redeem 1.7M USDC from Aave v2 Polygon and bridge to Ethereum treasury
- Redeem 0.5M from Aave v2 Polygon DAI and bridge to Ethereum treasury
- Redeem 0.75M from Aave v2 Polygon USDT and bridge to Ethereum treasury

Swap the following asset holdings to GHO on Ethereum mainnet:

- All available aTUSD that can be redeemed (~175,000 units at time of writing)
- 500k units of DAI held in treasury (received from previous Polygon bridge)
- All available aBUSD (~72,000 units at time of writing)

Swap the following asset holdings on Ethereum treasury to USDC (there is no GHO / ETH oracle thus these tokens cannot be swapped to GHO directly, they are Aave v2 Assets with no Aave v3 equivalent oracle):

- All GUSD (18,464.03)
- All UST (893,257.63)

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b45e67c8547157099895c1c523ddbdc580eb47dd/src/20231102_Multi_AaveFundingUpdates/AaveV2Ethereum_AaveFundingUpdates_20231102.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/b45e67c8547157099895c1c523ddbdc580eb47dd/src/20231102_Multi_AaveFundingUpdates/AaveV2Polygon_AaveFundingUpdates_20231102.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b45e67c8547157099895c1c523ddbdc580eb47dd/src/20231102_Multi_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231102.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b45e67c8547157099895c1c523ddbdc580eb47dd/src/20231102_Multi_AaveFundingUpdates/AaveV2Ethereum_AaveFundingUpdates_20231102.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/b45e67c8547157099895c1c523ddbdc580eb47dd/src/20231102_Multi_AaveFundingUpdates/AaveV2Polygon_AaveFundingUpdates_20231102.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/b45e67c8547157099895c1c523ddbdc580eb47dd/src/20231102_Multi_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231102.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5)
- [Discussion](https://governance.aave.com/t/arfc-aave-funding-update/15194)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
