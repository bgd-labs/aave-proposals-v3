---
title: "Treasury Management - Polygon v2 to v3 Migration"
author: "TokenLogic"
discussions: "https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248"
---

## Simple Summary

This AIP will migrate all the DAOs assets (except BAL & CRV) held on Polygon v2 to Polygon v3.

## Motivation

The DAO's funds on v2 are to be migrated to v3 as part of a broader effort to migrate funds from v2 to v3 on Polygon.

This AIP will implement the following:

- Withdraw all assets from Aave v2 Polygon
- Deposit assets into Aave v3 Polygon

There are several small unproductive holdings within the Polygon treasury. These assets will also be deposited into Aave v3 to earn yield.

- Deposit Assets held in Treasury into Aave v3

For reference, the Aave Polygon Treasury: [`0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383`](https://polygonscan.com/address/0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)

## Specification

Migrate the following assets from Aave v2 to v3 on the Polygon network.

- [amUSDC](https://polygonscan.com/token/0x1a13f4ca1d028320a707d99520abfefca3998b7f?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amDAI](https://polygonscan.com/token/0x27f8d03b3a2196956ed754badc28d73be8830a6e?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amUSDT](https://polygonscan.com/token/0x60d55f02a771d515e077c9c2403a1ef324885cec?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amWETH](https://polygonscan.com/token/0x28424507fefb6f7f8e9d3860f56504e4e5f5f390?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amWMATIC](https://polygonscan.com/token/0x8df3aad3a84da6b69a4da8aec3ea40d9091b2ac4?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amWBTC](https://polygonscan.com/token/0x5c2ed810328349100a66b82b78a1791b101c9d61?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amGHST](https://polygonscan.com/token/0x080b5bf8f360f624628e0fb961f4e67c9e3c7cf1?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [amLINK](https://polygonscan.com/token/0x0ca2e42e8c21954af73bc9af1213e4e81d6a669a?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)

Deposit funds into Aave v3.

- [wMATIC](https://polygonscan.com/token/0x0d500b1d8e8ef31e21c99d1db9a6444d3adf1270?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)
- [USDC](https://polygonscan.com/token/0x2791bca1f2de4661ed88a30c99a7a9449aa84174?a=0xe8599F3cc5D38a9aD6F3684cd5CEa72f10Dbc383)

## References

- Implementation: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231208_Multi_TreasuryManagementPolygonV2ToV3Migration/AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231208_Multi_TreasuryManagementPolygonV2ToV3Migration/AaveV3Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208.sol)
- Tests: [AaveV2Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231208_Multi_TreasuryManagementPolygonV2ToV3Migration/AaveV2Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208.t.sol), [AaveV3Polygon](https://github.com/bgd-labs/aave-proposals-v3/blob/main/src/20231208_Multi_TreasuryManagementPolygonV2ToV3Migration/AaveV3Polygon_TreasuryManagementPolygonV2ToV3Migration_20231208.t.sol)
- [Snapshot](https://snapshot.org/#/aave.eth/proposal/0x1b816c12b6f547a1982198ffd0e36412390b05828b560c9edee4e8a6903c4882)
- [Discussion](https://governance.aave.com/t/arfc-migrate-consolidate-polygon-treasury/12248/4)

## Disclaimer

TokenLogic receives no payment beyond Aave DAO for the creation of this proposal. TokenLogic is a delegate within the Aave ecosystem.

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
