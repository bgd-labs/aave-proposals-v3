---
title: "Alter mUSD Oracle Price Implementation"
author: "Chaos Labs"
discussions: "https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489"
---

## Simple Summary

This proposal re-enables the supply and borrow caps for MetaMask USD (mUSD) on the Aave v3 Ethereum and Linea deployments while swapping the oracle feed on both networks to a static $1 adapter.

## Motivation

Chaos Labs observed short-lived but material negative deviations in the current mUSD feed, driven by thin liquidity on the reporting venues. Because mUSD is borrow-only on the affected markets, these deviations solely benefit borrowers by letting them accrue liabilities below their true value, exposing the DAO to manipulation and accounting risk. Hardcoding the oracle to a $1 adapter eliminates this tail while keeping the protocol conservative in a genuine depeg: debt remains denominated at par, enabling liquidators to source cheaper mUSD and reducing the likelihood of bad debt. After the Risk Steward temporarily set the caps to 1 to block opportunistic borrowing during the governance process, this payload restores capacity to levels aligned with the forum specification.

## Specification

| Network       | Parameter  | Current                                                                                                       | Proposed                                                                                            |
| ------------- | ---------- | ------------------------------------------------------------------------------------------------------------- | --------------------------------------------------------------------------------------------------- |
| Ethereum Core | Supply Cap | 1 mUSD                                                                                                        | 5,000,000 mUSD                                                                                      |
| Ethereum Core | Borrow Cap | 1 mUSD                                                                                                        | 4,500,000 mUSD                                                                                      |
| Linea         | Supply Cap | 1 mUSD                                                                                                        | 20,000,000 mUSD                                                                                     |
| Linea         | Borrow Cap | 1 mUSD                                                                                                        | 18,000,000 mUSD                                                                                     |
| Ethereum Core | Price Feed | [Capped mUSD / USD](https://etherscan.io/address/0xf22de319901C3b9BAEc7Fa14FdF013Ede40E7312) ($0.99977589)    | [Fixed mUSD / USD](https://etherscan.io/address/0x8adb5187695f773513dec4b569d21db0341931da) ($1)    |
| Linea         | Price Feed | [Capped mUSD / USD](https://lineascan.build/address/0xB8454f3b48395103F23c88B699d4F6A81fD1DCff) ($0.99984807) | [Fixed mUSD / USD](https://lineascan.build/address/0xA77b1C51a76bbB72D17BF467393a540868103097) ($1) |

## References

- Implementation: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f51556cc92ee555aa5ff391a4dc5b923729c015b/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/f51556cc92ee555aa5ff391a4dc5b923729c015b/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204.sol)
- Tests: [AaveV3Ethereum](https://github.com/bgd-labs/aave-proposals-v3/blob/f51556cc92ee555aa5ff391a4dc5b923729c015b/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Ethereum_AlterMUSDOraclePriceImplementation_20251204.t.sol), [AaveV3Linea](https://github.com/bgd-labs/aave-proposals-v3/blob/f51556cc92ee555aa5ff391a4dc5b923729c015b/src/20251204_Multi_AlterMUSDOraclePriceImplementation/AaveV3Linea_AlterMUSDOraclePriceImplementation_20251204.t.sol)
- [Discussion](https://governance.aave.com/t/direct-to-aip-alter-musd-oracle-price-implementation/23489)
- Snapshot: Direct To AIP

## Copyright

Copyright and related rights waived via [CC0](https://creativecommons.org/publicdomain/zero/1.0/).
