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

- Deposit 1M units of DAI from Treasury into Aave v3
- Migrate all aDAI from Aave v2 to v3

- Redeem and transfer 1.7M USDC to Ethereum Treasury
- Redeem and transfer 0.5M DAI to Ethereum Treasury
- Redeem and transfer 0.75M USDT to Ethereum Treasury

Swap the following asset holdings to GHO:

- All available aTUSD that can be redeemed (57,373.85 units at time of writing)
- 500k units of DAI held in Treasury (received from Polygon bridge)

Swap the following asset holdings to USDC (there is no GHO / ETH oracle thus these tokens cannot be swapped to GHO directly):

- All GUSD (18,464.03 units at time of writing)
- All UST (893,257.63 units at time of writing)

## References

- Implementation: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231102_Multi_AaveFundingUpdates/AaveV2Ethereum_AaveFundingUpdates_20231102.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231102_Multi_AaveFundingUpdates/AaveV2Polygon_AaveFundingUpdates_20231102.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231102_Multi_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231102.sol)
- Tests: [AaveV2Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231102_Multi_AaveFundingUpdates/AaveV2Ethereum_AaveFundingUpdates_20231102.t.sol), [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231102_Multi_AaveFundingUpdates/AaveV2Polygon_AaveFundingUpdates_20231102.t.sol), [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231102_Multi_AaveFundingUpdates/AaveV3Ethereum_AaveFundingUpdates_20231102.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x099f88e1728760952be26fcb8fc99b26c29336e6a109820b391751b108399ee5)
- [Discussion](https://governance.aave.com/t/arfc-aave-funding-update/15194)

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
